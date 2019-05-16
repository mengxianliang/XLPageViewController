//
//  XLChannelControl.m
//  XLChannelControlDemo
//
//  Created by MengXianLiang on 2017/3/3.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "XLChannelControl.h"
#import "XLChannelView.h"

@interface XLChannelControl ()

@property (nonatomic, strong) UINavigationController *nav;

@property (nonatomic, strong) XLChannelView *channelView;

@property (nonatomic, strong) XLChannelBlock block;

@end

@implementation XLChannelControl

+(XLChannelControl*)shareControl{
    static XLChannelControl *control = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        control = [[XLChannelControl alloc] init];
    });
    return control;
}

- (instancetype)init {
    if (self = [super init]) {
        [self buildChannelView];
    }
    return self;
}

- (void)buildChannelView {
    
    self.channelView = [[XLChannelView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.nav = [[UINavigationController alloc] initWithRootViewController:[UIViewController new]];
    self.nav.navigationBar.tintColor = [UIColor blackColor];
    self.nav.topViewController.title = @"频道管理";
    self.nav.topViewController.view = self.channelView;
    self.nav.topViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(backMethod)];
}

- (void)backMethod {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.nav.view.frame;
        frame.origin.y = - self.nav.view.bounds.size.height;
        self.nav.view.frame = frame;
    }completion:^(BOOL finished) {
        [self.nav.view removeFromSuperview];
    }];
    self.block(self.channelView.enabledTitles,self.channelView.disabledTitles);
}

- (void)showChannelViewWithEnabledTitles:(NSArray*)enabledTitles disabledTitles:(NSArray*)disabledTitles finish:(XLChannelBlock)block {
    self.block = block;
    self.channelView.enabledTitles = [NSMutableArray arrayWithArray:enabledTitles];
    self.channelView.disabledTitles = [NSMutableArray arrayWithArray:disabledTitles];
    [self.channelView reloadData];

    CGRect frame = self.nav.view.frame;
    frame.origin.y = - self.nav.view.bounds.size.height;
    self.nav.view.frame = frame;
    self.nav.view.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:self.nav.view];
    [UIView animateWithDuration:0.3 animations:^{
        self.nav.view.alpha = 1;
        self.nav.view.frame = [UIScreen mainScreen].bounds;
    }];
}

@end
