//
//  OtherAppExampleListVC.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/10.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import "OtherAppExampleListVC.h"
#import "BasicFounctionExampleVC.h"

@interface OtherAppExampleListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation OtherAppExampleListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildTable];
}

- (void)buildTable {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self cellTitles].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [self cellTitles][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[self cellImageNames][indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BasicFounctionExampleVC *exampleVC = [[BasicFounctionExampleVC alloc] init];
    exampleVC.title = [self cellTitles][indexPath.row];
    exampleVC.config = [self configOfIndexPath:indexPath];
    exampleVC.titles = [self vcTitlesOfIndexPath:indexPath];
    [self.navigationController pushViewController:exampleVC animated:true];
}

- (NSArray *)cellTitles {
    return @[
             @"今日头条",
             @"腾讯新闻",
             @"澎湃新闻",
             @"新浪微博",
             @"美团",
             @"淘宝",
             @"腾讯视频",
             ];
}

- (NSArray *)cellImageNames {
    return @[
             @"icon_jrtt",
             @"icon_txxw",
             @"icon_ppxw",
             @"icon_xlwb",
             @"icon_mt",
             @"icon_tb",
             @"icon_txsp"
             ];
}

- (XLPageViewControllerConfig *)configOfIndexPath:(NSIndexPath *)indexPath {
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
    switch (indexPath.row) {
        case 0:
            //标题缩进
            config.titleViewInsets = UIEdgeInsetsMake(0, 10, 0, 10);
            break;
        case 1:
            //在导航栏中显示标题
            config.showTitleInNavigationBar = true;
            //隐藏底部分割线
            config.hideBottomLine = true;
            break;
        case 2:
            //设置标题样式为分段
            config.titleViewStyle = XLPageTitleViewStyleSegmented;
            //分段选择器颜色
            config.segmentedTintColor = [UIColor blackColor];
            //标题缩进
            config.titleViewInsets = UIEdgeInsetsMake(5, 50, 5, 50);
            break;
        case 3:
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
            break;
        case 4:
            //标题缩进
            config.titleViewInsets = UIEdgeInsetsMake(0, 10, 0, 10);
            //标题左对齐
            config.titleViewAlignment = XLPageTitleViewAlignmentLeft;
            break;
        case 5:
            //标题缩进
            config.titleViewInsets = UIEdgeInsetsMake(0, 10, 0, 10);
            //标题居中显示
            config.titleViewAlignment = XLPageTitleViewAlignmentCenter;
            break;
        case 6:
            //标题缩进
            config.titleViewInsets = UIEdgeInsetsMake(0, 10, 0, 10);
            //标题右对齐
            config.titleViewAlignment = XLPageTitleViewAlignmentRight;
            break;
        case 7:
            //设置标题宽度为屏幕宽度1/3
            config.titleWidth = self.view.bounds.size.width/3.0f;
            //设置标题间隔为0
            config.titleSpace = 0;
            break;
        default:
            break;
    }
    return config;
}

- (NSArray *)vcTitlesOfIndexPath:(NSIndexPath *)indexPath {
    NSArray *titleArr = @[@"今天",@"是个",@"好日子",@"心想的",@"事儿",@"都能成",@"明天",@"是个",@"好日子",@"打开了家门",@"咱迎春风",@"~~~"];
    if (indexPath.row > 1) {
        titleArr = @[@"今天",@"是个",@"好日子"];
    }
    return titleArr;
}

@end
