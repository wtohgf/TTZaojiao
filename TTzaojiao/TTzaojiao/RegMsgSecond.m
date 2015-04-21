//
//  RegMsgSecond.m
//  TTzaojiao
//
//  Created by hegf on 15-4-21.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "RegMsgSecond.h"

@implementation RegMsgSecond
+(instancetype)msgSecondWithDict:(NSDictionary *)dict{
    RegMsgSecond* mode = [[RegMsgSecond alloc]init];
    if ([dict[@"msg"] isEqualToString:@"Err_Normal"]) {
        [mode setValuesForKeysWithDictionary:dict];
    }else{
        mode.msg = dict[@"msg"];
    }
    return mode;
}
@end
