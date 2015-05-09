//
//  TTVipView.m
//  TTzaojiao
//
//  Created by hegf on 15-5-9.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTVipView.h"

@implementation TTVipView

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

    UILabel* vip = [[UILabel alloc]init];
    _vip = vip;
    
    NSString* title = @"VIP";
    CGSize rect = {ScreenWidth, MAXFLOAT};
    NSDictionary* attr = @{NSFontAttributeName:TTBlogSubtitleFont};
    CGRect bound = [title boundingRectWithSize:rect options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    
    [vip setText:title];
    vip.textAlignment = NSTextAlignmentCenter;
    vip.textColor = [UIColor whiteColor];
    [vip setFont:TTBlogSubtitleFont];
    [self addSubview:vip];
    
    CGFloat vipx = 0;
    CGFloat vipy = 0;
    CGFloat vipw = bound.size.width;
    CGFloat viph = bound.size.height;
    vip.frame = CGRectMake(vipx, vipy, vipw, viph);
    
    self.bounds = CGRectMake(0, 0, vipw, viph);
}

@end
