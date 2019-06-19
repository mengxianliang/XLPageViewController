//
//  CommonPageViewController.h
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/10.
//  Copyright © 2019 xianliang meng. All rights reserved.
//  基础功能展示

#import <UIKit/UIKit.h>
#import "XLPageViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommonPageViewController : UIViewController

//配置信息
@property (nonatomic, strong) XLPageViewControllerConfig *config;

//标题组
@property (nonatomic, strong) NSArray *titles;

@end

NS_ASSUME_NONNULL_END
