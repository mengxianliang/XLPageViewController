//
//  CustomPageTitleCell2.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/14.
//  Copyright © 2019 xianliang meng. All rights reserved.
//

#import "CustomPageTitleCell2.h"

static CGFloat cycleW = 8.0f;
static CGFloat borderW = 2.0f;

@interface CustomPageTitleCell2 ()

@property (nonatomic, strong) UIView *cycle;

@end

@implementation CustomPageTitleCell2

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initCustomCell];
    }
    return self;
}

- (void)initCustomCell {
    self.cycle = [[UIView alloc] init];
    self.cycle.layer.cornerRadius = cycleW/2.0f;
    self.cycle.layer.masksToBounds = true;
    self.cycle.layer.borderWidth = borderW;
    self.cycle.layer.borderColor = [UIColor colorWithRed:225/255.0f green:40/255.0f blue:40/255.0f alpha:1].CGColor;
    [self.contentView addSubview:self.cycle];
}

//设置布局
- (void)layoutSubviews {
    [super layoutSubviews];
    self.cycle.frame = CGRectMake(self.bounds.size.width + 2, 10, cycleW, cycleW);
}

//通过此父类方法配置cell是否被选中
- (void)configCellOfSelected:(BOOL)selected {
    [super configCellOfSelected:selected];
    self.cycle.transform = CGAffineTransformIdentity;
    self.cycle.hidden = !selected;
}

//通过此父类方法配置cell动画 progress0~1
- (void)showAnimationOfProgress:(CGFloat)progress type:(XLPageTitleCellAnimationType)type {
    [super showAnimationOfProgress:progress type:type];
    
    //已选中的item，圆环从大变小
    if (type == XLPageTitleCellAnimationTypeSelected) {
        CGFloat newProgress = 1 - progress;
        newProgress = newProgress <= 0.1 ? 0.1 : newProgress;
        self.cycle.transform = CGAffineTransformMakeScale(newProgress, newProgress);
    }else if (type == XLPageTitleCellAnimationTypeWillSelected){
        //将要选中的item，圆圈从小到大
        self.cycle.hidden = false;
        progress = progress <= 0.1 ? 0.1 : progress;
        self.cycle.transform = CGAffineTransformMakeScale(progress, progress);
    }
}

@end
