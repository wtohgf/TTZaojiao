//
//  NearByBabyModel.h
//  TTzaojiao
//
//  Created by hegf on 15-5-8.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 Printing description of [0]->[0]:
 {
 msg = "Get_Test_User_List_Distance";
 "p_0" = 1;
 "p_1" = 3;
 "p_2" = 25;
 }
 Printing description of [1]->[1]:
 {
 Birthday = "2014-12-9";
 Sex = 1;
 "baby_name" = "\U970d\U6893\U6ca3";
 face = "/file/image/201504121947012146.png";
 "i_distance" = "8142.99";
 "i_distance_time" = "";
 "i_intr" = "";
 "sort_end_time" = "2015-4-12 19:47:23";
 uid = 40651;
 }
 */
@interface NearByBabyModel : NSObject
@property (copy, nonatomic) NSString * msg;
@property (copy, nonatomic) NSString * p_0;
@property (copy, nonatomic) NSString * p_1;
@property (copy, nonatomic) NSString * p_2;
@property (copy, nonatomic) NSString * Birthday;
@property (copy, nonatomic) NSString * Sex;
@property (copy, nonatomic) NSString * baby_name;
@property (copy, nonatomic) NSString * face;
@property (copy, nonatomic) NSString * i_distance;
@property (copy, nonatomic) NSString * i_distance_time;
@property (copy, nonatomic) NSString * i_intr;
@property (copy, nonatomic) NSString * sort_end_time;
@property (copy, nonatomic) NSString * uid;

+(instancetype)nearByBabyWithDict:(NSDictionary*) dict;

@end


