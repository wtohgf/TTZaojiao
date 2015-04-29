//
//  TTDynamicCommentsView.h
//  TTzaojiao
//
//  Created by hegf on 15-4-28.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTDynamicCommentView.h"
#import "TTBlogFrame.h"
@class TTDynamicCommentsView;
@protocol TTDynamicCommentsViewDelegate<NSObject>
-(void)dynamicCommentsView:(TTDynamicCommentsView*)dynamicCommentsView didShowCommentList:(NSString*)blog_id;
@end
@interface TTDynamicCommentsView : UIView
@property (strong, nonatomic) TTBlogFrame* blogFrame;
@property (weak, nonatomic) UIButton* showAllReplayButton;

@property (weak, nonatomic) id<TTDynamicCommentsViewDelegate> delegate;
@end
