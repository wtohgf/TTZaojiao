//
//  TTUIChangeTool.h
//  TTzaojiao
//
//  Created by hegf on 15-5-13.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TTUIChangeTool : NSObject
+(instancetype)sharedTTUIChangeTool;

-(void)backToLongon;
-(void)pushToLongon:(UINavigationController*)nav;
-(void)backToLogReg:(UINavigationController*)nav;
@end
