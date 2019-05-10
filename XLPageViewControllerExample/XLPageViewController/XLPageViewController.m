//
//  XLPageViewController.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/6.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import "XLPageViewController.h"
#import "XLPageViewControllerUtil.h"
#import "XLPageBasicTitleView.h"
#import "XLPageSegmentedTitleView.h"

typedef NS_ENUM(NSInteger,XLScrollDirection) {
    XLScrollDirectionNone = 0,
    XLScrollDirectionLeft = 1,
    XLScrollDirectionRight = 2,
};

@interface XLPageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource,UIScrollViewDelegate,XLPageTitleViewDataSrouce,XLPageTitleViewDelegate>
//标题
@property (nonatomic, strong) XLPageBasicTitleView *titleView;
//分页控制器
@property (nonatomic, strong) UIPageViewController *pageVC;
//显示过的vc数组，用于试图控制器缓存
@property (nonatomic, strong) NSMutableArray *shownVCArr;
//是否加载了pageVC
@property (nonatomic, assign) BOOL haveLoadedPageVC;
//滚动方向
@property (nonatomic, assign) XLScrollDirection scrollDirection;
//当前配置信息
@property (nonatomic, strong) XLPageViewControllerConfig *config;
@end

@implementation XLPageViewController

#pragma mark -
#pragma mark 初始化方法
- (instancetype)initWithConfig:(XLPageViewControllerConfig *)config {
    if (self = [super init]) {
        [self initUIWithConfig:config];
        [self initData];
    }
    return self;
}

- (void)initUIWithConfig:(XLPageViewControllerConfig *)config {
    //保存配置
    self.config = config;
    
    //防止Navigation引起的缩进
    UIView *topView = [[UIView alloc] init];
    [self.view addSubview:topView];
    
    //创建标题
    self.titleView = [[XLPageBasicTitleView alloc] initWithConfig:config];
    if (config.titleViewStyle == XLPageTitleViewStyleSegmented) {
        self.titleView = [[XLPageSegmentedTitleView alloc] initWithConfig:config];
    }
    self.titleView.dataSource = self;
    self.titleView.delegate = self;
    [self.view addSubview:self.titleView];
    
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

//设置titleView位置
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.config.showTitleInNavigationBar) {
        self.parentViewController.navigationItem.titleView = self.titleView;
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.titleView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.config.titleViewHeight);
    
    _pageVC.view.frame = CGRectMake(0, self.config.titleViewHeight, self.view.bounds.size.width, self.view.bounds.size.height - self.config.titleViewHeight);
    
    if (self.config.showTitleInNavigationBar) {
        _pageVC.view.frame = self.view.bounds;
    }
    
    //自动选中当前位置_selectedIndex
    if (!self.haveLoadedPageVC) {
        [self switchToViewControllerAdIndex:_selectedIndex animated:false];
    }
}

#pragma mark -
#pragma mark UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    //如果向左滚动，当前位置-1
    if (self.scrollDirection == XLScrollDirectionLeft) {
        _selectedIndex = _selectedIndex <= 0 ? 0 : _selectedIndex - 1;
    }
    //如果向右滚动，当前位置+1
    if (self.scrollDirection == XLScrollDirectionRight) {
        _selectedIndex = _selectedIndex >= [self numberOfPage] - 1 ? [self numberOfPage] - 1 : _selectedIndex + 1;
    }
    //标题居中
    self.titleView.selectedIndex = _selectedIndex;
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
        self.scrollDirection = XLScrollDirectionNone;
    }else if (value < 0) {
        self.scrollDirection = XLScrollDirectionLeft;
    }else if (value > 0) {
        self.scrollDirection = XLScrollDirectionRight;
    }
    self.titleView.animationProgress = value/scrollView.bounds.size.width;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.titleView.stopAnimation = false;
}

#pragma mark -
#pragma mark PageTitleViewDataSource&Delegate
- (NSInteger)pageTitleViewNumberOfTitle {
    return [self numberOfPage];
}

- (NSString *)pageTitleViewTitleForIndex:(NSInteger)index {
    return [self titleForIndex:index];
}

- (void)pageTitleViewDidSelectedAtIndex:(NSInteger)index {
    self.titleView.stopAnimation = true;
    [self switchToViewControllerAdIndex:index animated:true];
    [self delegateSelectedAdIndex:index];
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
    //设置加载标记为已加载
    self.haveLoadedPageVC = true;
    //更新当前位置
    _selectedIndex = index;
    //设置当前展示VC
    [self.pageVC setViewControllers:@[[self viewControllerForIndex:index]] direction:UIPageViewControllerNavigationDirectionForward animated:animated completion:nil];
    //标题居中
    self.titleView.selectedIndex = _selectedIndex;
}

#pragma mark -
#pragma mark 刷新方法
- (void)reloadData {
    [self.titleView reloadData];
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
    UIViewController *vc = [self.dataSource pageViewController:self viewControllerForIndex:index];
    [self.shownVCArr addObject:vc];
    [self addChildViewController:vc];
    return vc;
}

//指定位置的标题
- (NSString *)titleForIndex:(NSInteger)index {
    return [self.dataSource pageViewController:self titleForIndex:index];
}

//总页数
- (NSInteger)numberOfPage {
    return [self.dataSource pageViewControllerNumberOfPage];
}

//执行代理方法
- (void)delegateSelectedAdIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(pageViewController:didSelectedAtIndex:)]) {
        [self.delegate pageViewController:self didSelectedAtIndex:index];
    }
}

@end
