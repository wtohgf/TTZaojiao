//
//  DetailLessionModel.m
//  TTzaojiao
//
//  Created by hegf on 15-5-11.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "DetailLessionModel.h"

@implementation DetailLessionModel
+(instancetype)detailLessionModelWithDict:(NSDictionary *)dict{
    DetailLessionModel* mode  = [[DetailLessionModel alloc]init];
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
     @property (copy, nonatomic) NSString * active_buzhou;
     @property (copy, nonatomic) NSString * active_id;
     @property (copy, nonatomic) NSString * active_mubiao;
     @property (copy, nonatomic) NSString * active_name;
     @property (copy, nonatomic) NSString * active_num_blog;
     @property (copy, nonatomic) NSString * active_num_person;
     @property (copy, nonatomic) NSString * active_user;
     @property (copy, nonatomic) NSString * active_zhuyi;
     @property (copy, nonatomic) NSString * class_id;
     @property (copy, nonatomic) NSString * pic;
     */
    
    self.active_buzhou = [dict objectForKey:@"active_buzhou"];
    self.active_id = [dict objectForKey:@"active_id"];
    self.active_mubiao = [dict objectForKey:@"active_mubiao"];
    self.active_name = [dict objectForKey:@"active_name"];
    self.active_num_blog = [dict objectForKey:@"active_num_blog"];
    self.active_num_person = [dict objectForKey:@"active_num_person"];
    self.active_user = [dict objectForKey:@"active_user"];
    self.active_zhuyi = [dict objectForKey:@"active_zhuyi"];
    self.class_id = [dict objectForKey:@"class_id"];
    self.pic = [dict objectForKey:@"pic"];
}
@end
