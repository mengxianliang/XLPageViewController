//
//  XLPageViewControllerConfig.h
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/8.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XLPageTitleViewStyle) {
    XLPageTitleViewStyleBasic = 0,
    XLPageTitleViewStyleSegmented = 1
};

NS_ASSUME_NONNULL_BEGIN

@interface XLPageViewControllerConfig : NSObject

//标题正常颜色
@property (nonatomic, strong) UIColor *titleNormalColor;

//标题选中颜色
@property (nonatomic, strong) UIColor *titleSelectedColor;

//标题间距
@property (nonatomic, assign) CGFloat titleSpace;

//标题横向缩进
@property (nonatomic, assign) CGFloat titleInsetX;

//标题字体
@property (nonatomic, strong) UIFont *titleFont;

//隐藏底部动画条
@property (nonatomic, assign) BOOL hideAnimationLine;

//隐藏底部分割线
@property (nonatomic, assign) BOOL hideBottomLine;

//底部分割线颜色
@property (nonatomic, strong) UIColor *bottomLineColor;

//是否在NavigationBar上显示标题
@property (nonatomic, assign) BOOL showTitleInNavigationBar;

//标题样式
@property (nonatomic, assign) XLPageTitleViewStyle titleViewStyle;

//分段选择器颜色
@property (nonatomic, strong) UIColor *segmentedTintColor;

//分段选择器和父视图的高度比例 默认1
@property (nonatomic, assign) CGFloat segmentedHeightRadio;

//默认配置
+ (XLPageViewControllerConfig *)defaultConfig;

@end

NS_ASSUME_NONNULL_END
