//
//  CustomTitleCellExampleVC2.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/14.
//  Copyright © 2019 xianliang meng. All rights reserved.
//

#import "CustomTitleCellExampleVC2.h"
#import "CommonTableViewController.h"
#import "XLPageViewController.h"
#import "CustomPageTitleCell2.h"
#import "XLNavigationController.h"

@interface CustomTitleCellExampleVC2 ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@property (nonatomic, strong) XLPageViewController *pageViewController;

@end

@implementation CustomTitleCellExampleVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    XLNavigationController *nav = (XLNavigationController *)self.navigationController;
    nav.titleColor = [UIColor whiteColor];
    nav.barBackgourndColor = [UIColor colorWithRed:225/255.0f green:40/255.0f blue:40/255.0f alpha:1];
    nav.barTintColor = [UIColor whiteColor];
    nav.statusBarStyle = UIStatusBarStyleLightContent;
    nav.navigationBar.shadowImage = [[UIImage alloc] init];
    
    [self initPageViewController];
}

- (void)initPageViewController {
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
    //隐藏底部阴影
    config.shadowLineHidden = true;
    //设置标题颜色
    config.titleSelectedColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1];
    config.titleNormalColor = [UIColor colorWithRed:119/255.0f green:119/255.0f blue:119/255.0f alpha:1];
    //设置标题间距
    config.titleSpace = 25;
    //设置标题栏缩进
    config.titleViewInset = UIEdgeInsetsMake(0, 15, 0, 15);
    
    self.pageViewController = [[XLPageViewController alloc] initWithConfig:config];
    self.pageViewController.view.frame = self.view.bounds;
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self.pageViewController registerClass:CustomPageTitleCell2.class forTitleViewCellWithReuseIdentifier:@"CustomPageTitleCell2"];
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
    return self.titles[index];
}

- (NSInteger)pageViewControllerNumberOfPage {
    return self.titles.count;
}

- (XLPageTitleCell *)pageViewController:(XLPageViewController *)pageViewController titleViewCellForItemAtIndex:(NSInteger)index {
    CustomPageTitleCell2 *cell = [pageViewController dequeueReusableTitleViewCellWithIdentifier:@"CustomPageTitleCell2" forIndex:index];
    cell.textLabel.text = [self titles][index];
    return cell;
}

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
    NSLog(@"切换到了：%@",[self titles][index]);
}

#pragma mark -
#pragma mark 标题数据
- (NSArray *)titles {
    return @[@"关注",@"头条",@"视频",@"娱乐",@"体育",@"新时代",@"要闻",@"段子",@"知否",@"北京",@"公开课",@"讲讲"];
}

@end
