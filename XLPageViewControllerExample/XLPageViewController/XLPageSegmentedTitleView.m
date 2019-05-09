//
//  XLPageSegmentedTitleView.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/9.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import "XLPageSegmentedTitleView.h"
#import "XLPageViewControllerUtil.h"

@interface XLPageSegmentedTitleView ()

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

//配置信息
@property (nonatomic, strong) XLPageViewControllerConfig *config;

//底部分割线
@property (nonatomic, strong) UIView *bottomLine;

//判断是否已经加载了数据
@property (nonatomic, assign) BOOL haveLoadedDataSource;

@end

@implementation XLPageSegmentedTitleView

- (instancetype)initWithConfig:(XLPageViewControllerConfig *)config {
    if (self = [super init]) {
        [self initSegmentedWithConfig:config];
    }
    return self;
}

- (void)initSegmentedWithConfig:(XLPageViewControllerConfig *)config {
    
    self.config = config;
    
    self.segmentedControl = [[UISegmentedControl alloc] init];
    [self.segmentedControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.tintColor = config.segmentedTintColor;
    [self addSubview:self.segmentedControl];
    
    self.bottomLine = [[UIView alloc] init];
    self.bottomLine.backgroundColor = config.bottomLineColor;
    self.bottomLine.hidden = config.hideBottomLine;
    [self addSubview:self.bottomLine];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat segmentH = self.bounds.size.height*self.config.segmentedHeightRadio;
    CGFloat segmentY = (self.bounds.size.height - segmentH)/2.0f;
    CGFloat segmentX = self.config.titleInsetX;
    CGFloat segmentW = self.bounds.size.width - 2*segmentX;
    
    self.segmentedControl.frame = CGRectMake(segmentX, segmentY, segmentW, segmentH);
    
    self.bottomLine.frame = CGRectMake(0, self.bounds.size.height - XLBottomLineHeight, self.bounds.size.width, XLBottomLineHeight);
    
    if (!self.haveLoadedDataSource) {
        [self loadDataSource];
    }
}

//加载分段选择器数据源
- (void)loadDataSource {
    self.haveLoadedDataSource = true;
    for (NSInteger i = 0; i < [self.dataSource pageTitleViewNumberOfTitle]; i++) {
        NSString *title = [self.dataSource pageTitleViewTitleForIndex:i];
        [self.segmentedControl insertSegmentWithTitle:title atIndex:self.segmentedControl.numberOfSegments animated:false];
    }
    self.segmentedControl.selectedSegmentIndex = self.selectedIndex;
}

//切换方法
- (void)segmentValueChanged:(UISegmentedControl *)segmentedControl {
    [self.delegate pageTitleViewDidSelectedAtIndex:segmentedControl.selectedSegmentIndex];
}

#pragma mark -
#pragma mark Setter
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    self.segmentedControl.selectedSegmentIndex = selectedIndex;
}

@end
