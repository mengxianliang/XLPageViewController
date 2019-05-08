//
//  XLPageViewController.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/6.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import "XLPageViewController.h"

typedef NS_ENUM(NSInteger,XLPageScrollsDirection) {
    XLPageScrollsDirectionNone = 0,
    XLPageScrollsDirectionLeft = 1,
    XLPageScrollsDirectionRight = 2,
};

@interface XLPageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource,UIScrollViewDelegate>
//分页控制器
@property (nonatomic, strong) UIPageViewController *pageVC;
//显示过的vc数组，用于试图控制器缓存
@property (nonatomic, strong) NSMutableArray *shownVCArr;
//是否加载了pageVC
@property (nonatomic, assign) BOOL haveLoadedPageVC;
//滚动方向
@property (nonatomic, assign) XLPageScrollsDirection scrollDirection;

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
    //创建PageVC
    self.pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageVC.delegate = self;
    self.pageVC.dataSource = self;
    [self.view addSubview:self.pageVC.view];
    [self addChildViewController:self.pageVC];
    //设置ScrollView代理
    for (UIScrollView *scrollView in self.pageVC.view.subviews) {
        if ([scrollView isKindOfClass:[UIScrollView class]]) {
            scrollView.delegate = self;
        }
    }
}

//初始化vc缓存数组
- (void)initData {
    self.shownVCArr = [[NSMutableArray alloc] init];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _pageVC.view.frame = self.view.bounds;
    //自动选中当前位置_selectedIndex
    if (!self.haveLoadedPageVC) {
        [self switchToViewControllerAdIndex:_selectedIndex animated:false];
    }
}

#pragma mark -
#pragma mark UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    //如果向左滚动，当前位置-1
    if (self.scrollDirection == XLPageScrollsDirectionLeft) {
        _selectedIndex = _selectedIndex <= 0 ? 0 : _selectedIndex - 1;
    }
    //如果向左滚动，当前位置+1
    if (self.scrollDirection == XLPageScrollsDirectionRight) {
        _selectedIndex = _selectedIndex >= [self numberOfPage] - 1 ? [self numberOfPage] - 1 : _selectedIndex + 1;
    }
    //回调代理方法
    [self delegateSelectedAdIndex:_selectedIndex];
}

#pragma mark -
#pragma mark UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    return [self viewControllerForIndex:_selectedIndex - 1];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    return [self viewControllerForIndex:_selectedIndex + 1];
}

#pragma mark -
#pragma mark ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat value = scrollView.contentOffset.x - scrollView.bounds.size.width;
    //判断滚动方向
    if (value == 0) {
        self.scrollDirection = XLPageScrollsDirectionNone;
    }else if (value > 0) {
        self.scrollDirection = XLPageScrollsDirectionRight;
    }else if (value < 0) {
        self.scrollDirection = XLPageScrollsDirectionLeft;
    }
}

#pragma mark -
#pragma mark Setter
//设置选中位置
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    [self switchToViewControllerAdIndex:selectedIndex animated:false];
}

#pragma mark -
#pragma mark 切换位置方法
- (void)switchToViewControllerAdIndex:(NSInteger)index animated:(BOOL)animated {
    if ([self numberOfPage] == 0) {return;}
    _selectedIndex = index;
    self.haveLoadedPageVC = true;
    [self.pageVC setViewControllers:@[[self viewControllerForIndex:index]] direction:UIPageViewControllerNavigationDirectionForward animated:animated completion:nil];
}

#pragma mark -
#pragma mark 辅助方法
//指定位置的视图控制器，有缓存，但没有复用
- (UIViewController *)viewControllerForIndex:(NSInteger)index {
    //如果越界，则返回nil
    if (index < 0 || index >= [self numberOfPage]) {
        return nil;
    }
    
    //获取当前vc和当前标题
    UIViewController *currentVC = self.pageVC.viewControllers.firstObject;
    NSString *currentTitle = currentVC.title;
    NSString *targetTitle = [self titleForIndex:index];
    
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
    if ([self.dataSource respondsToSelector:@selector(pageViewController:viewControllerForIndex:)]) {
        UIViewController *vc = [self.dataSource pageViewController:self viewControllerForIndex:index];
        [self.shownVCArr addObject:vc];
        [self addChildViewController:vc];
        return vc;
    }
    return nil;
}

//指定位置的标题
- (NSString *)titleForIndex:(NSInteger)index {
    if ([self.dataSource respondsToSelector:@selector(pageViewController:titleForIndex:)]) {
        return [self.dataSource pageViewController:self titleForIndex:index];
    }
    return nil;
}

//总共页数
- (NSInteger)numberOfPage {
    if ([self.dataSource respondsToSelector:@selector(pageViewControllerNumberOfPage)]) {
        return [self.dataSource pageViewControllerNumberOfPage];
    }
    return 0;
}

//执行代理方法
- (void)delegateSelectedAdIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(pageViewController:didSelectedAtIndex:)]) {
        [self.delegate pageViewController:self didSelectedAtIndex:index];
    }
}

@end
