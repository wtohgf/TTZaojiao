//
//  TTPublichView.h
//  TTzaojiao
//
//  Created by hegf on 15-5-4.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+NKMoreAttribute.h"
@class TTPublichView;

@protocol TTPublichViewDelegate<NSObject>

-(void)publichViewdidSelPic:(TTPublichView*)view;
-(void)publichViewdidSelBiaoqing:(TTPublichView*)view;
-(void)publichViewdidPublicTo:(TTPublichView*)view;

@end
@interface TTPublichView : UIView
@property (weak, nonatomic) UIButton* selPicButton;
@property (weak, nonatomic) UIButton* selBiaoqingButton;
@property (weak, nonatomic) UIButton* publicToButton;

@property (weak, nonatomic) id<TTPublichViewDelegate> delegate;
@end
