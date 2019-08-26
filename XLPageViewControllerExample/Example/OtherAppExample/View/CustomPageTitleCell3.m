//
//  CustomPageTitleCell3.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/14.
//  Copyright © 2019 xianliang meng. All rights reserved.
//

#import "CustomPageTitleCell3.h"

static CGFloat CellScaleValueMax = 1.25f;

@interface CustomPageTitleCell3 ()

@property (nonatomic, strong) UILabel *leftLabel;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, assign) BOOL isSelected;

@end

@implementation CustomPageTitleCell3

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initCustomCell];
    }
    return self;
}

- (void)initCustomCell {
    //隐藏父类cell中的label
    self.textLabel.hidden = true;
    //添加新控件
    self.leftLabel = [[UILabel alloc] init];
    self.leftLabel.textAlignment = NSTextAlignmentRight;
    self.leftLabel.textColor = [UIColor whiteColor];
    self.leftLabel.font = [UIFont boldSystemFontOfSize:22];
    [self.contentView addSubview:self.leftLabel];
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.line];
    
    self.rightLabel = [[UILabel alloc] init];
    self.rightLabel.textAlignment = NSTextAlignmentLeft;
    self.rightLabel.textColor = [UIColor whiteColor];
    self.rightLabel.numberOfLines = 2;
    self.rightLabel.font = [UIFont boldSystemFontOfSize:11];
    [self.contentView addSubview:self.rightLabel];
}

//设置布局
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat leftLabelW = 0.58*self.bounds.size.width;
    CGFloat rightLabelW = 0.3*self.bounds.size.width;
    CGFloat lineW = 1.0f;
    CGFloat lineH = 0.55*self.bounds.size.height;
    CGFloat lineX = leftLabelW + (self.bounds.size.width - lineW - leftLabelW - rightLabelW)/2.0f;
    CGFloat lineY = (self.bounds.size.height - lineH)/2.0f;
    
    self.leftLabel.frame = CGRectMake(0, 0, leftLabelW, self.bounds.size.height);
    
    self.rightLabel.frame = CGRectMake(self.bounds.size.width - rightLabelW, 0, rightLabelW, self.bounds.size.height);
    
    self.line.frame = CGRectMake(lineX , lineY, lineW, lineH);
    
    if (self.isSelected) {
        self.transform = CGAffineTransformMakeScale(CellScaleValueMax, CellScaleValueMax);
    }else {
        self.transform = CGAffineTransformIdentity;
    }
}

- (void)setTitle:(NSString *)title {
    NSArray *arr = [title componentsSeparatedByString:@"|"];
    self.leftLabel.text = arr.firstObject;
    self.rightLabel.text = arr.lastObject;
}

//通过此父类方法配置cell是否被选中
- (void)configCellOfSelected:(BOOL)selected {
    [super configCellOfSelected:selected];
    
    self.isSelected = selected;
    
    UIColor *color = selected ? self.config.titleSelectedColor : self.config.titleNormalColor;
    [self updateSubviewsColor:color];
    
    if (selected) {
        self.transform = CGAffineTransformMakeScale(CellScaleValueMax, CellScaleValueMax);
    }else {
        self.transform = CGAffineTransformIdentity;
    }
}

//通过此父类方法配置cell动画 progress0~1
- (void)showAnimationOfProgress:(CGFloat)progress type:(XLPageTitleCellAnimationType)type {
    [super showAnimationOfProgress:progress type:type];
    //动画包括颜色渐变 缩放
    if (type == XLPageTitleCellAnimationTypeSelected) {
        //第一步 颜色渐变
        UIColor *newColor = [XLPageViewControllerUtil colorTransformFrom:self.config.titleSelectedColor to:self.config.titleNormalColor progress:progress];
        [self updateSubviewsColor:newColor];
        //第二步 缩放 逐渐变小
        CGFloat scale = (1 - progress)*(CellScaleValueMax - 1);
        self.transform = CGAffineTransformMakeScale(1 + scale, 1 + scale);
    }else if (type == XLPageTitleCellAnimationTypeWillSelected){
        //第一步 颜色渐变
        UIColor *newColor = [XLPageViewControllerUtil colorTransformFrom:self.config.titleNormalColor to:self.config.titleSelectedColor progress:progress];
        [self updateSubviewsColor:newColor];
        
        //第二步 缩放 逐渐变大
        CGFloat scale = progress*(CellScaleValueMax - 1);
        self.transform = CGAffineTransformMakeScale(1 + scale, 1 + scale);
    }
}

- (void)updateSubviewsColor:(UIColor *)color {
    self.leftLabel.textColor = color;
    self.line.backgroundColor = color;
    self.rightLabel.textColor = color;
}

@end
