//
//  UIButton+MoreAttribute.h
//  TTzaojiao
//
//  Created by hegf on 15-4-30.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MoreAttribute)
+(instancetype)buttonWithTitleForCell:(NSString*)title target:(id)target action:(SEL)action;
@end
