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

#pragma mark -
#pragma mark TableViewDelegate&DataSource
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    ExampleTableViewController *vc = [[ExampleTableViewController alloc] init];
    vc.title = self.vcTitleArr[index];
    return vc;
}

- (NSArray *)pageViewControllerTitles {
    return self.vcTitleArr;
}

- (NSArray *)defaultTitles {
    return @[@"vc1",@"vc2",@"vc3",@"vc4",@"vc5",@"vc6",@"vc7"];
}

- (NSArray *)newVCTitles {
    return @[@"vc1",@"111",@"vc2",@"222",@"vc3",@"333",@"vc4",@"444",@"vc5",@"555",@"vc6",@"666",@"vc7",@"777"];
}



@end
