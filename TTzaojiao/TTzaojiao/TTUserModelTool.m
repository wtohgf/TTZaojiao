//
//  TTUserModelTool.m
//  TTzaojiao
//
//  Created by hegf on 15-4-18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTUserModelTool.h"

static TTUserModelTool* tool;

@implementation TTUserModelTool

+(instancetype)sharedUserModelTool{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        tool = [[TTUserModelTool alloc]init];
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


@end
