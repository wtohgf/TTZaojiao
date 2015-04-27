//
//  TTDynamicUserStatusTopView.m
//  TTzaojiao
//
//  Created by hegf on 15-4-27.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTDynamicUserStatusTopView.h"
#import "BlogModel.h"
#import <UIImageView+AFNetworking.h>
#import "UIImageView+MoreAttribute.h"

@interface TTDynamicUserStatusTopView()
//头像
@property (weak, nonatomic) UIImageView* iconView;
//昵称
@property (weak, nonatomic) UILabel* name;
//距离及发布时间
@property (weak, nonatomic) UILabel* distancetime;
//正文
@property (weak, nonatomic) UILabel* content;
/** 配图 */
//@property (weak, nonatomic) TTPhotosView *photosView;
@end

@implementation TTDynamicUserStatusTopView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        //头像
        UIImageView* iconView = [[UIImageView alloc]init];
        [self addSubview:iconView];
        _iconView = iconView;
        
        //昵称
        UILabel* name = [[UILabel alloc]init];
        name.numberOfLines = 0;
        name.font = TTBlogMaintitleFont;
        [self addSubview:name];
        _name = name;
        
        //距离及发布时间
        UILabel* distancetime = [[UILabel alloc]init];
        distancetime.numberOfLines = 0;
        distancetime.font = TTBlogSubtitleFont;
        distancetime.textColor = [UIColor grayColor];
        [self addSubview:distancetime];
        _distancetime = distancetime;
        
        //正文
        UILabel* content = [[UILabel alloc]init];
        content.font = TTBlogMaintitleFont;
        content.numberOfLines = 0;
        [self addSubview:content];
        _content = content;
        
        //配图
    }
    return self;
}

-(void)setBlogFrame:(TTBlogFrame *)blogFrame{
    _blogFrame = blogFrame;
    BlogModel* blog = blogFrame.blog;
    
    if (blog.face.length == 0) {
        [_iconView setImage:[UIImage imageNamed:@"baby_icon1"]];
    }else{
        [_iconView setImageIcon:blog.face];
    }
    _iconView.frame = blogFrame.iconViewF;
    
    _name.text = blog.baby_name;
    _name.frame = blogFrame.nameLabelF;
    
    _distancetime.text = blog.i_distance_time;
    _distancetime.frame = blogFrame.timeLabelF;
    
    _content.text = blog.i_content;
    _content.frame = blogFrame.contentLabelF;
    
    self.frame = blogFrame.topViewF;
    
}

@end
