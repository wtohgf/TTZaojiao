//
//  TTUIChangeTool.m
//  TTzaojiao
//
//  Created by hegf on 15-5-13.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTUIChangeTool.h"
#import "TTBaseNavgationController.h"
#import "TTMainPageViewController.h"

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

//-(void)backToLongon{
//    
//    UIStoryboard *storyBoardDongTai=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//   TTBaseNavgationController *nav = (TTBaseNavgationController *)[storyBoardDongTai instantiateViewControllerWithIdentifier:@"MAINNAV"];
//    TTMainPageViewController* mainPage = [storyBoardDongTai instantiateViewControllerWithIdentifier:@"MAINPAGE"];
//    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:mainPage];
//    
//    //在ViewController中切换keywindow的rootViewController需要用delegate 否则闪退
//    [UIApplication sharedApplication].delegate.window.rootViewController = nav;
//    [[UIApplication sharedApplication].delegate.window reloadInputViews];
//    [UIApplication sharedApplication].keyWindow.rootViewController = nav;
//}

-(void)backToLogReg:(UIViewController*)vc{
    UIStoryboard *storyBoardDongTai=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *nav = (UINavigationController *)[storyBoardDongTai instantiateViewControllerWithIdentifier:@"MAINNAV"];
    [vc presentViewController:nav animated:NO completion:nil];
//    [UIApplication sharedApplication].keyWindow.rootViewController = nav;
}

-(void)pushToLongon:(UINavigationController *)nav{
    UIStoryboard *storyBoardDongTai=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *Controller = (UIViewController *)[storyBoardDongTai instantiateViewControllerWithIdentifier:@"LOGON"];
    [nav pushViewController:Controller animated:YES];
}

@end
