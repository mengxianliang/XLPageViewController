//
//  XLPageViewControllerUtil.h
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/8.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static CGFloat XLAnimationLineHeight = 3.0f;

static CGFloat XLAnimationLineWidth = 30.0f;

static CGFloat XLBottomLineHeight = 0.5f;

NS_ASSUME_NONNULL_BEGIN

@interface XLPageViewControllerUtil : NSObject

//文字宽度
+ (CGFloat)widthForText:(NSString *)text font:(UIFont *)font size:(CGSize)size;

//颜色过渡
+ (UIColor *)colorTransformFrom:(UIColor*)fromColor to:(UIColor *)toColor progress:(CGFloat)progress;

+ (UIViewController *)viewControllerOfView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
