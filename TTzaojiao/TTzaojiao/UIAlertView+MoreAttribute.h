//
//  UIAlertView+MoreAttribute.h
//  TTzaojiao
//
//  Created by hegf on 15-4-18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kALertTiem 1.5
@interface UIAlertView (MoreAttribute)
- (void) showWithTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString*)cancelButtontitle;

- (void)showAlert:(NSString *) message byTime:(CGFloat) time;
@end
