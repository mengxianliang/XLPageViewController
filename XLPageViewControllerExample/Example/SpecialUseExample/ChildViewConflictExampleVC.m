//
//  ChildViewConflictExampleVC.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/16.
//  Copyright © 2019 xianliang meng. All rights reserved.
//

#import "ChildViewConflictExampleVC.h"
#import "CommonTableViewController.h"
#import "XLPageViewController.h"

@interface ChildViewConflictExampleVC ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@property (nonatomic, strong) XLPageViewController *pageViewController;

@end

@implementation ChildViewConflictExampleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initPageViewController];
}

- (void)initPageViewController {
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
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
    CommonTableViewController *vc = [[CommonTableViewController alloc] init];
    vc.headerView = [self tableHeaderView];
    return vc;
}

//测试的headerview
- (UIView *)tableHeaderView {
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, header.bounds.size.width - 100, 35)];
    //设置"让我先滚"属性，可避免和子view冲突
    slider.xl_letMeScrollFirst = true;
    slider.center = header.center;
    [header addSubview:slider];
    return header;
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
    return @[@"关注",@"推荐",@"热点",@"问答",@"科技",@"国风",@"直播",@"新时代",@"北京",@"国际",@"数码",@"小说",@"军事"];
}

@end
