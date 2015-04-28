//
//  TTCommentFrame.h
//  TTzaojiao
//
//  Created by hegf on 15-4-28.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BlogReplayModel.h"
#import "TTBlogFrame.h"

#define TTCommentIconWithRatio 22.f/320.f

@interface TTCommentFrame : NSObject
/** comentView 以下是comentViewF的子控件*/
@property (nonatomic, assign, readonly) CGRect comentViewF;

/** 头像 */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/** 昵称 */
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/** 正文\内容 */
@property (nonatomic, assign, readonly) CGRect contentLabelF;
//多条评论上一条评论的高度
@property (assign, nonatomic) CGFloat offsetY;
/** 评论模型 */
@property (strong, nonatomic) BlogReplayModel* comment;

@property (nonatomic, assign, readonly) CGFloat commentHeight;
@end
