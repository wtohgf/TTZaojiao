//
//  DynamicUserModel.m
//  TTzaojiao
//
//  Created by hegf on 15-4-27.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "DynamicUserModel.h"

@implementation DynamicUserModel
+(instancetype)dynamicUserModelWithDict:(NSDictionary *)dict{
    DynamicUserModel* mode = [[DynamicUserModel alloc]init];
    if (mode != nil) {
        [mode setValuesForKeysWithDictionary:dict];
    }
    return mode;
}
@end
