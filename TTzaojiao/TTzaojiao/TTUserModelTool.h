//
//  TTUserModelTool.h
//  TTzaojiao
//
//  Created by hegf on 15-4-18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "DynamicUserModel.h"

typedef void (^DynamicUserGet)(DynamicUserModel* user);

@interface TTUserModelTool : NSObject
+(instancetype)sharedUserModelTool;

@property (strong, nonatomic) UserModel* logonUser;
@property (copy, nonatomic) NSString * password;
@property (copy, nonatomic) NSString * account;

-(NSString*)group;
-(NSString*)mouth;

+(void)getUserInfo:(NSString*)uid Result:(DynamicUserGet)block;

@end
