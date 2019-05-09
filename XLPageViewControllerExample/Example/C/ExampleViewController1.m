//
//  ExampleViewController1.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/8.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import "ExampleViewController1.h"
#import "ExampleTableViewController.h"
#import "XLPageViewController.h"

@interface ExampleViewController1 ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@property (nonatomic, strong) XLPageViewController *pageViewController;

@property (nonatomic, strong) NSArray *vcTitleArr;

@end

@implementation ExampleViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initPageViewController];
    [self addSwitchButton];
}

- (void)initPageViewController {
    self.vcTitleArr = [self defaultTitles];
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
    self.pageViewController = [[XLPageViewController alloc] initWithConfig:config];
    self.pageViewController.view.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
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
    return @[@"今天",@"是个",@"好日子",@"心想的",@"事儿",@"都能成",@"明天",@"是个",@"好日子",@"打开了家门",@"咱迎春风",@"~~~"];
}

- (NSArray *)newVCTitles {
    return @[@"标题1",@"标题2",@"标题3",@"标题4",@"标题5",@"标题6",@"标题7",@"标题8",@"标题9",@"标题10",@"标题11",@"标题12",@"标题13",@"标题14",@"标题15"];
}

- (void)switchTitleMethod:(UIButton *)button {
    button.selected  = !button.selected;
    if (button.selected) {
        self.vcTitleArr = [[NSMutableArray alloc] initWithArray:[self newVCTitles]];
    }else {
        self.vcTitleArr = [[NSMutableArray alloc] initWithArray:[self defaultTitles]];
    }
    [self.pageViewController reloadData];
    self.pageViewController.selectedIndex = 0;
}

@end
