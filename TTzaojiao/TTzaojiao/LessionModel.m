//
//  LessionModel.m
//  TTzaojiao
//
//  Created by hegf on 15-5-9.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "LessionModel.h"

@implementation LessionModel
+(instancetype)lessionModelWithDict:(NSDictionary *)dict{
    LessionModel* mode  = [[LessionModel alloc]init];
    if (mode != nil) {
        [mode setValuesForKeysWithDictionary:dict];
    }
    return mode;
}
@end
