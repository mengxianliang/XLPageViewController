//
//  CustomPageTitleCell1.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/13.
//  Copyright © 2019 xianliang meng. All rights reserved.
//

#import "CustomPageTitleCell1.h"

@interface CustomPageTitleCell1 ()

//标题label
@property (nonatomic, strong) UILabel *titleLabel;

//副标题
@property (nonatomic, strong) UILabel *subtitleLabel;


@end

@implementation CustomPageTitleCell1

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initCustomCell];
    }
    return self;
}

- (void)initCustomCell {
    //隐藏父视图中的label
    self.textLabel.hidden = true;
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview:self.titleLabel];
    
    self.subtitleLabel = [[UILabel alloc] init];
    self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subtitleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.subtitleLabel];
}

//设置布局
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat labelHeight = self.bounds.size.height/2.0f;
    self.titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, labelHeight);
    self.subtitleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), self.bounds.size.width, labelHeight);
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setSubtitle:(NSString *)subtitle {
    self.subtitleLabel.text = subtitle;
}

//通过此父类方法配置cell是否被选中
- (void)configCellOfSelected:(BOOL)selected {
    
    UIColor *textColor = selected ? [UIColor blackColor] : [UIColor grayColor];
    
    self.titleLabel.textColor = textColor;
    
    self.subtitleLabel.textColor = textColor;
}

//通过此父类方法配置cell动画
- (void)showAnimationOfProgress:(CGFloat)progress type:(XLPageTitleCellAnimationType)type {
    
}

@end
