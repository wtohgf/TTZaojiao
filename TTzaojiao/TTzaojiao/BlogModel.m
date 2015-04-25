//
//  BlogModel.m
//  TTzaojiao
//
//  Created by hegf on 15-4-24.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "BlogModel.h"

@implementation BlogModel
+(instancetype)blogModeWithDict:(NSDictionary *)dict{
    BlogModel* blog = [[BlogModel alloc]init];
    if ([dict objectForKey:@"id"] == nil) {
        return nil;
    }
    [blog setValuesForKeysWithDictionary:dict];
    return blog;
}
@end
