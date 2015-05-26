//
//  NearByBabyModel.m
//  TTzaojiao
//
//  Created by hegf on 15-5-8.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "NearByBabyModel.h"

@implementation NearByBabyModel
+(instancetype)nearByBabyWithDict:(NSDictionary *)dict{
    NearByBabyModel* mode = [[NearByBabyModel alloc]init];
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
     @property (copy, nonatomic) NSString * Birthday;
     @property (copy, nonatomic) NSString * Sex;
     @property (copy, nonatomic) NSString * baby_name;
     @property (copy, nonatomic) NSString * face;
     @property (copy, nonatomic) NSString * i_distance;
     @property (copy, nonatomic) NSString * i_distance_time;
     @property (copy, nonatomic) NSString * i_intr;
     @property (copy, nonatomic) NSString * sort_end_time;
     @property (copy, nonatomic) NSString * uid;

     */
    
    self.Birthday = [dict objectForKey:@"Birthday"];
    self.Sex = [dict objectForKey:@"Sex"];
    self.baby_name = [dict objectForKey:@"baby_name"];
    self.face = [dict objectForKey:@"face"];
    self.i_distance = [dict objectForKey:@"i_distance"];
    self.i_distance_time = [dict objectForKey:@"i_distance_time"];
    self.i_intr = [dict objectForKey:@"i_intr"];
    self.sort_end_time = [dict objectForKey:@"sort_end_time"];
    self.uid = [dict objectForKey:@"uid"];

}

@end
