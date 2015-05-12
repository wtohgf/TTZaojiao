//
//  TTPlayLessionIntroduceView.h
//  TTzaojiao
//
//  Created by hegf on 15-5-11.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBlogFrame.h"
#import "UIView+NKMoreAttribute.h"
#import "NSString+Extension.h"

#define kTitleButtonHeight 20.f

@interface TTPlayLessionIntroduceView : UIView

@property (weak, nonatomic) UILabel* titleLabel;
@property (weak, nonatomic) UILabel* contentLabel;

+(instancetype)playLessionIntroduceView;
-(void)setTitle:(NSString*)title Content:(NSString*)content;

@property (assign, nonatomic) CGFloat viewHeight;

@end
