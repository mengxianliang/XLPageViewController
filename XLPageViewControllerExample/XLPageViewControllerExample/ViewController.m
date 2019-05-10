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
#import "ExampleViewController6.h"
#import "ExampleViewController7.h"

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
    return 60;
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
    cell.detailTextLabel.text = NSStringFromClass([self vcClasses][indexPath.row]);
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class vcClass = [self vcClasses][indexPath.row];
    UIViewController *vc = [[vcClass alloc] init];
    vc.title = [self cellTitles][indexPath.row];
    [self.navigationController pushViewController:vc animated:true];
}

- (NSArray *)cellTitles {
    return @[
             @"基本样式-标题正常显示",
             @"基本样式-标题显示在导航栏上",
             @"Segmented样式-标题正常显示",
             @"Segmented样式-标题显示在导航栏上",
             @"短标题-标题局左",
             @"短标题-标题局中",
             @"短标题-标题局右",
             ];
}

- (NSArray *)vcClasses {
    return @[
             ExampleViewController1.class,
             ExampleViewController2.class,
             ExampleViewController3.class,
             ExampleViewController4.class,
             ExampleViewController5.class,
             ExampleViewController6.class,
             ExampleViewController7.class,
             ];
}

@end
