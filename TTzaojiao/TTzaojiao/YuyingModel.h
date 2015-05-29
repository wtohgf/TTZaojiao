//
//  YuyingModel.h
//  TTzaojiao
//
//  Created by hegf on 15-5-29.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {
 "i_CityName" = "\U5927\U8fde\U5e02";
 "i_city" = 210200;
 "i_distance_time" = "";
 "i_intr" = "\U6211\U662f\U4e13\U4e1a\U7684\Uff0c\U6211\U662f\U6700\U68d2\U7684\Uff01";
 "i_nickname" = "\U5c0f\U4e3d";
 "i_num" = 4;
 "i_photo" = "/File/image/20150514/20150514121371657165.jpg|/File/image/20150514/20150514121346434643.jpg|";
 "i_price" = 120;
 "i_sort" = 1;
 "i_sort_name" = "\U5165\U6237\U6307\U5bfc";
 "i_type" = "|\U80ce\U6559|\U6bcd\U5a74\U4fdd\U5065|\U996e\U98df\U4e0e\U8425\U517b|";
 "i_x" = 0;
 "i_y" = 0;
 id = 6000010;
 }
 */
@interface YuyingModel : NSObject
@property (copy, nonatomic) NSString * msg;
@property (copy, nonatomic) NSString * msg_word;
@property (copy, nonatomic) NSString * p_0;
@property (copy, nonatomic) NSString * p_1;
@property (copy, nonatomic) NSString * p_2;

@property (copy, nonatomic) NSString * i_CityName;
@property (copy, nonatomic) NSString * i_city;
@property (copy, nonatomic) NSString * i_distance_time;
@property (copy, nonatomic) NSString * i_intr;
@property (copy, nonatomic) NSString * i_nickname;
@property (copy, nonatomic) NSString * i_num;
@property (copy, nonatomic) NSString * i_photo;
@property (copy, nonatomic) NSString * i_price;
@property (copy, nonatomic) NSString * i_sort;
@property (copy, nonatomic) NSString * i_sort_name;
@property (copy, nonatomic) NSString * i_type;
@property (copy, nonatomic) NSString * i_x;
@property (copy, nonatomic) NSString * i_y;
@property (copy, nonatomic) NSString * id;
+(instancetype)yuyingModelWithDict:(NSDictionary *)dict;
@end
