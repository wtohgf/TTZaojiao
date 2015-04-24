//
//  LamaModel.m
//  TTzaojiao
//
//  Created by dalianembeded on 15/4/24.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "LamaModel.h"

@implementation LamaModel
+(instancetype)LamaModelWithDict:(NSDictionary *)dict{
    LamaModel* mode = [[LamaModel alloc]init];
    
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
