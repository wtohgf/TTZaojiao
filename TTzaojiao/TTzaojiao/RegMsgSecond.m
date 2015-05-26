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
    [mode setModeWithDictionary:dict];
    return mode;
}

-(void)setModeWithDictionary:(NSDictionary*)dict{
    /*
     @property (copy, nonatomic) NSString * msg;
     @property (copy, nonatomic) NSString * msg_word;
     @property (copy, nonatomic) NSString * p_0;
     @property (copy, nonatomic) NSString * p_1;
     @property (copy, nonatomic) NSString * p_2;
     */
    self.msg = [dict objectForKey:@"msg"];
    self.msg_word = [dict objectForKey:@"msg_word"];
    self.p_0 = [dict objectForKey:@"p_0"];
    self.p_1 = [dict objectForKey:@"p_1"];
    self.p_2 = [dict objectForKey:@"p_2"];
    
}

@end
