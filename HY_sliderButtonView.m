//
//  HY_sliderButtonView.m
//  汉艺国际
//
//  Created by ios1 on 16/9/12.
//  Copyright © 2016年 HY. All rights reserved.
//

#import "HY_sliderButtonView.h"

@interface HY_sliderButtonView ()

@property (nonatomic,strong)UIView *lineView;

@end


@implementation HY_sliderButtonView

- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.topHeight = 40;
        self.backgroundColor = [UIColor whiteColor];
        
        UIScrollView *topScrollView = [[UIScrollView alloc] init];
        topScrollView.delegate = self;
        topScrollView.showsVerticalScrollIndicator = NO;
        topScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:topScrollView];
        self.topScrollView = topScrollView;
        
        //添加底部横线
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor grayColor];
        self.lineView = lineView;
        [self addSubview:lineView];
        
        
    }
    return self;
}

- (void)setTitleNames:(NSArray *)titleNames
{

    _titleNames = titleNames;
    NSInteger count = titleNames.count;
    
    for (int i=0; i<count; i++) {
        UIButton *button = [self addButtonWithTitle:_titleNames[i]];
        button.tag = i;
        if (i == 0) {
            
            [self changeSelectedState:button];
        }

        
        [self.topScrollView addSubview:button];
        [self.buttons addObject:button];
    }
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = selectedColor;
    [self.topScrollView addSubview:bottomLine];
    self.bottomLine = bottomLine;
}

- (UIButton *)addButtonWithTitle:(NSString *)titleName
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:titleName forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:selectedColor forState:UIControlStateSelected];
    [button addTarget:self action:@selector(changeSelectedState:) forControlEvents:UIControlEventTouchUpInside];

    return button;
}

- (void)changeSelectedState:(UIButton *)senderButton
{
    self.selectedButton.selected = NO;
    senderButton.selected = YES;
    self.selectedButton = senderButton;
    
    CGFloat senderX = senderButton.frame.origin.x;
    CGFloat senderW = senderButton.frame.size.width;
    
    CGFloat lineW = self.lineSize.width;
    CGFloat lineH = self.lineSize.height;
    
    if (self.lineSize.height != 0) {
        CGFloat lineX = senderX + (senderW - self.lineSize.width) * 0.5;
        CGFloat lineY = self.topHeight - self.lineSize.height;
        
        self.bottomLine.frame = CGRectMake(lineX, lineY, lineW, lineH);
    }
    else
    {
        self.bottomLine.frame = CGRectMake(senderX, CGRectGetMaxY(senderButton.frame), senderW, 2);
    }
    
    CGPoint point = CGPointMake(senderX, 0);
    CGFloat buttonMaxX = CGRectGetMaxX(senderButton.frame);
    CGFloat buttonMinX = CGRectGetMinX(senderButton.frame);
    CGFloat maxX = (self.titleNames.count + 2) * senderW - View_W;
    
    if (buttonMaxX < maxX && buttonMaxX > View_W) {
        [self.topScrollView setContentOffset:point animated:YES];
    }
    else if (buttonMinX < View_W)
    {
        [self.topScrollView setContentOffset:CGPointZero animated:YES];
    }
    
    self.titleSelectedFont = self.titleSelectedFont;
    for (UIButton *button in self.buttons) {
        if (button.selected == NO) {
            button.titleLabel.font = self.titleFont;
        }
    }
    
    if ([self.topDelegate respondsToSelector:@selector(topSliderView:didSelectedButtonWithIndex:)]) {
        [self.topDelegate topSliderView:self didSelectedButtonWithIndex:senderButton.tag];
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonW;
    NSInteger count = self.buttons.count;
    NSInteger titlesNum = self.titlesNum;
    
    if (titlesNum != 0) {
        buttonW = View_W / titlesNum;
    }
    else {
        if (count <= 5) {
            buttonW = View_W / count;
        }
        else {
            buttonW = View_W / 6 + 5;
        }
    }
    
    CGFloat lineHeight = self.lineSize.height;
    CGFloat lineWidth = self.lineSize.width;
    if (lineHeight == 0) {
        lineHeight = 2;
    }
    if (lineWidth == 0) {
        lineWidth = buttonW;
    }
    
    self.bottomLine.frame = CGRectMake((buttonW - lineWidth) * 0.5, self.topHeight - lineHeight, lineWidth, lineHeight);
    for (int i=0; i<count; i++) {
        UIButton *button = self.buttons[i];
        button.frame = CGRectMake(buttonW * i, 0, buttonW, self.topHeight - lineHeight);
    }
    
    self.topScrollView.frame = CGRectMake(0, 0, View_W, self.topHeight);
    self.topScrollView.contentSize = CGSizeMake(buttonW * count, 0);
    
    CGFloat lineCenterX = self.bottomLine.center.x;
    CGFloat selectedButtonCenterX = self.selectedButton.center.x;
    
    if (lineCenterX != selectedButtonCenterX) {
        self.bottomLine.center = CGPointMake(selectedButtonCenterX, self.bottomLine.center.y);
    }
    
    self.lineView.frame = CGRectMake(10, self.bounds.size.height, [UIScreen mainScreen].bounds.size.width-20, 1);
}

- (void)setTopSelectedIndex:(NSInteger)topSelectedIndex
{
    _topSelectedIndex = topSelectedIndex;
    [self changeSelectedState:self.buttons[topSelectedIndex]];
}

- (CGFloat)topHeight
{
    return CGRectGetHeight(self.frame);
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    for (UIButton *button in self.buttons) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
}

- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor
{
    _titleSelectedColor = titleSelectedColor;
    for (UIButton *button in self.buttons) {
        [button setTitleColor:titleSelectedColor forState:UIControlStateSelected];
    }
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    for (UIButton *button in self.buttons) {
        button.titleLabel.font = titleFont;
    }
}

- (void)setTitleSelectedFont:(UIFont *)titleSelectedFont
{
    _titleSelectedFont = titleSelectedFont;
    for (UIButton *button in self.buttons) {
        if (button.selected == YES) {
            button.titleLabel.font = titleSelectedFont;
        }
    }
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    self.bottomLine.backgroundColor = lineColor;
}


@end

