//
//  SpecialUseExampleVC.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/14.
//  Copyright © 2019 xianliang meng. All rights reserved.
//  

#import "SpecialUseExampleVC.h"
#import "CommonPageViewController.h"
#import "CustomTitleCellExampleVC1.h"
#import "ChannelManageExampleVC.h"
#import "MultiLevelExampleVC.h"
#import "ChildViewConflictExampleVC.h"
#import "SwitchByHandExampleVC.h"

@interface SpecialUseExampleVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SpecialUseExampleVC

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

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
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
    cell.textLabel.text = [NSString stringWithFormat:@"%zd、%@",indexPath.row + 1,[self cellTitles][indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0://自定义cell
        {
            CustomTitleCellExampleVC1 *exampleVC = [[CustomTitleCellExampleVC1 alloc] init];
            exampleVC.title = [self cellTitles][indexPath.row];
            [self.navigationController pushViewController:exampleVC animated:true];
        }
            break;
        case 1://频道管理
        {
            ChannelManageExampleVC *exampleVC = [[ChannelManageExampleVC alloc] init];
            exampleVC.title = [self cellTitles][indexPath.row];
            [self.navigationController pushViewController:exampleVC animated:true];
        }
            break;
        case 2://多级嵌套
        {
            MultiLevelExampleVC *exampleVC = [[MultiLevelExampleVC alloc] init];
            exampleVC.title = [self cellTitles][indexPath.row];
            [self.navigationController pushViewController:exampleVC animated:true];
        }
            break;
        case 3://子view冲突
        {
            ChildViewConflictExampleVC *exampleVC = [[ChildViewConflictExampleVC alloc] init];
            exampleVC.title = [self cellTitles][indexPath.row];
            [self.navigationController pushViewController:exampleVC animated:true];
        }
            break;
        case 4://手动切换
        {
            SwitchByHandExampleVC *exampleVC = [[SwitchByHandExampleVC alloc] init];
            exampleVC.title = [self cellTitles][indexPath.row];
            [self.navigationController pushViewController:exampleVC animated:true];
        }
        default:
            break;
    }
}

- (NSArray *)cellTitles {
    return @[
             @"自定义cell",
             @"频道定制",
             @"多级嵌套",
             @"子view滚动冲突",
             @"手动切换"
             ];
}

@end
