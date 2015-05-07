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

@interface TTDynamicCommentsView : UIView
@property (strong, nonatomic) TTBlogFrame* blogFrame;
@property (weak, nonatomic) UIButton* showAllReplayButton;

@end
