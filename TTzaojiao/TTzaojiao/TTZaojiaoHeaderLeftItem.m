//
//  TTZaojiaoHeaderLeftItem.m
//  TTzaojiao
//
//  Created by hegf on 15-5-9.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTZaojiaoHeaderLeftItem.h"

@implementation TTZaojiaoHeaderLeftItem

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

-(void)addSubviews{
    
    UIImageView* iconView = [[UIImageView alloc]init];
    _iconView = iconView;
    [self addSubview:iconView];
    
    UILabel* name = [[UILabel alloc]init];
    name.font = TTBlogMaintitleFont;
    _name = name;
    [self addSubview:name];
    
    UILabel* birthDay = [[UILabel alloc]init];
    birthDay.font = TTBlogSubtitleFont;
    birthDay.textColor = [UIColor grayColor];
    _birthDay = birthDay;
    [self addSubview:birthDay];
    
    //设置frame
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = (ScreenWidth - 2*TTBlogTableBorder)*0.5;
    CGFloat h = TTLeftHeaderWidthRatio*ScreenWidth;
    self.frame = CGRectMake(x, y, w, h);
    
    CGFloat iconViewX = 0;
    CGFloat iconViewY = 0;
    CGFloat iconViewW = h;
    CGFloat iconViewH = iconViewW;
    _iconView.frame = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
    
    CGFloat nameX = iconView.right+TTBlogTableBorder;
    CGFloat nameY = iconView.up;
    CGFloat nameW = w-nameX-TTBlogTableBorder;
    CGFloat nameH = 16.f;
    _name.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat birthDayX = nameX;
    CGFloat birthDayY = iconView.bottom - 14.f;
    CGFloat birthDayW = nameW;
    CGFloat birthDayH = 14.f;
    _birthDay.frame = CGRectMake(birthDayX, birthDayY, birthDayW, birthDayH);
}
//设置模型
-(void)setLogonUser:(UserModel *)logonUser{
    _logonUser = logonUser;
    if (logonUser == nil) {
        return;
    }
    if (logonUser.icon.length != 0) {
        [_iconView setImageIcon:logonUser.icon];
    }else{
        [_iconView setImage:[UIImage imageNamed:@"baby_icon1"]];
    }
    _name.text = logonUser.name;
    
    _birthDay.text = logonUser.birthday;
}

@end
