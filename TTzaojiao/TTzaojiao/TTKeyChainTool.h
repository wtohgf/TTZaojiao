//
//  TTKeyChainTool.h
//  TTzaojiao
//
//  Created by hegf on 15-5-6.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h> 

#define KEY_USERNAME_PASSWORD @"com.ttzaojiao.app.usernamepassword"
#define KEY_USERNAME @"com.ttzaojiao.app.username"
#define KEY_PASSWORD @"com.ttzaojiao.app.password"

@interface TTKeyChainTool : NSObject
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;
@end
