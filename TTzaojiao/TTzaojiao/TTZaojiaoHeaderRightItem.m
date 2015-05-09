//
//  TTZaojiaoHeaderRightItem.m
//  TTzaojiao
//
//  Created by hegf on 15-5-9.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTZaojiaoHeaderRightItem.h"

@implementation TTZaojiaoHeaderRightItem

+(instancetype)zaojiaoHeaderRightItemWithTarget:(id)target Action:(SEL)aciton{
    TTZaojiaoHeaderRightItem* item = [[TTZaojiaoHeaderRightItem alloc]init];
    [item.vipPay.vipPay addTarget:target action:aciton forControlEvents:UIControlEventTouchUpInside];
    return item;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

-(void)addSubviews{
    
    TTGenderAgeView* genderAge = [[TTGenderAgeView alloc]init];
    _genderAge = genderAge;
    [self addSubview:genderAge];
    
    TTVipView* vip = [[TTVipView alloc]init];
    _vip = vip;
    [self addSubview:vip];
    
    TTVipPayView*  vipPay = [[TTVipPayView alloc]init];
    _vipPay = vipPay;
    [self addSubview:vipPay];

}

//设置模型
-(void)setLogonUser:(UserModel *)logonUser{
    _logonUser = logonUser;
    if (logonUser == nil) {
        return;
    }
    
    if ([logonUser.gender isEqualToString:@"1"]) {
        [_genderAge.gender setImage:[UIImage imageNamed:@"gender_male"]];
    }else{
        [_genderAge.gender setImage:[UIImage imageNamed:@"gender_female"]];
    }
    
    _genderAge.logonUser = logonUser;
    
    //设置frame
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = (ScreenWidth - 2*TTBlogTableBorder)*0.5;
    CGFloat h = TTLeftHeaderWidthRatio*ScreenWidth;
    self.frame = CGRectMake(x, y, w, h);
    
    CGFloat vipPayx = w - TTBlogTableBorder - _vipPay.width;
    CGFloat vipPayy = self.center.y - _genderAge.bounds.size.height*0.5;
    CGFloat vipPayw = _vipPay.bounds.size.width;
    CGFloat vipPayh = _vipPay.bounds.size.height;
    _vipPay.frame = CGRectMake(vipPayx, vipPayy, vipPayw, vipPayh);
    
    
    CGFloat vipx = _vipPay.left - TTBlogTableBorder*0.5- _vip.width;
    CGFloat vipy = vipPayy;
    CGFloat vipw = _vip.bounds.size.width;
    CGFloat viph = _vip.bounds.size.height;
    _vip.frame = CGRectMake(vipx, vipy, vipw, viph);
    
    
    CGFloat genderAgex = _vip.left - TTBlogTableBorder*0.5 - _genderAge.width;
    CGFloat genderAgey = vipy;
    CGFloat genderAgew = _genderAge.bounds.size.width;
    CGFloat genderAgeh = _genderAge.bounds.size.height;
    _genderAge.frame = CGRectMake(genderAgex, genderAgey, genderAgew, genderAgeh);
    
}

@end
