//
//  UserModel.m
//  TTzaojiao
//
//  Created by hegf on 15-4-17.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+(instancetype)userModelWithDict:(NSDictionary *)dict{
    UserModel* mode = [[UserModel alloc]init];
    if ([dict objectForKey:@"id"] != nil) {
        NSMutableDictionary* tmpdict = [dict mutableCopy];
        [tmpdict setObject:dict[@"id"] forKey:@"ttid"];
        [tmpdict removeObjectForKey:@"id"];
        [mode setValuesForKeysWithDictionary:tmpdict];
    }else{
        mode = nil;
    }
    return mode;
}

@end
