//
//  XLPageViewControllerUtil.h
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/8.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLPageViewControllerUtil : NSObject

//文字宽度
+ (CGFloat)widthForText:(NSString *)text font:(UIFont *)font size:(CGSize)size;

//颜色过渡
+ (UIColor *)colorTransformFrom:(UIColor*)fromColor to:(UIColor *)toColor progress:(CGFloat)progress;

@end

NS_ASSUME_NONNULL_END
