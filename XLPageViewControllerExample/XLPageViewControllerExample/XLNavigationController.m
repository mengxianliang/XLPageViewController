//
//  XLNavigationController.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/11.
//  Copyright © 2019 xianliang meng. All rights reserved.
//

#import "XLNavigationController.h"

@interface XLNavigationController ()

@end

@implementation XLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;    
}

#pragma mark -
#pragma mark Setter
- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    _statusBarStyle = statusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setTitleColor:(UIColor *)titleColor {
    NSDictionary *attributes = @{NSForegroundColorAttributeName:titleColor};
    [self.navigationBar setTitleTextAttributes:attributes];
}

- (void)setBarTintColor:(UIColor *)barTintColor {
    self.navigationBar.tintColor = barTintColor;
}

- (void)setBarBackgourndColor:(UIColor *)barBackgourndColor {
    for (UIView *view in self.navigationBar.subviews) {
        if ([view isMemberOfClass:NSClassFromString(@"_UIBarBackground")]) {
            view.backgroundColor = barBackgourndColor;
        }
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
