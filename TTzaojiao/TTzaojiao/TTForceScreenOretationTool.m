//
//  TTForceScreenOretationTool.m
//  TTzaojiao
//
//  Created by hegf on 15-5-13.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTForceScreenOretationTool.h"

@implementation TTForceScreenOretationTool
+(UIInterfaceOrientation)getStaustBarOretation{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    return orientation;
}

+(CGRect)getAppFrame{
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    return frame;
}

+(CGPoint)getScreenCenter{
    CGRect frame = [self getAppFrame];
    CGPoint center = CGPointMake(frame.origin.x + ceil(frame.size.width/2), frame.origin.y + ceil(frame.size.height/2));
    return center;
}

+(CGAffineTransform)getAffineRotation{
    UIInterfaceOrientation orientation = [self getStaustBarOretation];
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return CGAffineTransformMakeRotation(M_PI*1.5);
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        return CGAffineTransformMakeRotation(M_PI/2);
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return CGAffineTransformMakeRotation(-M_PI);
    } else {
        return CGAffineTransformIdentity;
    }
}

+(void)setScreenOretation:(UIInterfaceOrientation) orientation view:(UIView*)view{
    [[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:YES];
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    //在这里设置view.transform需要匹配的旋转角度的大小就可以了。
    
    view.transform = [self getAffineRotation];
    
    [UIView commitAnimations];
    
}

@end
