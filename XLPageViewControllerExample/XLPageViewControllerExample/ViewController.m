//
//  ViewController.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/6.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import "ViewController.h"
#import "XLPageViewController.h"
#import "ExampleTableViewController.h"

@interface ViewController ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@property (nonatomic, strong) XLPageViewController *pageViewController;

@property (nonatomic, strong) NSArray *vcTitleArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPageViewController];
    [self addSwitchButton];
}

- (void)initPageViewController {
    self.vcTitleArr = [self defaultTitles];
    self.pageViewController = [[XLPageViewController alloc] init];
    self.pageViewController.view.frame = self.view.bounds;
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

- (void)addSwitchButton {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 100, self.view.bounds.size.height - 100, 100, 100)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitle:@"标题组2" forState:UIControlStateNormal];
    [button setTitle:@"标题组1" forState:UIControlStateSelected];
    [button addTarget:self action:@selector(switchTitleMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    ExampleTableViewController *vc = [[ExampleTableViewController alloc] init];
    vc.title = self.vcTitleArr[index];
    return vc;
}

- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    return self.vcTitleArr[index];
}

- (NSInteger)pageViewControllerNumberOfPage {
    return self.vcTitleArr.count;
}

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
    NSLog(@"选中了index:%zd",index);
}

#pragma mark -
#pragma mark 数据源

- (NSArray *)defaultTitles {
    return @[@"vc1",@"vc2",@"vc3",@"vc4",@"vc5",@"vc6",@"vc7"];
}

- (NSArray *)newVCTitles {
    return @[@"vc1",@"111",@"vc2",@"222",@"vc3",@"333",@"vc4",@"444",@"vc5",@"555",@"vc6",@"666",@"vc7",@"777"];
}

- (void)switchTitleMethod:(UIButton *)button {
    button.selected  = !button.selected;
    if (button.selected) {
        self.vcTitleArr = [[NSMutableArray alloc] initWithArray:[self newVCTitles]];
    }else {
        self.vcTitleArr = [[NSMutableArray alloc] initWithArray:[self defaultTitles]];
    }
    self.pageViewController.selectedIndex = 0;
}

@end
