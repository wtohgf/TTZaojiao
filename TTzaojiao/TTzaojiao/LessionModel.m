//
//  LessionModel.m
//  TTzaojiao
//
//  Created by hegf on 15-5-9.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "LessionModel.h"

@implementation LessionModel
+(instancetype)lessionModelWithDict:(NSDictionary *)dict{
    LessionModel* mode  = [[LessionModel alloc]init];
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
     */
    
    self.class_id = [dict objectForKey:@"class_id"];
    self.time_1 = [dict objectForKey:@"time_1"];
    self.time_2 = [dict objectForKey:@"time_2"];
    self.active_id = [dict objectForKey:@"active_id"];
    self.active_name = [dict objectForKey:@"active_name"];
    self.active_intr = [dict objectForKey:@"active_intr"];
    self.active_num_blog = [dict objectForKey:@"active_num_blog"];
    self.active_num_person = [dict objectForKey:@"active_num_person"];
    self.active_user = [dict objectForKey:@"active_user"];
    self.i_pic = [dict objectForKey:@"i_pic"];

}

@end
