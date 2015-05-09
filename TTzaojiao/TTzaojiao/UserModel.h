//
//  UserModel.h
//  TTzaojiao
//
//  Created by hegf on 15-4-17.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, copy) NSString * msg;
@property (nonatomic, copy) NSString * p_0;
@property (nonatomic, copy) NSString * p_1;
@property (nonatomic, copy) NSString * p_2;
@property (copy, nonatomic) NSString * msg_word;

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

+(instancetype)userModelWithDict:(NSDictionary*) dict;

@end
