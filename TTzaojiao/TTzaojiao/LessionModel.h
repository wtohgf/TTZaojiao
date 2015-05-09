//
//  LessionModel.h
//  TTzaojiao
//
//  Created by hegf on 15-5-9.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 Printing description of [0]->[0]:
 {
 "class_id" = 10;
 "time_1" = "2015-5-4";
 "time_2" = "2015-5-10";
 }
 Printing description of [1]->[1]:
 {
 "active_id" = 263;
 "active_intr" = "\U901a\U8fc7\U5b9d\U5b9d\U4e0e\U5988\U5988\U7684\U4eb2\U5bc6\U914d\U5408\Uff0c\U6fc0\U53d1\U5988\U5988\U953b\U70bc\U7684\U5174\U8da3\Uff0c\U4fc3\U8fdb\U5b9d\U5b9d\U7684\U80a0\U80c3\U8815\U52a8\Uff0c\U589e\U52a0\U5b9d\U5b9d\U7684\U810a\U67f1\U5f39\U6027\Uff0c\U63d0\U9ad8\U4eb2\U5b50\U5173\U7cfb\U3002";
 "active_name" = "\U5988\U54aa\U5b9d\U8d1d\U7ec3\U745c\U4f3d\Uff08\U66f2\U5c55\U5f0f\Uff09";
 "active_num_blog" = 10127;
 "active_num_person" = 16480;
 "active_user" = "2023|/AppCode/TempFace/1.jpg,2024|/AppCode/TempFace/2.jpg,2025|/AppCode/TempFace/3.jpg,2026|/AppCode/TempFace/4.jpg,2027|/AppCode/TempFace/5.jpg,2028|/AppCode/TempFace/6.jpg,2029|/AppCode/TempFace/7.jpg,2030|/AppCode/TempFace/8.jpg,2031|/AppCode/TempFace/9.jpg,2032|/AppCode/TempFace/10.jpg,";
 "i_pic" = "/tt_file/class_photo/10/10-1-1-1.jpg";
 }
 */
@interface LessionModel : NSObject

@property (copy, nonatomic) NSString * msg;
@property (copy, nonatomic) NSString * msg_word;
@property (copy, nonatomic) NSString * p_0;
@property (copy, nonatomic) NSString * p_1;
@property (copy, nonatomic) NSString * p_2;

@property (copy, nonatomic) NSString * class_id;
@property (copy, nonatomic) NSString * time_1;
@property (copy, nonatomic) NSString * time_2;
@property (copy, nonatomic) NSString * active_id;
@property (copy, nonatomic) NSString * active_intr;
@property (copy, nonatomic) NSString * active_name;
@property (copy, nonatomic) NSString * active_num_blog;
@property (copy, nonatomic) NSString * active_num_person;
@property (copy, nonatomic) NSString * active_user;
@property (copy, nonatomic) NSString * i_pic;

+(instancetype)lessionModelWithDict:(NSDictionary*)dict;

@end
