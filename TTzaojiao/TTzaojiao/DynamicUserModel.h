//
//  DynamicUserModel.h
//  TTzaojiao
//
//  Created by hegf on 15-4-27.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "baby_jifen" = 8;
 birthday = "2014-9-1";
 gender = 1;
 "i_Cover" = "";
 "i_distance_time" = "";
 "i_intr" = "";
 "i_x" = "37.380633";
 "i_y" = "115.970769";
 icon = "/file/image/201504261639226171.png";
 name = "\U738b\U4f73\U9716";
 type = 0;
 uid = 40934;
 "vip_time" = "2015-7-26 16:46:09";
 */
@interface DynamicUserModel : NSObject

@property (nonatomic, copy) NSString * msg;
@property (nonatomic, copy) NSString * p_0;
@property (nonatomic, copy) NSString * p_1;
@property (nonatomic, copy) NSString * p_2;

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

+(instancetype)dynamicUserModelWithDict:(NSDictionary*)dict;

@end
