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
    
    //设置基本标题样式属性
    config.titleNormalColor = [UIColor grayColor];
    config.titleSelectedColor = [UIColor blackColor];
    config.titleSpace = 10;
    config.titleFont = [UIFont systemFontOfSize:18];
    config.titleViewHeight = 40.0f;
    
    //标题内容缩进 通用
    config.titleViewInsets = UIEdgeInsetsZero;
    
    //动画条
    config.hideAnimationLine = false;
    config.animationLineWidth = 30.0f;
    config.animationLineHeight = 3.0f;
    
    //底部分割线
    config.hideBottomLine = false;
    config.bottomLineColor = [UIColor lightGrayColor];
    config.bottomLineHeight = 0.5f;
    
    //分段式标题颜色
    config.segmentedTintColor = [UIColor blackColor];
    
    //标题位置
    config.titleViewAlignment = XLPageTitleViewAlignmentLeft;
    
    return config;
}

@end
