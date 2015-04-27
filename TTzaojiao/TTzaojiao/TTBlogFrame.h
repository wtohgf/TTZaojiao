//
//  TTBlogFrame.h
//  TTzaojiao
//
//  Created by hegf on 15-4-27.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BlogModel.h"

#define TTHeaderWithRatio 44.f/320.f
#define TTBlogTableBorder 8
#define TTBlogMaintitleFont [UIFont systemFontOfSize:16.f]
#define TTBlogSubtitleFont [UIFont systemFontOfSize:14.f]
#define TTBlogBackgroundColor [UIColor colorWithRed:244.f/255.f green:247.f/255.f blue:244.f/255.f alpha:1.f]

//根据微博模型 计算微博控件的frame
@interface TTBlogFrame : NSObject

/** 顶部topView 以下是topView的子控件*/
@property (nonatomic, assign, readonly) CGRect topViewF;

/** 头像 */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/** 昵称 */
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign, readonly) CGRect timeLabelF;
/** 正文\内容 */
@property (nonatomic, assign, readonly) CGRect contentLabelF;
/** 配图 */
@property (nonatomic, assign, readonly) CGRect photosViewF;

/** 回复数和赞数 */
@property (nonatomic, assign, readonly) CGRect zanCountViewF;
/**回复按钮 */
@property (nonatomic, assign, readonly) CGRect remsgBtnF;
/**赞按钮 */
@property (nonatomic, assign, readonly) CGRect zanBtnF;

/** 微博模型 */
@property (strong, nonatomic) BlogModel* blog;

@property (nonatomic, assign, readonly) CGFloat cellHeight;
@end
