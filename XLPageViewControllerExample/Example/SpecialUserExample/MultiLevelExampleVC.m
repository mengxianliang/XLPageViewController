//
//  MultiLevelExampleVC.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/15.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import "MultiLevelExampleVC.h"
#import "CommonPageViewController.h"
#import "CommonTableViewController.h"
#import "XLPageViewController.h"

@interface MultiLevelExampleVC ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@property (nonatomic, strong) XLPageViewController *pageViewController;

@end

@implementation MultiLevelExampleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initPageViewController];
}

- (void)initPageViewController {
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
    config.shadowLineColor = [UIColor colorWithRed:254/255.0f green:129/255.0f blue:1/255.0f alpha:1];
    config.titleSelectedFont = [UIFont boldSystemFontOfSize:19];
    config.titleNormalFont = [UIFont systemFontOfSize:19];
    config.titleViewAlignment = XLPageTitleViewAlignmentCenter;
    config.showTitleInNavigationBar = true;
    config.separatorLineHidden = true;
    config.shadowLineAnimationType = XLPageShadowLineAnimationTypeZoom;
    config.shadowLineWidth = 40;
    
    self.pageViewController = [[XLPageViewController alloc] initWithConfig:config];
    self.pageViewController.view.frame = self.view.bounds;
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    if (index == 0) {
        CommonTableViewController *vc = [[CommonTableViewController alloc] init];
        return vc;
    }
    CommonPageViewController *vc = [[CommonPageViewController alloc] init];
    vc.titles = @[@"推荐",@"同城",@"榜单",@"明星",@"搞笑",@"吃鸡",@"种草",@"情感",@"社会",@"新时代",@"电竞"];
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
    config.titleSelectedColor = [UIColor colorWithRed:254/255.0f green:129/255.0f blue:1/255.0f alpha:1];
    config.titleNormalColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1];
    config.shadowLineHidden = true;
    config.titleSpace = 20;
    config.titleSelectedFont = [UIFont boldSystemFontOfSize:17];
    config.titleNormalFont = [UIFont systemFontOfSize:17];
    config.titleColorTransition = false;
    vc.config = config;
    return vc;
}

- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    return [self titles][index];
}

- (NSInteger)pageViewControllerNumberOfPage {
    return [self titles].count;
}

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
    NSLog(@"切换到了：%@",[self titles][index]);
}

#pragma mark -
#pragma mark 标题数据
- (NSArray *)titles {
    return @[@"关注",@"热门"];
}


@end
