//
//  TTDynamicCommentView.m
//  TTzaojiao
//
//  Created by hegf on 15-4-28.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTDynamicCommentView.h"
#import "UIImage+MoreAttribute.h"

@interface TTDynamicCommentView()
//头像
@property (weak, nonatomic) UIImageView* iconView;
//昵称
@property (weak, nonatomic) UILabel* name;
//正文
@property (weak, nonatomic) UILabel* comment;

@end
@implementation TTDynamicCommentView
//添加控件
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView* iconView = [[UIImageView alloc]init];
        [self addSubview:iconView];
        _iconView = iconView;
        
        UILabel* name = [[UILabel alloc]init];
        name.numberOfLines = 0;
        name.font = TTBlogSubtitleFont;
        [name setTextColor:[UIColor colorWithRed:51.f/255.f green:144.f/255.f blue:207.f/255.f alpha:1.f]];
        [self addSubview:name];
        _name = name;
        
        UILabel* comment = [[UILabel alloc]init];
        comment.numberOfLines = 0;
        comment.font = TTBlogSubtitleFont;
        [comment setTextColor:[UIColor darkGrayColor]];
        [self addSubview:comment];
        _comment = comment;
        
    }
    return self;
}

//根据模型设置内容和尺寸
-(void)setCommentFrame:(TTCommentFrame *)commentFrame{
    _commentFrame = commentFrame;
    
    BlogReplayModel* comment = commentFrame.comment;
    
    if (comment.face.length == 0) {
        [_iconView setImage:[UIImage imageNamed:@"baby_icon1"]];
    }else{
        [_iconView setImageIcon:comment.face];
    }
    _iconView.frame = commentFrame.iconViewF;
    
    _name.text = comment.baby_name;
    _name.frame = commentFrame.nameLabelF;
    
    
    NSAttributedString* attrString = [NSAttributedString replaceEmojs:comment.i_content];
    
    [_comment setAttributedText:attrString];
    _comment.frame = commentFrame.contentLabelF;
    
    self.frame = commentFrame.comentViewF;
}
@end
