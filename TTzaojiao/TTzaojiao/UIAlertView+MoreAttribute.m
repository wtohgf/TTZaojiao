//
//  UIAlertView+MoreAttribute.m
//  TTzaojiao
//
//  Created by hegf on 15-4-18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "UIAlertView+MoreAttribute.h"

@implementation UIAlertView (MoreAttribute)

- (void)showWithTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString*)cancelButtontitle{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtontitle otherButtonTitles:nil, nil];
    [alert show];
}

- (void)showAlert:(NSString *) message byTime:(CGFloat) time
{
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:time
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:NO];
    [promptAlert show];
}

- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:YES];
    promptAlert =nil;
}


@end
