//
//  CustomBottomBar.h
//  TTzaojiao
//
//  Created by hegf on 15-5-14.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CustomClickedBlock)(NSString* title);
@interface CustomBottomBar : UIView

@property (strong, nonatomic) NSArray* items;
@property (strong, nonatomic) CustomClickedBlock block;

+(instancetype)customBottomBarWithClickedBlock:(CustomClickedBlock)block;

@end
