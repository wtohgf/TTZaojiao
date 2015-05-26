//
//  DynamicUserModel.m
//  TTzaojiao
//
//  Created by hegf on 15-4-27.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "DynamicUserModel.h"

@implementation DynamicUserModel
+(instancetype)dynamicUserModelWithDict:(NSDictionary *)dict{
    DynamicUserModel* mode = [[DynamicUserModel alloc]init];
    if (mode != nil) {
        [mode setModeWithDictionary:dict];
    }
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
    
    /*
     @property (copy, nonatomic) NSString * baby_jifen;
     @property (copy, nonatomic) NSString * birthday;
     @property (copy, nonatomic) NSString * gender;
     @property (copy, nonatomic) NSString * i_Cover;
     @property (copy, nonatomic) NSString * i_distance_time;
     @property (copy, nonatomic) NSString * i_intr;
     @property (copy, nonatomic) NSString * i_x;
     @property (copy, nonatomic) NSString * i_y;
     @property (copy, nonatomic) NSString * icon;
     @property (copy, nonatomic) NSString * name;
     @property (copy, nonatomic) NSString * type;
     @property (copy, nonatomic) NSString * uid;
     @property (copy, nonatomic) NSString * vip_time;
     */
    
    self.baby_jifen = [dict objectForKey:@"baby_jifen"];
    self.birthday = [dict objectForKey:@"birthday"];
    self.gender = [dict objectForKey:@"gender"];
    self.i_Cover = [dict objectForKey:@"i_Cover"];
    self.i_distance_time = [dict objectForKey:@"i_distance_time"];
    self.i_intr = [dict objectForKey:@"i_intr"];
    self.i_x = [dict objectForKey:@"i_x"];
    self.i_y = [dict objectForKey:@"i_y"];
    self.icon = [dict objectForKey:@"icon"];
    self.name = [dict objectForKey:@"name"];
    self.type = [dict objectForKey:@"type"];
    self.uid = [dict objectForKey:@"uid"];
    self.vip_time = [dict objectForKey:@"vip_time"];
}

@end
