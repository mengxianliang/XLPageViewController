//
//  SwitchByHandExampleVC.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/16.
//  Copyright © 2019 xianliang meng. All rights reserved.
//

#import "SwitchByHandExampleVC.h"
#import "CommonTableViewController.h"
#import "XLPageViewController.h"

@interface SwitchByHandExampleVC ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@property (nonatomic, strong) XLPageViewController *pageViewController;

@end

@implementation SwitchByHandExampleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"right"] style:UIBarButtonItemStylePlain target:self action:@selector(switchNext)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"left"] style:UIBarButtonItemStylePlain target:self action:@selector(switchPrevious)];
    
    self.navigationItem.rightBarButtonItems = @[item1,item2];
    
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
    return @[@"关注",@"推荐",@"热点",@"问答",@"科技",@"国风",@"直播",@"新时代",@"北京",@"国际",@"数码",@"小说",@"军事"];
}

#pragma mark -
#pragma mark 切换方法
- (void)switchPrevious {
    NSInteger index = self.pageViewController.selectedIndex;
    index -= 1;
    index = index <= 0 ? 0 : index;
    self.pageViewController.selectedIndex = index;
}

- (void)switchNext {
    NSInteger index = self.pageViewController.selectedIndex;
    index += 1;
    index = index >= [self titles].count - 1 ? [self titles].count - 1 : index;
    self.pageViewController.selectedIndex = index;
}

@end
