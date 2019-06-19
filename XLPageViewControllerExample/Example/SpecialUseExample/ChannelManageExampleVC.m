//
//  ChannelManagExampleVC.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/14.
//  Copyright © 2019 xianliang meng. All rights reserved.
//

#import "ChannelManageExampleVC.h"
#import "CommonTableViewController.h"
#import "XLPageViewController.h"
#import "XLChannelControl.h"

@interface ChannelManageExampleVC ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@property (nonatomic, strong) XLPageViewController *pageViewController;

@property (nonatomic, strong) NSArray *enabledTitles;

@property (nonatomic, strong) NSArray *disabledTitles;;

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
    //初始化数据，配置默认已订阅和为订阅的标题数组
    self.enabledTitles = [self enableTitles];
    self.disabledTitles = [self disableTitles];
    //刷新分页控制器
    [self.pageViewController reloadData];
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    CommonTableViewController *vc = [[CommonTableViewController alloc] init];
    return vc;
}

- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    return self.enabledTitles[index];
}

- (NSInteger)pageViewControllerNumberOfPage {
    return self.enabledTitles.count;
}

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
    NSLog(@"切换到了：%@",[self enabledTitles][index]);
}

#pragma mark -
#pragma mark 标题数据

//使用中的标题
- (NSArray *)enableTitles {
    return @[@"要闻",@"河北",@"财经",@"娱乐",@"体育",@"社会",@"NBA",@"视频",@"汽车",@"图片",@"科技",@"军事",@"国际",@"数码",@"星座",@"电影",@"时尚",@"文化",@"游戏",@"教育",@"动漫",@"政务",@"纪录片",@"房产",@"佛学",@"股票",@"理财"];
    
}

//未使用的标题
- (NSArray *)disableTitles {
    return @[@"有声",@"家居",@"电竞",@"美容",@"电视剧",@"搏击",@"健康",@"摄影",@"生活",@"旅游",@"韩流",@"探索",@"综艺",@"美食",@"育儿"];
}

#pragma mark -
#pragma mark 频道管理方法
- (void)channelManage {
    [[XLChannelControl shareControl] showChannelViewWithEnabledTitles:self.enabledTitles disabledTitles:self.disabledTitles finish:^(NSArray *enabledTitles, NSArray *disabledTitles) {
        self.enabledTitles = enabledTitles;
        self.disabledTitles = disabledTitles;
        //第一步，先刷新数据
        [self.pageViewController reloadData];
        //第二步，更新选中位置，这里固定为0，可根据自己的业务逻辑，自行设定
        self.pageViewController.selectedIndex = 0;
    }];
}

@end
