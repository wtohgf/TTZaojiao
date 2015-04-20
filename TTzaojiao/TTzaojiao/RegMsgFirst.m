//
//  RegMsgFirst.m
//  TTzaojiao
//
//  Created by hegf on 15-4-20.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "RegMsgFirst.h"

@implementation RegMsgFirst
+(instancetype)msgFirstWithDict:(NSDictionary *)dict{
    RegMsgFirst* mode = [[RegMsgFirst alloc]init];
    [mode setValuesForKeysWithDictionary:dict];
    return mode;
}
@end
