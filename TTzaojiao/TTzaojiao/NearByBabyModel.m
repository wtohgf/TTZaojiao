//
//  NearByBabyModel.m
//  TTzaojiao
//
//  Created by hegf on 15-5-8.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "NearByBabyModel.h"

@implementation NearByBabyModel
+(instancetype)nearByBabyWithDict:(NSDictionary *)dict{
    NearByBabyModel* mode = [[NearByBabyModel alloc]init];
    if (mode != nil) {
        [mode setValuesForKeysWithDictionary:dict];
    }
    return mode;
}
@end
