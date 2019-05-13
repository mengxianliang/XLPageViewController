//
//  XLPageViewControllerConfig.h
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/8.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 标题栏样式
 Basic 基本样式
 Segmented 分段样式
 */
typedef NS_ENUM(NSInteger, XLPageTitleViewStyle) {
    XLPageTitleViewStyleBasic = 0,
    XLPageTitleViewStyleSegmented = 1
};

/**
 标题对齐，居左，居中，局右
 */
typedef NS_ENUM(NSInteger, XLPageTitleViewAlignment) {
    XLPageTitleViewAlignmentLeft = 0,
    XLPageTitleViewAlignmentCenter = 1,
    XLPageTitleViewAlignmentRight = 2,
};

/**
 文字垂直对齐，居中，居上，局下
 */
typedef NS_ENUM(NSInteger, XLPageTextVerticalAlignment) {
    XLPageTextVerticalAlignmentCenter = 0,
    XLPageTextVerticalAlignmentTop = 1,
    XLPageTextVerticalAlignmentBottom = 2,
};

/**
 阴影末端形状，圆形、方形
 */
typedef NS_ENUM(NSInteger, XLShadowLineCap) {
    XLShadowLineCapRound = 0,
    XLShadowLineCapSquare = 1,
};

/**
 阴影动画类型，平移、缩放、无动画
 */
typedef NS_ENUM(NSInteger, XLShadowLineAnimationType) {
    XLShadowLineAnimationTypePan = 0,
    XLShadowLineAnimationTypeZoom = 1,
    XLShadowLineAnimationTypeNone = 2,
};


NS_ASSUME_NONNULL_BEGIN

@interface XLPageViewControllerConfig : NSObject

//标题正常颜色 默认 grayColor
@property (nonatomic, strong) UIColor *titleNormalColor;

//标题选中颜色 默认 blackColor
@property (nonatomic, strong) UIColor *titleSelectedColor;

//标题正常字体 默认 标准字体18
@property (nonatomic, strong) UIFont *titleNormalFont;

//标题选中字体 默认 标准粗体18
@property (nonatomic, strong) UIFont *titleSelectedFont;

//标题间距 默认 10
@property (nonatomic, assign) CGFloat titleSpace;

//标题宽度 默认和文字长度保持一致
@property (nonatomic, assign) CGFloat titleWidth;

//文字垂直对齐 默认居中
@property (nonatomic, assign) XLPageTextVerticalAlignment textVerticalAlignment;

//标题栏高度 默认 40
@property (nonatomic, assign) CGFloat titleViewHeight;

//标题内容缩进 默认 UIEdgeInsetsZero
@property (nonatomic, assign) UIEdgeInsets titleViewInsets;

//标题显示位置 默认 XLPageTitleViewAlignmentLeft（只在标题总长度小于屏幕宽度时有效）
@property (nonatomic, assign) XLPageTitleViewAlignment titleViewAlignment;

//隐藏底部阴影 默认 NO
@property (nonatomic, assign) BOOL hideShadowLine;

//阴影高度 默认 3.0f
@property (nonatomic, assign) CGFloat shadowLineHeight;

//阴影宽度 默认 30.0f
@property (nonatomic, assign) CGFloat shadowLineWidth;

//阴影颜色 默认 黑色
@property (nonatomic, strong) UIColor *shadowLineColor;

//阴影末端形状 默认 XLShadowLineCapRound
@property (nonatomic, assign) XLShadowLineCap shadowLineCap;

//默认动画效果 默认 XLShadowLineAnimationTypePan
@property (nonatomic, assign) XLShadowLineAnimationType shadowLineAnimationType;

//隐藏底部分割线 默认 NO
@property (nonatomic, assign) BOOL hideSeparatorLine;

//底部分割线高度 默认 0.5
@property (nonatomic, assign) CGFloat separatorLineHeight;

//底部分割线颜色 默认 lightGrayColor
@property (nonatomic, strong) UIColor *separatorLineColor;

//是否在NavigationBar上显示标题 默认NO
@property (nonatomic, assign) BOOL showTitleInNavigationBar;

//标题样式 默认 XLPageTitleViewStyleBasic
@property (nonatomic, assign) XLPageTitleViewStyle titleViewStyle;

//分段选择器颜色 默认 黑色
@property (nonatomic, strong) UIColor *segmentedTintColor;

//默认配置
+ (XLPageViewControllerConfig *)defaultConfig;

@end

NS_ASSUME_NONNULL_END
