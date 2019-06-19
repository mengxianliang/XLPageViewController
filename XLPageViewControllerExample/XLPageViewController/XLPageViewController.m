//
//  XLPageViewController.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/6.
//  Copyright © 2019 xianliang meng. All rights reserved.
//  https://github.com/mengxianliang/XLPageViewController

#import "XLPageViewController.h"
#import "XLPageBasicTitleView.h"
#import "XLPageSegmentedTitleView.h"

typedef void(^XLContentScollBlock)(BOOL scrollEnabled);

@interface XLPageContentView : UIView

@property (nonatomic, strong) XLContentScollBlock scrollBlock;

@end

@implementation XLPageContentView

//兼容和子view滚动冲突问题
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view =  [super hitTest:point withEvent:event];
    BOOL pageViewScrollEnabled = !view.xl_letMeScrollFirst;
    self.scrollBlock(pageViewScrollEnabled);
    return view;
}

@end


typedef NS_ENUM(NSInteger,XLScrollDirection) {
    XLScrollDirectionNone = 0,
    XLScrollDirectionLeft = 1,
    XLScrollDirectionRight = 2,
};

@interface XLPageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource,UIScrollViewDelegate,XLPageTitleViewDataSrouce,XLPageTitleViewDelegate>

//所有的子视图，都加载在contentView上
@property (nonatomic, strong) XLPageContentView *contentView;
//标题
@property (nonatomic, strong) XLPageBasicTitleView *titleView;
//分页控制器
@property (nonatomic, strong) UIPageViewController *pageVC;
//显示过的vc数组，用于试图控制器缓存
@property (nonatomic, strong) NSMutableArray *shownVCArr;
//是否加载了pageVC
@property (nonatomic, assign) BOOL pageVCDidLoad;
//判断pageVC是否在切换中
@property (nonatomic, assign) BOOL pageVCAnimating;
//滚动方向
@property (nonatomic, assign) XLScrollDirection scrollDirection;
//当前配置信息
@property (nonatomic, strong) XLPageViewControllerConfig *config;

//上一次代理返回的index
@property (nonatomic, assign) NSInteger lastDelegateIndex;

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
    
    //创建contentview
    self.contentView = [[XLPageContentView alloc] init];
    [self.view addSubview:self.contentView];
    __weak typeof(self)weakSelf = self;
    self.contentView.scrollBlock = ^(BOOL scrollEnabled) {
        weakSelf.scrollEnabled = scrollEnabled;
    };
    
    //防止Navigation引起的缩进
    UIView *topView = [[UIView alloc] init];
    [self.contentView addSubview:topView];
    
    //创建标题
    self.titleView = [[XLPageBasicTitleView alloc] initWithConfig:config];
    if (config.titleViewStyle == XLPageTitleViewStyleSegmented) {
        self.titleView = [[XLPageSegmentedTitleView alloc] initWithConfig:config];
    }
    self.titleView.dataSource = self;
    self.titleView.delegate = self;
    [self.contentView addSubview:self.titleView];
    
    //创建PageVC
    self.pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageVC.delegate = self;
    self.pageVC.dataSource = self;
    [self.contentView addSubview:self.pageVC.view];
    [self addChildViewController:self.pageVC];
    //设置ScrollView代理
    for (UIScrollView *scrollView in self.pageVC.view.subviews) {
        if ([scrollView isKindOfClass:[UIScrollView class]]) {
            scrollView.delegate = self;
        }
    }
    
    //默认可以滚动
    self.scrollEnabled = YES;
    
    //初始化上一次返回的index
    self.lastDelegateIndex = -1;
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
    
    //更新contentview位置
    self.contentView.frame = self.view.bounds;
    
    //更新标题位置
    self.titleView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.config.titleViewHeight);
    
    //更新pageVC位置
    self.pageVC.view.frame = CGRectMake(0, self.config.titleViewHeight, self.contentView.bounds.size.width, self.contentView.bounds.size.height - self.config.titleViewHeight);
    
    if (self.config.showTitleInNavigationBar) {
        self.pageVC.view.frame = self.contentView.bounds;
    }
    
    //自动选中当前位置_selectedIndex
    if (!self.pageVCDidLoad) {
        //设置加载标记为已加载
        self.pageVCDidLoad = true;
        [self switchToViewControllerAdIndex:_selectedIndex animated:false];
    }
}

#pragma mark -
#pragma mark UIPageViewControllerDelegate
//滚动切换时调用
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    self.pageVCAnimating = true;
}

//滚动切换时调用
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
    //切换中属性更新
    self.pageVCAnimating = false;
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.titleView.stopAnimation = false;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
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

- (XLPageTitleCell *)pageTitleViewCellForItemAtIndex:(NSInteger)index {
    if ([self.dataSource respondsToSelector:@selector(pageViewController:titleViewCellForItemAtIndex:)]) {
        return [self.dataSource pageViewController:self titleViewCellForItemAtIndex:index];
    }
    return nil;
}

- (BOOL)pageTitleViewDidSelectedAtIndex:(NSInteger)index {
    BOOL switchSuccess = [self switchToViewControllerAdIndex:index animated:true];
    if (!switchSuccess) {
        return false;
    }
    self.titleView.stopAnimation = true;
    [self delegateSelectedAdIndex:index];
    return true;
}

#pragma mark -
#pragma mark Setter
//设置选中位置
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    BOOL switchSuccess = [self switchToViewControllerAdIndex:selectedIndex animated:true];
    if (!switchSuccess) {return;}
    self.titleView.stopAnimation = true;
}

//滑动开关
- (void)setScrollEnabled:(BOOL)scrollEnabled {
    _scrollEnabled = scrollEnabled;
    for (UIScrollView *scrollView in self.pageVC.view.subviews) {
        if ([scrollView isKindOfClass:[UIScrollView class]]) {
            scrollView.scrollEnabled = scrollEnabled;
        }
    }
}

//设置右侧按钮
- (void)setRightButton:(UIButton *)rightButton {
    _titleView.rightButton = rightButton;
}

#pragma mark -
#pragma mark 切换位置方法
- (BOOL)switchToViewControllerAdIndex:(NSInteger)index animated:(BOOL)animated {
    if ([self numberOfPage] == 0) {return NO;}
    //如果正在加载中 返回
    if (self.pageVCAnimating) {return NO;}
    //设置正在加载标记
    BOOL animating = animated && index != _selectedIndex;
    self.pageVCAnimating = animating;
    //更新当前位置
    _selectedIndex = index;
    //设置滚动方向
    UIPageViewControllerNavigationDirection direction = UIPageViewControllerNavigationDirectionForward;
    if (_titleView.lastSelectedIndex > _selectedIndex) {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    //设置当前展示VC
    __weak typeof(self)weakSelf = self;
    [self.pageVC setViewControllers:@[[self viewControllerForIndex:index]] direction:direction animated:animated completion:^(BOOL finished) {
        weakSelf.pageVCAnimating = false;
    }];
    //标题居中
    self.titleView.selectedIndex = _selectedIndex;
    return YES;
}

#pragma mark -
#pragma mark 刷新方法
- (void)reloadData {
    [self.titleView reloadData];
}

#pragma mark -
#pragma mark 自定义方法
- (void)registerClass:(Class)cellClass forTitleViewCellWithReuseIdentifier:(NSString *)identifier {
    [self.titleView registerClass:cellClass forTitleViewCellWithReuseIdentifier:identifier];
}

- (XLPageTitleCell *)dequeueReusableTitleViewCellWithIdentifier:(NSString *)identifier forIndex:(NSInteger)index {
    return [self.titleView dequeueReusableCellWithIdentifier:identifier forIndex:index];
}


#pragma mark -
#pragma mark 辅助方法
//指定位置的视图控制器 缓存方法
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
    vc.title = [self titleForIndex:index];
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
    if (index == self.lastDelegateIndex) {return;}
    self.lastDelegateIndex = index;
    if ([self.delegate respondsToSelector:@selector(pageViewController:didSelectedAtIndex:)]) {
        [self.delegate pageViewController:self didSelectedAtIndex:index];
    }
}

@end
