//
//  TTCommentFrame.m
//  TTzaojiao
//
//  Created by hegf on 15-4-28.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTCommentFrame.h"

@implementation TTCommentFrame
-(void)setComment:(BlogReplayModel *)comment{
    _comment = comment;
    
    //cell的宽度
    CGFloat cellW = TTCellWidth;
    
    // 头像
    CGFloat iconViewWH = cellW*TTCommentIconWithRatio;
    CGFloat iconViewX = cellW*TTHeaderWithRatio + TTBlogTableBorder - iconViewWH;
    CGFloat iconViewY = TTBlogTableBorder*0.5;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    // 昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + TTBlogTableBorder;
    CGFloat nameLabelY = iconViewY;
    NSDictionary* atrr = @{
                           NSFontAttributeName:TTBlogSubtitleFont
                           };
    CGSize nameLabelSize = [comment.baby_name sizeWithAttributes:atrr];
    _nameLabelF = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    //正文
    CGFloat contentLabelX = CGRectGetMaxX(_iconViewF)+TTBlogTableBorder;
    CGFloat contentLabelY = CGRectGetMaxY(_iconViewF);
    NSDictionary* contentLabelAttr = @{
                                       NSFontAttributeName:TTBlogSubtitleFont
                                       };
    CGFloat maxWidth = cellW - iconViewX - iconViewWH - TTBlogTableBorder*2;
    CGSize maxRect = {maxWidth, MAXFLOAT};
    CGRect contentLablebounding = [comment.i_content boundingRectWithSize:maxRect options:NSStringDrawingUsesLineFragmentOrigin attributes:contentLabelAttr context:nil];
    
    CGFloat contentLabelW = contentLablebounding.size.width;
    CGFloat contentLabelH = contentLablebounding.size.height + TTBlogTableBorder;
    _contentLabelF = CGRectMake(contentLabelX, contentLabelY, contentLabelW, contentLabelH);
    
    CGFloat topViewX = 0;
    CGFloat topViewY = _offsetY;
    CGFloat topViewW = cellW;
    CGFloat topViewH = CGRectGetMaxY(_contentLabelF);
    
    _comentViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    _commentHeight = CGRectGetHeight(_comentViewF);
}

@end
