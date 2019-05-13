//
//  CustomTitleViewCellExampleVC.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/13.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import "CustomTitleViewCellExampleVC.h"
#import "ExampleTableViewController.h"
#import "XLPageViewController.h"
#import "CustomPageTitleViewCell.h"

@interface CustomTitleViewCellExampleVC ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@property (nonatomic, strong) XLPageViewController *pageViewController;

@end

@implementation CustomTitleViewCellExampleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initPageViewController];
}

- (void)initPageViewController {
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
    config.titleWidth = 50;
    config.titleViewHeight = 45;
    config.titleViewInset = UIEdgeInsetsMake(5, 10, 5, 10);
    
    self.pageViewController = [[XLPageViewController alloc] initWithConfig:config];
    self.pageViewController.view.frame = self.view.bounds;
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self.pageViewController registerClass:CustomPageTitleViewCell.class forTitleViewCellWithReuseIdentifier:@"CustomPageTitleViewCell"];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    ExampleTableViewController *vc = [[ExampleTableViewController alloc] init];
    vc.title = self.titles[index];
    return vc;
}

- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    return self.titles[index];
}

- (NSInteger)pageViewControllerNumberOfPage {
    return self.titles.count;
}

- (XLPageTitleViewCell *)pageViewController:(XLPageViewController *)pageViewController titleViewCellForItemAtIndex:(NSInteger)index {
    CustomPageTitleViewCell *cell = [pageViewController dequeueReusableTitleViewCellWithIdentifier:@"CustomPageTitleViewCell" forIndex:index];
    cell.title = [self titles][index];
    cell.subtitle = [self subTitles][index];
    return cell;
}

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
    NSLog(@"切换到了：%@",[self titles][index]);
}

#pragma mark -
#pragma mark 标题数据
- (NSArray *)titles {
    return @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
}

- (NSArray *)subTitles {
    return @[@"1月1日",@"1月2日",@"1月3日",@"1月4日",@"1月5日",@"1月6日",@"1月7日"];
}

@end
