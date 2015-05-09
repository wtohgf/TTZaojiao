//
//  TTNearBybabyInfoView.m
//  TTzaojiao
//
//  Created by hegf on 15-5-8.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTNearBybabyInfoView.h"
#import "NSString+Extension.h"

@implementation TTNearBybabyInfoView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        //头像
        UIImageView* iconView = [[UIImageView alloc]init];
        [self addSubview:iconView];
        _iconView = iconView;
        _iconView.frame = CGRectMake(TTBlogTableBorder, TTBlogTableBorder, TTHeaderWithRatio*ScreenWidth, TTHeaderWithRatio*ScreenWidth);
        iconView.userInteractionEnabled = YES;
        
        //昵称
        UILabel* name = [[UILabel alloc]init];
        name.numberOfLines = 0;
        name.font = TTBlogMaintitleFont;
        [self addSubview:name];
        _name = name;
        
        CGFloat namex = _iconView.right+TTBlogTableBorder;
        CGFloat namey = _iconView.up;
        CGFloat namew = (ScreenWidth - namex)*0.5;
        CGFloat nameh = 16.f;
        name.frame = CGRectMake(namex, namey, namew, nameh);
        
        UIView* genderAgeView = [[UIView alloc]init];
        genderAgeView.layer.cornerRadius = 4.0f;
        [genderAgeView setBackgroundColor:[UIColor colorWithRed:152.f/255.f green:82.f/255.5 blue:146.f/255.f alpha:1.f]];
        
        UIImageView* gender = [[UIImageView alloc]init];
        [genderAgeView addSubview:gender];
        CGFloat genderx = 0;
        CGFloat gendery = 0;
        CGFloat genderw = 14.f;
        CGFloat genderh = genderw;
        gender.frame = CGRectMake(genderx, gendery, genderw, genderh);
        gender.contentMode = UIViewContentModeScaleAspectFit;
        _gender = gender;
        
        UILabel* age = [[UILabel alloc]init];
        CGFloat agex = gender.right;
        CGFloat agey = 0;
        CGFloat agew = 48.f;
        CGFloat ageh = gender.height;
        age.frame = CGRectMake(agex, agey, agew, ageh);
        [genderAgeView addSubview:age];
        [age setFont:TTBlogSubtitleFont];
        age.textColor = [UIColor whiteColor];
        age.textAlignment = NSTextAlignmentCenter;
        _age = age;
        
        CGFloat genderAgex = _iconView.right+TTBlogTableBorder;
        CGFloat genderAgey = name.bottom + TTBlogTableBorder*0.5;
        CGFloat genderAgew = 62.f;
        CGFloat genderAgeh = 14.f;
        genderAgeView.frame = CGRectMake(genderAgex, genderAgey, genderAgew, genderAgeh);
        
        [self addSubview:genderAgeView];

        UIView* vipView = [[UIView alloc]init];
        vipView.backgroundColor = [UIColor redColor];
        vipView.layer.cornerRadius = 4.f;

        CGFloat vipx = genderAgeView.right+TTBlogTableBorder;
        CGFloat vipy = genderAgeView.up;
        CGFloat vipw = 24.f;
        CGFloat viph = 14.f;
        vipView.frame = CGRectMake(vipx, vipy, vipw, viph);
        
        UILabel* vip = [[UILabel alloc]init];
        [vip setText:@"VIP"];
        vip.textAlignment = NSTextAlignmentCenter;
        vip.textColor = [UIColor whiteColor];
        [vip setFont:[UIFont systemFontOfSize:14.f]];
    
        [vipView addSubview:vip];
        [vipView bringSubviewToFront:vip];

        vip.frame = CGRectMake(0, 0, vipw, viph);
        [self addSubview:vipView];
        //vip.adjustsFontSizeToFitWidth = YES;
        _vip = vipView;
        //距离
        UILabel* distance = [[UILabel alloc]init];
        distance.numberOfLines = 0;
        distance.font = TTBlogSubtitleFont;
        distance.textColor = [UIColor grayColor];
        [self addSubview:distance];
        [distance setTextAlignment:NSTextAlignmentRight];
        _distance = distance;
        
        CGFloat distancex = name.right;
        CGFloat distancey = name.up;
        CGFloat distancew = ScreenWidth - name.right - TTBlogTableBorder;
        CGFloat distanceh = 14.f;
        distance.frame = CGRectMake(distancex, distancey, distancew, distanceh);
        
    }
    return self;
}


-(void)setNearByBaby:(NearByBabyModel *)nearByBaby{

    if (nearByBaby == nil) {
        return;
    }
    
    if (nearByBaby.face.length != 0) {
        [_iconView setImageIcon:nearByBaby.face];
    }else{
        [_iconView setImage:[UIImage imageNamed:@"baby_icon1"]];
    }
    
    _name.text = nearByBaby.baby_name;
    
    if ([nearByBaby.Sex isEqualToString:@"1"]) {
        [_gender setImage:[UIImage imageNamed:@"gender_male"]];
    }else{
        [_gender setImage:[UIImage imageNamed:@"gender_female"]];
    }

    if (nearByBaby.Birthday.length != 0) {
        _age.text = [NSString getMounthOfDateString:nearByBaby.Birthday];
    }else{
        _age.text = @"未知";
    }
    NSTimeInterval timeval = [NSString getTimeIntervalOfDateString:nearByBaby.sort_end_time];
    if (timeval > 0) {
        _vip.hidden = NO;
    }else{
        _vip.hidden = YES;
    }
    
    _distance.text = [NSString stringWithFormat:@"%@km", nearByBaby.i_distance];
    _nearByBaby = nearByBaby;
}

@end
