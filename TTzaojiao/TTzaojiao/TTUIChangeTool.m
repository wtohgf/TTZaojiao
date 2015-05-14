//
//  TTUIChangeTool.m
//  TTzaojiao
//
//  Created by hegf on 15-5-13.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTUIChangeTool.h"
#import "TTBaseNavgationController.h"
static TTUIChangeTool* tool;

@implementation TTUIChangeTool

+(instancetype)sharedTTUIChangeTool{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        tool = [[TTUIChangeTool alloc]init];
    });
    return tool;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        tool = [super allocWithZone:zone];
    });
    return tool;
}

-(void)backToLongon{
    
    UIStoryboard *storyBoardDongTai=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *Controller = (UIViewController *)[storyBoardDongTai instantiateViewControllerWithIdentifier:@"LOGON"];
    TTBaseNavgationController* nav = [[TTBaseNavgationController alloc]initWithRootViewController:Controller];
    
        //在ViewController中切换keywindow的rootViewController需要用delegate 否则闪退
    [UIApplication sharedApplication].delegate.window.rootViewController = nav;
    [[UIApplication sharedApplication].delegate.window reloadInputViews];
    [UIApplication sharedApplication].keyWindow.rootViewController = nav;
}

-(void)backToLogReg{
    UIStoryboard *storyBoardDongTai=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *logreg = (UIViewController *)[storyBoardDongTai instantiateViewControllerWithIdentifier:@"LOGONREG"];
    TTBaseNavgationController* nav = [[TTBaseNavgationController alloc]initWithRootViewController:logreg];
    [UIApplication sharedApplication].delegate.window.rootViewController = nav;
    [[UIApplication sharedApplication].delegate.window reloadInputViews];
    [UIApplication sharedApplication].keyWindow.rootViewController = nav;
    
}

@end
