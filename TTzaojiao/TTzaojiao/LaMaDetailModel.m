//
//  LaMaDetailModel.m
//  TTzaojiao
//
//  Created by dalianembeded on 15/4/28.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "LaMaDetailModel.h"

@implementation LaMaDetailModel
+(instancetype)LaMaDetailModelWithDict:(NSDictionary *)dict{
    LaMaDetailModel* mode = [[LaMaDetailModel alloc]init];
    [mode setModeWithDictionary:dict];
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
     @property (nonatomic, copy) NSString * i_name;
     @property (nonatomic, copy) NSString * i_otime_end;
     @property (nonatomic, copy) NSString * i_pic;
     @property (nonatomic, copy) NSString * i_content;
     @property (nonatomic, copy) NSString * i_pic_list;
     @property (nonatomic, copy) NSString * i_company;
     @property (nonatomic, copy) NSString * i_addresss;
     @property (nonatomic, copy) NSString * i_tel;
     */
    
    self.i_name = [dict objectForKey:@"i_name"];
    self.i_otime_end = [dict objectForKey:@"i_otime_end"];
    self.i_pic = [dict objectForKey:@"i_pic"];
    self.i_content = [dict objectForKey:@"i_content"];
    self.i_pic_list = [dict objectForKey:@"i_pic_list"];
    self.i_company = [dict objectForKey:@"i_company"];
    self.i_addresss = [dict objectForKey:@"i_addresss"];
    self.i_tel = [dict objectForKey:@"i_tel"];
}

@end
