//
//  ExampleViewController5.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/9.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import "ExampleViewController5.h"
#import "ExampleTableViewController.h"
#import "XLPageViewController.h"

@interface ExampleViewController5 ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@property (nonatomic, strong) XLPageViewController *pageViewController;

@end

@implementation ExampleViewController5

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initPageViewController];
}

- (void)initPageViewController {
    
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
    //标题缩进
    config.titleViewInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    //标题居中
    config.titleViewAlignment = XLPageTitleViewAlignmentCenter;
    
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
