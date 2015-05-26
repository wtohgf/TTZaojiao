//
//  WoVipModel.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/5/6.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "WoVipModel.h"

@implementation WoVipModel

+(instancetype)woVipModelWithDict:(NSDictionary *)dict{
    WoVipModel* mode = [[WoVipModel alloc]init];
    
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
     @property (nonatomic, copy) NSString * i_month;
     @property (nonatomic, copy) NSString * i_price;
     @property (nonatomic, copy) NSString * ttid;
     */
    self.i_month = [dict objectForKey:@"i_month"];
    self.i_price = [dict objectForKey:@"i_price"];
    self.ttid = [dict objectForKey:@"id"];
}


@end
