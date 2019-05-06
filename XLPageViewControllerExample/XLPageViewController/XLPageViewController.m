//
//  XLPageViewController.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/6.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import "XLPageViewController.h"

@interface XLPageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>
//分页控制器
@property (nonatomic, strong) UIPageViewController *pageVC;
//显示过的vc数组，用于试图控制器缓存
@property (nonatomic, strong) NSMutableArray *shownVCArr;

@property (nonatomic, assign) BOOL haveLoadedPageVC;

@end

@implementation XLPageViewController

#pragma mark -
#pragma mark 初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}

- (void)initUI {
    self.pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageVC.delegate = self;
    self.pageVC.dataSource = self;
    [self.view addSubview:self.pageVC.view];
    [self addChildViewController:self.pageVC];
}

- (void)initData {
    self.shownVCArr = [[NSMutableArray alloc] init];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _pageVC.view.frame = self.view.bounds;
    if (!self.haveLoadedPageVC) {
        self.haveLoadedPageVC = true;
        self.selectedIndex = 0;
    }
}

#pragma mark -
#pragma mark UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    UIViewController *currentVC = pageViewController.viewControllers.firstObject;
    NSString *currentTitle = currentVC.title;
    NSInteger index = [self.vcTitles indexOfObject:currentTitle];
    //保存当前位置
    _selectedIndex = index;
    //回调代理方法
    if ([self.delegate respondsToSelector:@selector(pageViewController:didSelectedAtIndex:)]) {
        [self.delegate pageViewController:self didSelectedAtIndex:index];
    }
}

#pragma mark -
#pragma mark UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.vcTitles indexOfObject:viewController.title];
    return [self viewControllerForIndex:index - 1];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.vcTitles indexOfObject:viewController.title];
    return [self viewControllerForIndex:index + 1];
}

#pragma mark -
#pragma mark Setter
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self switchToViewControllerAdIndex:selectedIndex animated:false];
}

#pragma mark -
#pragma mark 切换位置方法
- (void)switchToViewControllerAdIndex:(NSInteger)index animated:(BOOL)animated {
    if ([self vcTitles].count == 0) {return;}
    [self.pageVC setViewControllers:@[[self viewControllerForIndex:index]] direction:UIPageViewControllerNavigationDirectionForward animated:animated completion:nil];
}

#pragma mark -
#pragma mark 辅助方法
//获取视图控制器
- (UIViewController *)viewControllerForIndex:(NSInteger)index {
    //如果越界，则返回nil
    if (index < 0 || index >= self.vcTitles.count) {
        return nil;
    }
    
    //获取当前vc和当前标题
    UIViewController *currentVC = self.pageVC.viewControllers.firstObject;
    NSString *currentTitle = currentVC.title;
    NSString *targetTitle = self.vcTitles[index];
    
    //如果和当前位置一样，则返回当前vc
    if ([currentTitle isEqualToString:targetTitle]) {
        return currentVC;
    }
    
    //如果之前显示过，则从内存中读取
    for (UIViewController *vc in self.shownVCArr) {
        if ([vc.title isEqualToString:targetTitle]) {
            return vc;
        }
    }
    
    //如果之前没显示过，则通过dataSource创建
    if (![self.dataSource respondsToSelector:@selector(pageViewController:viewControllerForIndex:)]) {
        return currentVC;
    }
    UIViewController *targetVC = [self.dataSource pageViewController:self viewControllerForIndex:index];
    [self.shownVCArr addObject:targetVC];
    [self addChildViewController:targetVC];
    return targetVC;
}

- (NSArray *)vcTitles {
    if (![self.dataSource respondsToSelector:@selector(pageViewControllerTitles)]) {
        return @[];
    }
    return [self.dataSource pageViewControllerTitles];
}

@end
