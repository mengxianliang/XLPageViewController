//
//  XLPageViewControllerConfig.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/8.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import "XLPageViewControllerConfig.h"

@implementation XLPageViewControllerConfig

+  (XLPageViewControllerConfig *)defaultConfig {
    XLPageViewControllerConfig *config = [[XLPageViewControllerConfig alloc] init];
    config.titleNormalColor = [UIColor grayColor];
    config.titleSelectedColor = [UIColor blackColor];
    config.titleSpace = 10;
    config.titleInsetX = 10;
    config.titleFont = [UIFont systemFontOfSize:18];
    config.bottomLineColor = [UIColor lightGrayColor];
    return config;
}

@end
