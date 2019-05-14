//
//  CommonPageViewController.h
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/10.
//  Copyright © 2019 jwzt. All rights reserved.
//  基础功能展示

#import <UIKit/UIKit.h>
#import "XLPageViewControllerConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommonPageViewController : UIViewController

@property (nonatomic, strong) XLPageViewControllerConfig *config;

@property (nonatomic, strong) NSArray *titles;

@end

NS_ASSUME_NONNULL_END
