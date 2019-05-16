//
//  XLChannelItem.m
//  XLChannelControlDemo
//
//  Created by MengXianLiang on 2017/3/3.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "XLChannelItem.h"

@interface XLChannelItem ()

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) CAShapeLayer *borderLayer;

@end

@implementation XLChannelItem

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    self.userInteractionEnabled = true;
    self.layer.cornerRadius = 5.0f;
    self.backgroundColor = [self backgroundColor];
    
    self.textLabel = [UILabel new];
    self.textLabel.frame = self.bounds;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.textColor = [self textColor];
    self.textLabel.adjustsFontSizeToFitWidth = true;
    self.textLabel.userInteractionEnabled = true;
    [self addSubview:self.textLabel];
    
    [self addBorderLayer];
}

-(void)addBorderLayer{
    self.borderLayer = [CAShapeLayer layer];
    self.borderLayer.bounds = self.bounds;
    self.borderLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    self.borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.borderLayer.bounds cornerRadius:self.layer.cornerRadius].CGPath;
    self.borderLayer.lineWidth = 1;
    self.borderLayer.lineDashPattern = @[@5, @3];
    self.borderLayer.fillColor = [UIColor clearColor].CGColor;
    self.borderLayer.strokeColor = [self backgroundColor].CGColor;
    [self.layer addSublayer:self.borderLayer];
    self.borderLayer.hidden = true;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame = self.bounds;
}

#pragma mark -
#pragma mark 配置方法

-(UIColor*)backgroundColor{
    return [UIColor colorWithRed:241/255.0f green:241/255.0f blue:241/255.0f alpha:1];
}

-(UIColor*)textColor{
    return [UIColor colorWithRed:40/255.0f green:40/255.0f blue:40/255.0f alpha:1];
}

-(UIColor*)lightTextColor{
    return [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];
}

#pragma mark -
#pragma mark Setter

-(void)setTitle:(NSString *)title
{
    _title = title;
    self.textLabel.text = title;
}

-(void)setIsMoving:(BOOL)isMoving
{
    _isMoving = isMoving;
    if (_isMoving) {
        self.backgroundColor = [UIColor clearColor];
        self.borderLayer.hidden = false;
    }else{
        self.backgroundColor = [self backgroundColor];
        self.borderLayer.hidden = true;
    }
}

-(void)setIsFixed:(BOOL)isFixed{
    _isFixed = isFixed;
    if (isFixed) {
        self.textLabel.textColor = [self lightTextColor];
    }else{
        self.textLabel.textColor = [self textColor];
    }
}

@end
