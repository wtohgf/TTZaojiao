//
//  TTVipPayView.m
//  TTzaojiao
//
//  Created by hegf on 15-5-9.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTVipPayView.h"

@implementation TTVipPayView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

-(void)addSubviews{
    self.backgroundColor = [UIColor redColor];
    self.layer.cornerRadius = 4.f;
    
    UIButton* vipPay = [[UIButton alloc]init];
    _vipPay = vipPay;

    vipPay.titleLabel.textAlignment = NSTextAlignmentCenter;
    vipPay.titleLabel.textColor = [UIColor whiteColor];
    [vipPay.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [self addSubview:vipPay];
    
    NSString* title = @"立即充值";
    CGSize rect = {ScreenWidth, MAXFLOAT};
    NSDictionary* attr = @{NSFontAttributeName:TTBlogSubtitleFont};
    CGRect bound = [title boundingRectWithSize:rect options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    
    [vipPay setTitle:title forState:UIControlStateNormal];
    [vipPay setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
    
    CGFloat vipx = 0;
    CGFloat vipy = 0;
    CGFloat vipw = bound.size.width;
    CGFloat viph = bound.size.height;
    vipPay.frame = CGRectMake(vipx, vipy, vipw, viph);
    
    self.bounds = CGRectMake(0, 0, vipw, viph);
}

@end
