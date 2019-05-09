//
//  ExampleViewController4.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/9.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import "ExampleViewController4.h"
#import "ExampleTableViewController.h"
#import "XLPageViewController.h"

@interface ExampleViewController4 ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@property (nonatomic, strong) XLPageViewController *pageViewController;

@end

@implementation ExampleViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initPageViewController];
}

- (void)initPageViewController {
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
    //设置标题样式为分段
    config.titleViewStyle = XLPageTitleViewStyleSegmented;
    //分段选择器颜色
    config.segmentedTintColor = [UIColor blackColor];
    //标题缩进
    config.titleViewInsets = UIEdgeInsetsMake(5, 50, 5, 50);
    //在navigationBar上显示标题
    config.showTitleInNavigationBar = true;
    //隐藏底部分割线
    config.hideBottomLine = true;
    
    self.pageViewController = [[XLPageViewController alloc] initWithConfig:config];
    self.pageViewController.view.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    ExampleTableViewController *vc = [[ExampleTableViewController alloc] init];
    vc.title = [self defaultTitles][index];
    return vc;
}

- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    return [self defaultTitles][index];
}

- (NSInteger)pageViewControllerNumberOfPage {
    return [self defaultTitles].count;
}

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
    NSLog(@"选中了index:%zd",index);
}

#pragma mark -
#pragma mark 数据源
- (NSArray *)defaultTitles {
    return @[@"今天",@"是个",@"好日子"];
}

@end
