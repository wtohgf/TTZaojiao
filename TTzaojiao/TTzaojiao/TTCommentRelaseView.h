//
//  TTCommentRelaseView.h
//  TTzaojiao
//
//  Created by hegf on 15-4-29.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+NKMoreAttribute.h"
@class TTCommentRelaseView;

@protocol TTCommentRelaseViewDelegate<NSObject>

-(void)commentRelaseView:(TTCommentRelaseView*)view didEndEdit:(NSString*)commentContent;

-(void)didReplayButtonClick;

@end
@interface TTCommentRelaseView : UIView
@property (weak, nonatomic) UITextField* commentTextField;
@property (weak, nonatomic) UIButton* replayButton;

@property (weak, nonatomic) id<TTCommentRelaseViewDelegate> delegate;
@end
