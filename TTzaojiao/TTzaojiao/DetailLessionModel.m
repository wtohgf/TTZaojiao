//
//  DetailLessionModel.m
//  TTzaojiao
//
//  Created by hegf on 15-5-11.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "DetailLessionModel.h"

@implementation DetailLessionModel
+(instancetype)detailLessionModelWithDict:(NSDictionary *)dict{
    DetailLessionModel* mode  = [[DetailLessionModel alloc]init];
    if (mode != nil) {
        [mode setValuesForKeysWithDictionary:dict];
    }
    return mode;
}
@end
