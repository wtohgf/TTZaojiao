//
//  BlogReplayModel.m
//  TTzaojiao
//
//  Created by hegf on 15-4-25.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "BlogReplayModel.h"

@implementation BlogReplayModel
+(instancetype)blogReplayModelWithDict:(NSDictionary *)dict{

    BlogReplayModel* model = [[BlogReplayModel alloc]init];
    if (model) {
        [model setModeWithDictionary:dict];
    }
    return model;
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
     @property (copy, nonatomic) NSString * Birthday;
     @property (copy, nonatomic) NSString * baby_name;
     @property (copy, nonatomic) NSString * face;
     @property (copy, nonatomic) NSString * i_content;
     @property (copy, nonatomic) NSString * i_distance_time;
     @property (copy, nonatomic) NSString * i_otime;
     @property (copy, nonatomic) NSString * i_uid;
     @property (copy, nonatomic) NSString * i_x;
     @property (copy, nonatomic) NSString * i_y;
     @property (copy, nonatomic) NSString * id;
     */
    
    self.Birthday = [dict objectForKey:@"Birthday"];
    self.baby_name = [dict objectForKey:@"baby_name"];
    self.face = [dict objectForKey:@"face"];
    self.i_content = [dict objectForKey:@"i_content"];
    self.i_distance_time = [dict objectForKey:@"i_distance_time"];
    self.i_otime = [dict objectForKey:@"i_otime"];
    self.i_uid = [dict objectForKey:@"i_uid"];
    self.i_x = [dict objectForKey:@"i_x"];
    self.i_y = [dict objectForKey:@"i_y"];
    self.id = [dict objectForKey:@"id"];
}

@end
