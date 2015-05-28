//
//  TTDaynamicUserStatusZancountView.m
//  TTzaojiao
//
//  Created by hegf on 15-4-28.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTDaynamicUserStatusZancountView.h"
#import "UIImage+MoreAttribute.h"

@implementation TTDaynamicUserStatusZancountView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //消息
        UIButton* remsgBtn = [[UIButton alloc]init];
        [self addSubview:remsgBtn];
        [remsgBtn setImage:[UIImage imageWithName:@"icon_comment.png"] forState:UIControlStateNormal];
        remsgBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _remsgBtn = remsgBtn;
        
        //赞
        UIButton* zanBtn = [[UIButton alloc]init];
        [zanBtn setImage:[UIImage imageWithName:@"icon_praise.png"] forState:UIControlStateNormal];
        [self addSubview:zanBtn];
        zanBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _zanBtn = zanBtn;
        
    }
    return self;
}

-(void)setBlogFrame:(TTBlogFrame *)blogFrame{
    _blogFrame = blogFrame;
    BlogModel* blog = blogFrame.blog;
    
    _remsgBtn.frame = blogFrame.remsgBtnF;
//    [_remsgBtn setTitle:blog.i_replay forState:UIControlStateNormal];
    NSDictionary* atrr = @{
                           NSFontAttributeName:TTBlogSubtitleFont,
                           NSForegroundColorAttributeName:[UIColor grayColor]
                           };
    NSAttributedString* remsg = [[NSAttributedString alloc]initWithString:blog.i_replay attributes:atrr];
    [_remsgBtn setAttributedTitle:remsg forState:UIControlStateNormal];
    
    _zanBtn.frame = blogFrame.zanBtnF;
    NSAttributedString* zan = [[NSAttributedString alloc]initWithString:blog.i_zan attributes:atrr];
    [_zanBtn setAttributedTitle:zan forState:UIControlStateNormal];
    
    self.frame = blogFrame.zanCountViewF;
    
}

-(void)setUserblogFrame:(TTUserBlogFrame *)userblogFrame{
    _userblogFrame = userblogFrame;
    BlogUserDynamicModel* blog = userblogFrame.userblog;
    
    _remsgBtn.frame = userblogFrame.remsgBtnF;
    //    [_remsgBtn setTitle:blog.i_replay forState:UIControlStateNormal];
    NSDictionary* atrr = @{
                           NSFontAttributeName:TTBlogSubtitleFont,
                           NSForegroundColorAttributeName:[UIColor grayColor]
                           };
    NSAttributedString* remsg = [[NSAttributedString alloc]initWithString:blog.i_replay attributes:atrr];
    [_remsgBtn setAttributedTitle:remsg forState:UIControlStateNormal];
    
    _zanBtn.frame = userblogFrame.delBtnF;
   // [_zanBtn setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
    if (![_userblogFrame.userblog.i_uid isEqualToString:[TTUserModelTool sharedUserModelTool].logonUser.ttid]) {
        NSAttributedString* zan = [[NSAttributedString alloc]initWithString:blog.i_zan attributes:atrr];
        [_zanBtn setAttributedTitle:zan forState:UIControlStateNormal];
    }
    self.frame = userblogFrame.zanCountViewF;
}

@end
