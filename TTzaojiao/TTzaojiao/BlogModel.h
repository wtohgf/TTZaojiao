//
//  BlogModel.h
//  TTzaojiao
//
//  Created by hegf on 15-4-24.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlogModel : NSObject
@property (copy, nonatomic) NSString * id;
@property (copy, nonatomic) NSString * i_y;
@property (copy, nonatomic) NSString * i_x;
@property (copy, nonatomic) NSString * i_distance_time;
@property (copy, nonatomic) NSString * i_otime;
@property (copy, nonatomic) NSString * i_replay;
@property (copy, nonatomic) NSString * i_zan;
@property (copy, nonatomic) NSString * i_pic;
@property (copy, nonatomic) NSString * i_content;
@property (copy, nonatomic) NSString * i_uid;
@property (copy, nonatomic) NSString * baby_name;
@property (copy, nonatomic) NSString * face;
@property (copy, nonatomic) NSString * Birthday;
@property (copy, nonatomic) NSString * replay;

+(instancetype)blogModeWithDict:(NSDictionary*)dict;

@end
