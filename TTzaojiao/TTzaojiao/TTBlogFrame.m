//
//  TTBlogFrame.m
//  TTzaojiao
//
//  Created by hegf on 15-4-27.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTBlogFrame.h"

@implementation TTBlogFrame
-(void)setBlog:(BlogModel *)blog{
    _blog = blog;
    
    //cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2*TTBlogTableBorder;
    
    // 头像
    CGFloat iconViewWH = cellW*TTHeaderWithRatio;
    CGFloat iconViewX = TTBlogTableBorder;
    CGFloat iconViewY = TTBlogTableBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    // 昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + TTBlogTableBorder;
    CGFloat nameLabelY = iconViewY;
    NSDictionary* atrr = @{
                           NSFontAttributeName:TTBlogMaintitleFont
                           };
    CGSize nameLabelSize = [blog.baby_name sizeWithAttributes:atrr];
    _nameLabelF = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    //时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF) + TTBlogTableBorder*0.5;
    NSDictionary* timeLabelatrr = @{
                           NSFontAttributeName:TTBlogSubtitleFont
                           };
    CGSize timeLabelSize = [blog.i_distance_time sizeWithAttributes:timeLabelatrr];

    
    _timeLabelF = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    //正文
    CGFloat contentLabelX = CGRectGetMaxX(_iconViewF) +TTBlogTableBorder;
    CGFloat contentLabelY = CGRectGetMaxY(_timeLabelF) + TTBlogTableBorder;
    NSDictionary* contentLabelAttr = @{
                                    NSFontAttributeName:TTBlogMaintitleFont
                                    };
    CGFloat maxWidth = cellW - TTBlogTableBorder - iconViewWH - TTBlogTableBorder*2;
    CGSize maxRect = {maxWidth, MAXFLOAT};
    CGRect contentLablebounding = [blog.i_content boundingRectWithSize:maxRect options:NSStringDrawingUsesLineFragmentOrigin attributes:contentLabelAttr context:nil];
    
    CGFloat contentLabelW = contentLablebounding.size.width;
    CGFloat contentLabelH = contentLablebounding.size.height + TTBlogTableBorder;
    _contentLabelF = CGRectMake(contentLabelX, contentLabelY, contentLabelW, contentLabelH);
    
    //作为remsg zan两个按钮的父控件 作为topView的子控件
    CGFloat zanCountViewX = contentLabelX;
    CGFloat zanCountViewY = CGRectGetMaxY(_contentLabelF);
    CGFloat zanCountViewW = maxWidth;
    CGFloat zanCountViewH = iconViewWH*0.4;
    _zanCountViewF = CGRectMake(zanCountViewX, zanCountViewY, zanCountViewW, zanCountViewH);
    
    
    CGFloat remsgBtnX = 0;
    CGFloat remsgBtnY = 0;
    CGFloat remsgBtnW = zanCountViewW * 0.5;
    CGFloat remsgBtnH = zanCountViewH;
    
    _remsgBtnF = CGRectMake(remsgBtnX, remsgBtnY, remsgBtnW, remsgBtnH);
    
    CGFloat zanBtnX = CGRectGetMaxX(_remsgBtnF);
    CGFloat zanBtnY = 0;
    CGFloat zanBtnW = remsgBtnW;
    CGFloat zanBtnH = remsgBtnH;
    _zanBtnF = CGRectMake(zanBtnX, zanBtnY, zanBtnW, zanBtnH);
   
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    CGFloat topViewW = cellW;
    CGFloat topViewH = CGRectGetMaxY(_zanCountViewF);
    
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    
    _cellHeight = CGRectGetMaxY(_topViewF) + TTBlogTableBorder;
}
@end
