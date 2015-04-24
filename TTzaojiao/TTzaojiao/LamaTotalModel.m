//
//  LamaTotalModel.m
//  TTzaojiao
//
//  Created by dalianembeded on 15/4/24.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "LamaTotalModel.h"

@implementation LamaTotalModel
+(instancetype) LamaTotalModelWithdict:(NSDictionary*)dict
{
    LamaTotalModel* mode = [[LamaTotalModel alloc]init];
    
    [mode setValuesForKeysWithDictionary:dict];
    
    return mode;
}
@end
