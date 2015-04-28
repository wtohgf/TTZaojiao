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
    CGFloat cellW = TTCellWidth;
    
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
    
    //配图
    CGFloat photosViewX = contentLabelX;
    CGFloat photosViewY = CGRectGetMaxY(_contentLabelF)+TTBlogTableBorder;
    CGSize photosViewSize = CGSizeZero;
    if (blog.photosURLStr != nil) {
        photosViewSize = [self photosViewSizeWithPhotosCount:blog.photosURLStr.count];
    }

    _photosViewF = (CGRect){{photosViewX, photosViewY}, {photosViewSize.width, photosViewSize.height + TTBlogTableBorder}};
    
    //作为remsg zan两个按钮的父控件 作为topView的子控件
    CGFloat zanCountViewX = contentLabelX;
    CGFloat zanCountViewY = CGRectGetMaxY(_photosViewF);
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
    
    //回复数不为0
    if (blog.replay.count != 0) {
        CGFloat comentsViewH = 0;
        NSMutableArray* commentsArray = [NSMutableArray array];
        TTCommentFrame* preFrame = nil;
        for (int i = 0; i<blog.replay.count; i++) {
            if (i > 2) {
                break;
            }
            NSDictionary* commentDict = blog.replay[i];
            TTCommentFrame* frame = [[TTCommentFrame alloc]init];
            if (i == 0) {
                frame.offsetY = 0;
                frame.comment = [BlogReplayModel blogReplayModelWithDict:commentDict];
                preFrame = frame;
            }else{
                frame.offsetY = CGRectGetMaxY(preFrame.comentViewF);
                frame.comment = [BlogReplayModel blogReplayModelWithDict:commentDict];
                preFrame = frame;
            }
            comentsViewH += frame.commentHeight;
            [commentsArray addObject:frame];
        }
        
        _commentsFrame = commentsArray;
        
        CGFloat comentsViewX = 0;
        CGFloat comentsViewY = CGRectGetMaxY(_zanCountViewF);
        CGFloat comentsViewW = cellW;
        _commentsViewF = CGRectMake(comentsViewX, comentsViewY, comentsViewW, comentsViewH + ScreenWidth*TTHeaderWithRatio*0.6);

        CGFloat topViewX = 0;
        CGFloat topViewY = 0;
        CGFloat topViewW = cellW;
        CGFloat topViewH = CGRectGetMaxY(_commentsViewF);
        _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    }else{
        CGFloat topViewX = 0;
        CGFloat topViewY = 0;
        CGFloat topViewW = cellW;
        CGFloat topViewH = CGRectGetMaxY(_zanCountViewF);
        _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    }
    
    _cellHeight = CGRectGetMaxY(_topViewF) + TTBlogTableBorder;
}

/**
 *  根据图片的个数返回相册的最终尺寸
 */
- (CGSize)photosViewSizeWithPhotosCount:(NSUInteger)count
{
    // 一行最多有3列
    NSUInteger maxColumns = (count == 4) ? 2 : 3;
    
    //  总行数
    NSUInteger rows = (count + maxColumns - 1) / maxColumns;
    // 高度
    CGFloat photosH = rows * TTPhotoH + (rows - 1) * TTPhotoMargin;
    
    // 总列数
    NSUInteger cols = (count >= maxColumns) ? maxColumns : count;
    // 宽度
    CGFloat photosW = cols * TTPhotoW + (cols - 1) * TTPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
    /**
     一共60条数据 == count
     一页10条 == size
     总页数 == pages
     pages = (count + size - 1)/size;
     */
}

@end
