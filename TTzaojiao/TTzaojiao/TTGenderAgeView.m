//
//  TTGenderAgeView.m
//  TTzaojiao
//
//  Created by hegf on 15-5-9.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTGenderAgeView.h"

@implementation TTGenderAgeView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

-(void)addSubviews{
    
    self.layer.cornerRadius = 4.0f;
    [self setBackgroundColor:[UIColor colorWithRed:152.f/255.f green:82.f/255.5 blue:146.f/255.f alpha:1.f]];
    
    UIImageView* gender = [[UIImageView alloc]init];
    [self addSubview:gender];
    gender.contentMode = UIViewContentModeScaleAspectFit;
    _gender = gender;
    
    UILabel* age = [[UILabel alloc]init];
    [self addSubview:age];
    [age setFont:TTBlogSubtitleFont];
    age.textColor = [UIColor whiteColor];
    age.textAlignment = NSTextAlignmentCenter;
    _age = age;

}

-(void)setLogonUser:(UserModel *)logonUser{
    _logonUser = logonUser;
    if (logonUser.birthday.length != 0) {
        self.age.text = [NSString getMounthOfDateString:logonUser.birthday];
    }else{
        self.age.text = @"未知";
    }
    
    CGSize rect = {ScreenWidth, MAXFLOAT};
    NSDictionary* attr = @{NSFontAttributeName:TTBlogSubtitleFont};
    CGRect bound = [_age.text boundingRectWithSize:rect options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    
    CGFloat genderx = 0;
    CGFloat gendery = 0;
    CGFloat genderw = bound.size.height;
    CGFloat genderh = genderw;
    _gender.frame = CGRectMake(genderx, gendery, genderw, genderh);

    CGFloat agex = genderw;
    CGFloat agey = gendery;
    CGFloat agew = bound.size.width;
    CGFloat ageh = bound.size.height;
    _age.frame = CGRectMake(agex, agey, agew, ageh);

    self.bounds = CGRectMake(0, 0, agew+genderw, bound.size.height);
}

@end
