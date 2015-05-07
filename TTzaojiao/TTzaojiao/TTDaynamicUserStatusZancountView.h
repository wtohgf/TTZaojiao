//
//  TTDaynamicUserStatusZancountView.h
//  TTzaojiao
//
//  Created by hegf on 15-4-28.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBlogFrame.h"
#import "BlogModel.h"
#import "BlogUserDynamicModel.h"
#import "TTUserBlogFrame.h"

@protocol TTDaynamicUserStatusZancountViewDelegate <NSObject>
-(void)daynamicUserStatusZanClicked:(NSString*)blogid;
-(void)daynamicUserStatusRemsgClicked:(NSString*)blogid;
@end

@interface TTDaynamicUserStatusZancountView : UIView
@property (strong, nonatomic) TTBlogFrame* blogFrame;
@property (strong, nonatomic) TTUserBlogFrame* userblogFrame;

@property (weak, nonatomic) id<TTDaynamicUserStatusZancountViewDelegate> delegate;
@end
