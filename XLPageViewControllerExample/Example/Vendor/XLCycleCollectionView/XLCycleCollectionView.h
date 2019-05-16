//
//  XLCycleCollectionView.h
//  XLCycleCollectionViewDemo
//
//  Created by MengXianLiang on 2017/3/6.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLCycleCollectionView : UIView

@property (nonatomic, strong) NSArray<NSString *> *data;

/**
 自动翻页 默认 NO
 */
@property (nonatomic, assign) BOOL autoPage;

@end
