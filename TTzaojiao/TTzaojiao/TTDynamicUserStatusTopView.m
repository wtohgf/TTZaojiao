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
#import "NSAttributedString+EmojiExtension.h"
#import "NSString+Extension.h"
#import "UIImage+MoreAttribute.h"

@interface TTDynamicUserStatusTopView()
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
        iconView.userInteractionEnabled = YES;
        
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
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:blog.i_distance_time];
    
    _distancetime.text = [NSString compareCurrentTime:date];
    _distancetime.frame = blogFrame.timeLabelF;
    
    NSAttributedString* attrString = [NSAttributedString replaceEmojs:blog.i_content];

    [_content setAttributedText:attrString];
    
    _content.frame = blogFrame.contentLabelF;
    
    self.frame = blogFrame.topViewF;
    
}

-(void)setUserblogFrame:(TTUserBlogFrame *)userblogFrame{
    _userblogFrame = userblogFrame;
    BlogUserDynamicModel* blog = userblogFrame.userblog;
    
    _iconView.frame = userblogFrame.iconViewF;
    
    _name.frame = userblogFrame.nameLabelF;

    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:blog.i_distance_time];
    
    _distancetime.text = [NSString compareCurrentTime:date];
    _distancetime.frame = userblogFrame.timeLabelF;
    
    NSAttributedString* attrString = [NSAttributedString replaceEmojs:blog.i_content];
    
    [_content setAttributedText:attrString];

    _content.frame = userblogFrame.contentLabelF;
    
    self.frame = userblogFrame.topViewF;
}

@end
