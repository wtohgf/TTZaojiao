//
//  BlogUserDynamicModel.h
//  TTzaojiao
//
//  Created by hegf on 15-4-30.
//  Copyright (c) 2015年 hegf. All rights reserved.
//
/*{
 "i_Album" = 0;
 "i_Forward" = 0;
 "i_Forward_Num" = 0;
 "i_class_part" = 0;
 "i_content" = "\U56db\U5c81\U591a\U5c0f\U5b69\U7761\U89c9\U8001\U662f\U5c3f\U5e8a\U5927\U5bb6\U6709\U4ec0\U4e48\U597d\U529e\U6cd5\U5417\Uff1f";
 "i_distance_time" = "2015-4-29 14:49:38";
 "i_hidden" = 0;
 "i_item" = 0;
 "i_master" = "";
 "i_month" = 2;
 "i_otime" = "2015-4-29 14:49:38";
 "i_pic" = "";
 "i_replay" = 0;
 "i_sort" = 1;
 "i_uid" = 40993;
 "i_x" = "39.766448";
 "i_y" = "116.502023";
 "i_zan" = 5;
 id = 1228;
 }
 */
#import <Foundation/Foundation.h>

@interface BlogUserDynamicModel : NSObject
@property (copy, nonatomic) NSString * msg;
@property (copy, nonatomic) NSString * msg_word;
@property (copy, nonatomic) NSString * p_0;
@property (copy, nonatomic) NSString * p_1;
@property (copy, nonatomic) NSString * p_2;

@property (copy, nonatomic) NSString * i_Album;
@property (copy, nonatomic) NSString * i_Forward;
@property (copy, nonatomic) NSString * i_Forward_Num;
@property (copy, nonatomic) NSString * i_class_part;
@property (copy, nonatomic) NSString * i_content;
@property (copy, nonatomic) NSString * i_distance_time;
@property (copy, nonatomic) NSString * i_hidden;
@property (copy, nonatomic) NSString * i_item;
@property (copy, nonatomic) NSString * i_master;
@property (copy, nonatomic) NSString * i_month;
@property (copy, nonatomic) NSString * i_otime;
@property (copy, nonatomic) NSString * i_pic;
@property (copy, nonatomic) NSString * i_replay;
@property (copy, nonatomic) NSString * i_sort;
@property (copy, nonatomic) NSString * i_uid;
@property (copy, nonatomic) NSString * i_x;
@property (copy, nonatomic) NSString * i_y;
@property (copy, nonatomic) NSString * i_zan;
@property (copy, nonatomic) NSString * id;

@property (strong, nonatomic) NSArray* photosURLStr;

+(instancetype)blogUserDynamicModelWithDict:(NSDictionary*)dict;
@end
