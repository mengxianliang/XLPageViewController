//
//  XLPageViewController.h
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/6.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLPageViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol XLPageViewControllerDelegate <NSObject>

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index;

@end

@protocol XLPageViewControllerDataSrouce <NSObject>

- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index;

@end

@interface XLPageViewController : UIViewController

@property (nonatomic, weak) id <XLPageViewControllerDelegate> delegate;

@property (nonatomic, weak) id <XLPageViewControllerDataSrouce> dataSource;

/**
 要显示的标题
 */
@property (nonatomic, strong) NSArray *titles;

/**
 当前位置
 */
@property (nonatomic, assign) NSInteger index;

@end

NS_ASSUME_NONNULL_END
