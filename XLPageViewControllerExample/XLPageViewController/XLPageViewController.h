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

/**
 根据index返回对应的ViewController

 @param pageViewController XLPageViewController实例
 @param index 当前位置
 @return 返回要展示的ViewController
 */
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index;

/**
 根据index返回对应的标题

 @param pageViewController XLPageViewController实例
 @param index 当前位置
 @return 返回要展示的标题
 */
- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index;

/**
 要展示分页数

 @return 返回分页数
 */
- (NSInteger)pageViewControllerNumberOfPage;

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
