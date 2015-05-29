//
//  YuyingModel.m
//  TTzaojiao
//
//  Created by hegf on 15-5-29.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "YuyingModel.h"

@implementation YuyingModel
+(instancetype)yuyingModelWithDict:(NSDictionary *)dict{
    YuyingModel* mode = [[YuyingModel alloc]init];
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
     */
    self.i_CityName = [dict objectForKey:@"i_CityName"];
    self.i_city = [dict objectForKey:@"i_city"];
    self.i_distance_time = [dict objectForKey:@"i_distance_time"];
    self.i_intr = [dict objectForKey:@"i_intr"];
    self.i_nickname = [dict objectForKey:@"i_nickname"];
    self.i_num = [dict objectForKey:@"i_num"];
    self.i_photo = [dict objectForKey:@"i_photo"];
    self.i_price = [dict objectForKey:@"i_price"];
    self.i_sort = [dict objectForKey:@"i_sort"];
    self.i_sort_name = [dict objectForKey:@"i_sort_name"];
    self.i_type = [dict objectForKey:@"i_type"];
    self.i_x = [dict objectForKey:@"i_x"];
    self.i_y = [dict objectForKey:@"i_y"];
    self.id = [dict objectForKey:@"id"];
}

@end
