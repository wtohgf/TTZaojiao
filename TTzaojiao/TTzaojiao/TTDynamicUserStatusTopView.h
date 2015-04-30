//
//  TTDynamicUserStatusTopView.h
//  TTzaojiao
//
//  Created by hegf on 15-4-27.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBlogFrame.h"
#import "TTUserBlogFrame.h"

@class TTDynamicUserStatusTopView;
@protocol TTDynamicUserStatusTopViewDelegate<NSObject>
-(void)dynamicUserStatusTopView:(TTDynamicUserStatusTopView*)view didIconTaped:(NSString*)uid;
@end

@interface TTDynamicUserStatusTopView : UIView

//头像
@property (weak, nonatomic) UIImageView* iconView;
//昵称
@property (weak, nonatomic) UILabel* name;
//距离及发布时间
@property (weak, nonatomic) UILabel* distancetime;
//正文
@property (weak, nonatomic) UILabel* content;

@property (strong, nonatomic) TTBlogFrame* blogFrame;
@property (strong, nonatomic) TTUserBlogFrame* userblogFrame;

@property (weak, nonatomic) id<TTDynamicUserStatusTopViewDelegate> delegate;
@end
