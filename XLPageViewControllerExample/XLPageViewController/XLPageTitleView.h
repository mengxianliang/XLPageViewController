//
//  XLPageTitleView.h
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/8.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XLPageTitleViewDataSrouce <NSObject>

@required

/**
 根据index返回对应的标题
 
 @param index 当前位置
 @return 返回要展示的标题
 */
- (NSString *)pageTitleViewTitleForIndex:(NSInteger)index;

/**
 要展示分页数
 
 @return 返回分页数
 */
- (NSInteger)pageTitleViewNumberOfTitle;

@end

@interface XLPageTitleView : UIView

@property (nonatomic, weak) id <XLPageTitleViewDataSrouce> dataSource;

@property (nonatomic, assign) NSInteger selectedIndex;

@end

NS_ASSUME_NONNULL_END
