//
//  TTPlayLessionIntroducePicsView.h
//  TTzaojiao
//
//  Created by hegf on 15-5-11.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBlogFrame.h"
#import "UIView+NKMoreAttribute.h"
#import "NSString+Extension.h"
#import "UIImageView+MoreAttribute.h"

#define kTitleButtonHeight 20.f

@interface TTPlayLessionIntroducePicsView : UIView
@property (weak, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) NSArray* introducePics;

+(instancetype)playLessionIntroducePicsView;

@property (assign, nonatomic) CGFloat viewHeight;
+(CGFloat)viewHeightWithPicsCount:(NSUInteger)count;
@end
