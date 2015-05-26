//
//  UserModel.m
//  TTzaojiao
//
//  Created by hegf on 15-4-17.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+(instancetype)userModelWithDict:(NSDictionary *)dict{
    UserModel* mode = [[UserModel alloc]init];
    if (mode){
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
     @property (nonatomic, copy) NSString * baby_jifen;
     @property (nonatomic, copy) NSString * birthday;
     @property (nonatomic, copy) NSString * city;
     @property (nonatomic, copy) NSString * gender;
     @property (nonatomic, copy) NSString * icon;
     @property (nonatomic, copy) NSString * ttid;
     @property (nonatomic, copy) NSString * id_c;
     @property (nonatomic, copy) NSString * name;
     @property (nonatomic, copy) NSString * type;
     @property (nonatomic, copy) NSString * vip;
     @property (nonatomic, copy) NSString * vip_time;
     */
    
    self.baby_jifen = [dict objectForKey:@"baby_jifen"];
    self.birthday = [dict objectForKey:@"birthday"];
    self.city = [dict objectForKey:@"city"];
    self.gender = [dict objectForKey:@"gender"];
    self.icon = [dict objectForKey:@"icon"];
    self.ttid = [dict objectForKey:@"id"];
    self.id_c = [dict objectForKey:@"id_c"];
    self.name = [dict objectForKey:@"name"];
    self.type = [dict objectForKey:@"type"];
    self.vip = [dict objectForKey:@"vip"];
    self.vip_time = [dict objectForKey:@"vip_time"];
}


@end
