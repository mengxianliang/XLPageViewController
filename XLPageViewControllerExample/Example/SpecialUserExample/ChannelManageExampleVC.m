//
//  ChannelManagExampleVC.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/14.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import "ChannelManageExampleVC.h"
#import "CommonTableViewController.h"
#import "XLPageViewController.h"

@interface ChannelManageExampleVC ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@property (nonatomic, strong) XLPageViewController *pageViewController;

@property (nonatomic, strong) NSArray *titles;

@end

@implementation ChannelManageExampleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initPageViewController];
    [self buildData];
}

- (void)initPageViewController {
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
    
    self.pageViewController = [[XLPageViewController alloc] initWithConfig:config];
    self.pageViewController.view.frame = self.view.bounds;
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    self.pageViewController.rightButton = [self channelManageButton];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

- (UIButton *)channelManageButton {
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(channelManage) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"channelManageButton"] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(5, 7, 5, 7)];
    return button;
}

- (void)buildData {
    self.titles = [self defaultTitles];
    [self.pageViewController reloadData];
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    CommonTableViewController *vc = [[CommonTableViewController alloc] init];
    return vc;
}

- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    return self.titles[index];
}

- (NSInteger)pageViewControllerNumberOfPage {
    return self.titles.count;
}

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
    NSLog(@"切换到了：%@",[self titles][index]);
}

#pragma mark -
#pragma mark 标题数据
- (NSArray *)defaultTitles {
    return @[@"关注",@"推荐",@"热点",@"问答",@"科技",@"国风",@"直播",@"新时代",@"北京",@"国际",@"数码",@"小说",@"军事"];
}

- (NSArray *)unUserTitles {
    return @[];
}

#pragma mark -
#pragma mark 频道管理方法
- (void)channelManage {
    NSLog(@"执行频道管理方法");
}

@end
