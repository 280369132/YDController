//
//  YJTopSliderView.h
//  YJTopSliderViewDemo
//
//  Created by ios2 on 16/9/7.
//  Copyright © 2016年 ios2. All rights reserved.
//
#import "HY_sliderButtonView.h"
#import <UIKit/UIKit.h>

@interface YJTopSliderView : UIView

@property (nonatomic ,strong) NSArray *childViews;

@property (nonatomic ,strong) NSArray *topTitles;

@property (nonatomic ,assign) NSInteger selectedIndex;

@property (nonatomic ,assign) NSInteger numberOfTitles;

@property (nonatomic ,assign) CGFloat topBarHeight;

@property (nonatomic ,strong) UIColor *titleColor;

@property (nonatomic ,strong) UIColor *titleSelectedColor;

@property (nonatomic ,strong) UIFont *titleFont;

@property (nonatomic ,strong) UIFont *titleSelectedFont;

@property (nonatomic ,strong) UIColor *lineColor;

@property (nonatomic ,assign) CGSize lineSize;

@property (nonatomic ,strong) HY_sliderButtonView *topView;

+ (instancetype)topSliderView;

@end
