//
//  YJTopSliderView.m
//  YJTopSliderViewDemo
//
//  Created by ios2 on 16/9/7.
//  Copyright © 2016年 ios2. All rights reserved.
//

#define selectedColor [UIColor redColor]
#define View_H  self.bounds.size.height

#import "YJTopSliderView.h"

@interface YJTopSliderView ()<HY_sliderButtonViewDelegate,UIScrollViewDelegate>

@property (nonatomic ,strong) UIScrollView *mainScrollView;

@end

@implementation YJTopSliderView

+ (instancetype)topSliderView
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self cerateUI];
    }
    return self;
}

- (void)cerateUI
{
    HY_sliderButtonView *topView = [[HY_sliderButtonView alloc] init];
    topView.topDelegate = self;
    [self addSubview:topView];
    self.topView = topView;
    
    UIScrollView *mainScrollView = [[UIScrollView alloc] init];
    mainScrollView.delegate = self;
    mainScrollView.showsVerticalScrollIndicator = mainScrollView.showsHorizontalScrollIndicator = NO;
    mainScrollView.pagingEnabled = YES;
    [self addSubview:mainScrollView];
    self.mainScrollView = mainScrollView;
}

- (void)setChildViews:(NSArray *)childViews
{
    _childViews = childViews;
    NSInteger count = childViews.count;
    self.mainScrollView.contentSize = CGSizeMake(View_W * count, 0);
    for (int i=0; i<count; i++) {
        UIViewController *childVC = childViews[i];
        childVC.view.frame = CGRectMake(View_W * i, 0, ScreenWidth, View_H - 40);
        [self.mainScrollView addSubview:childVC.view];
    }
}

-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (!selectedIndex) return;
    _selectedIndex = selectedIndex;
    self.topView.topSelectedIndex = selectedIndex;
    [self topSliderView:self.topView didSelectedButtonWithIndex:selectedIndex];
}


- (void)setTopBarHeight:(CGFloat)topBarHeight
{
    if (!topBarHeight) return;
    _topBarHeight = topBarHeight;
    self.topView.frame = CGRectMake(0, 0, View_W, topBarHeight);
}

- (void)setNumberOfTitles:(NSInteger)numberOfTitles
{
    if (!numberOfTitles) return;
    _numberOfTitles = numberOfTitles;
    self.topView.titlesNum = numberOfTitles;
}

- (void)setTitleFont:(UIFont *)titleFont
{
    if (!titleFont) return;
    _titleFont = titleFont;
    self.topView.titleFont = titleFont;
}

- (void)setTitleSelectedFont:(UIFont *)titleSelectedFont
{
    if (!titleSelectedFont) return;
    _titleSelectedFont = titleSelectedFont;
    self.topView.titleSelectedFont = titleSelectedFont;
}

- (void)setTitleColor:(UIColor *)titleColor
{
    if (!titleColor) return;
    _titleColor = titleColor;
    self.topView.titleColor = titleColor;
}

- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor
{
    if (!titleSelectedColor) return;
    _titleSelectedColor = titleSelectedColor;
    self.topView.titleSelectedColor = titleSelectedColor;
}

- (void)setLineSize:(CGSize)lineSize
{
    if (!lineSize.width) return;
    _lineSize = lineSize;
    self.topView.lineSize = lineSize;
}

- (void)setLineColor:(UIColor *)lineColor
{
    if (!lineColor) return;
    _lineColor = lineColor;
    self.topView.lineColor = lineColor;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentIndex = scrollView.contentOffset.x / View_W;
    
    self.topView.topSelectedIndex = currentIndex;
}

- (void)topSliderView:(HY_sliderButtonView *)topView didSelectedButtonWithIndex:(NSInteger)index
{
    CGPoint point = CGPointMake(View_W * index, 0);
    [self.mainScrollView setContentOffset:point animated:YES];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat topViewH = 40;
    if (!self.topBarHeight) {
        self.topView.frame = CGRectMake(0, 0, ScreenWidth, topViewH);
        
    }
    
    CGFloat topViewMaxY = CGRectGetMaxY(self.topView.frame);
    self.mainScrollView.frame = CGRectMake(0, topViewMaxY, ScreenWidth, View_H - topViewMaxY);
}

@end
