//
//  TTDynamicUserStatusTopView.h
//  TTzaojiao
//
//  Created by hegf on 15-4-27.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBlogFrame.h"

@class TTDynamicUserStatusTopView;
@protocol TTDynamicUserStatusTopViewDelegate<NSObject>
-(void)dynamicUserStatusTopView:(TTDynamicUserStatusTopView*)view didIconTaped:(NSString*)uid;
@end

@interface TTDynamicUserStatusTopView : UIView
@property (strong, nonatomic) TTBlogFrame* blogFrame;
@property (weak, nonatomic) id<TTDynamicUserStatusTopViewDelegate> delegate;
@end
