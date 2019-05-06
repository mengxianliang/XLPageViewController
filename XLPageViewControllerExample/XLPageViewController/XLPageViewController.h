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

- (NSArray *)pageViewControllerTitles;

@end

@interface XLPageViewController : UIViewController

@property (nonatomic, weak) id <XLPageViewControllerDelegate> delegate;

@property (nonatomic, weak) id <XLPageViewControllerDataSrouce> dataSource;

/**
 当前位置 默认是0
 */
@property (nonatomic, assign) NSInteger selectedIndex;

@end

NS_ASSUME_NONNULL_END
