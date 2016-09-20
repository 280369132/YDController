//
//  HY_sliderButtonView.h
//  汉艺国际
//
//  Created by ios1 on 16/9/12.
//  Copyright © 2016年 HY. All rights reserved.
//

#define selectedColor [UIColor redColor]

#define View_W self.frame.size.width

#import <UIKit/UIKit.h>

@class HY_sliderButtonView;

@protocol HY_sliderButtonViewDelegate <NSObject>

- (void)topSliderView:(HY_sliderButtonView *)topView didSelectedButtonWithIndex:(NSInteger)index;

@end

@interface HY_sliderButtonView : UIView <UIScrollViewDelegate>

@property (nonatomic ,strong) NSArray *titleNames;

@property (nonatomic ,strong) UIButton *selectedButton;

@property (nonatomic ,strong) UIView *bottomLine;

@property (nonatomic ,strong) UIScrollView *topScrollView;

@property (nonatomic ,assign) CGFloat topHeight;

@property (nonatomic ,assign) NSInteger topSelectedIndex;


@property (nonatomic ,assign) id <HY_sliderButtonViewDelegate> topDelegate;


@property (nonatomic ,strong) UIColor *titleColor;

@property (nonatomic ,strong) UIColor *titleSelectedColor;

@property (nonatomic ,strong) UIColor *lineColor;

@property (nonatomic ,strong) UIFont *titleFont;

@property (nonatomic ,strong) UIFont *titleSelectedFont;

@property (nonatomic ,assign) CGSize lineSize;

@property (nonatomic ,assign) NSInteger titlesNum;

@property (nonatomic ,strong) NSMutableArray *buttons;

@end
