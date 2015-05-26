//
//  LamaModel.m
//  TTzaojiao
//
//  Created by dalianembeded on 15/4/24.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "LamaModel.h"

@implementation LamaModel
+(instancetype)LamaModelWithDict:(NSDictionary *)dict{
    LamaModel* mode = [[LamaModel alloc]init];
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
     @property (nonatomic, copy) NSString * ttid;
     */
    
    self.i_name = [dict objectForKey:@"i_name"];
    self.i_otime_end = [dict objectForKey:@"i_otime_end"];
    self.i_pic = [dict objectForKey:@"i_pic"];
    self.ttid = [dict objectForKey:@"id"];

}

@end
