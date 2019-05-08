//
//  XLPageViewControllerConfig.h
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/8.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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

//默认配置
+ (XLPageViewControllerConfig *)defaultConfig;

@end

NS_ASSUME_NONNULL_END
