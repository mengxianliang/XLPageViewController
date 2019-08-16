//
//  XLNavigationController.h
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/11.
//  Copyright © 2019 xianliang meng. All rights reserved.
//  自定义导航

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLNavigationController : UINavigationController

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

@property (nonatomic, strong) UIColor *barBackgourndColor;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *barTintColor;

@end

NS_ASSUME_NONNULL_END
