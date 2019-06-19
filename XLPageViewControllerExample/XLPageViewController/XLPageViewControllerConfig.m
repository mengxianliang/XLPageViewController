//
//  XLPageViewControllerConfig.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/8.
//  Copyright © 2019 xianliang meng. All rights reserved.
//  https://github.com/mengxianliang/XLPageViewController

#import "XLPageViewControllerConfig.h"

@implementation XLPageViewControllerConfig

+  (XLPageViewControllerConfig *)defaultConfig {
    XLPageViewControllerConfig *config = [[XLPageViewControllerConfig alloc] init];
    
    //标题
    config.titleNormalColor = [UIColor grayColor];
    config.titleSelectedColor = [UIColor blackColor];
    config.titleNormalFont = [UIFont systemFontOfSize:18];
    config.titleSelectedFont = [UIFont boldSystemFontOfSize:18];
    config.titleSpace = 10;
    config.titleColorTransition = true;
    
    //标题栏
    config.titleViewInset = UIEdgeInsetsMake(0, 10, 0, 10);
    config.titleViewHeight = 40.0f;
    config.titleViewBackgroundColor = [UIColor clearColor];
    
    //阴影
    config.shadowLineHidden = false;
    config.shadowLineWidth = 30.0f;
    config.shadowLineHeight = 3.0f;
    config.shadowLineColor = [UIColor blackColor];
    config.shadowLineAnimationType = XLPageShadowLineAnimationTypePan;
    
    //底部分割线
    config.separatorLineHidden = false;
    config.separatorLineColor = [UIColor lightGrayColor];
    config.separatorLineHeight = 0.5f;
    
    //分段式标题颜色
    config.segmentedTintColor = [UIColor blackColor];
    
    //标题栏位置
    config.titleViewAlignment = XLPageTitleViewAlignmentLeft;
    
    return config;
}

@end
