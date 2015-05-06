//
//  WoVipModel.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/5/6.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "WoVipModel.h"

@implementation WoVipModel

+(instancetype)woVipModelWithDict:(NSDictionary *)dict{
    WoVipModel* mode = [[WoVipModel alloc]init];
    
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
