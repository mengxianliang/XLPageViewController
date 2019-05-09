//
//  ViewController.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/6.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import "ViewController.h"
#import "ExampleViewController1.h"
#import "ExampleViewController2.h"
#import "ExampleViewController3.h"
#import "ExampleViewController4.h"
#import "ExampleViewController5.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"XLPageViewController";
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [self cellTitles][indexPath.row];
    cell.detailTextLabel.text = [self cellSubtitles][indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            ExampleViewController1 *vc = [[ExampleViewController1 alloc] init];
            vc.title = [self cellTitles][indexPath.row];
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        case 1: {
            ExampleViewController2 *vc = [[ExampleViewController2 alloc] init];
            vc.title = [self cellTitles][indexPath.row];
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        case 2: {
            ExampleViewController3 *vc = [[ExampleViewController3 alloc] init];
            vc.title = [self cellTitles][indexPath.row];
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        case 3: {
            ExampleViewController4 *vc = [[ExampleViewController4 alloc] init];
            vc.title = [self cellTitles][indexPath.row];
            [self.navigationController pushViewController:vc animated:true];
        }
        case 4: {
            ExampleViewController5 *vc = [[ExampleViewController5 alloc] init];
            vc.title = [self cellTitles][indexPath.row];
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        default:
            break;
    }
}

- (NSArray *)cellTitles {
    return @[@"基本样式",@"基本样式",@"Segmented样式",@"Segmented样式",@"基本样式"];
}

- (NSArray *)cellSubtitles {
    return @[@"标题正常显示",@"标题显示在导航栏上",@"标题正常显示",@"标题显示在导航栏上",@"标题居中"];
}

@end
