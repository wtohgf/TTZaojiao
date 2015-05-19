//
//  WoVipModel.h
//  TTzaojiao
//
//  Created by Liang Zhang on 15/5/6.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WoVipModel : NSObject
@property (copy, nonatomic) NSString * msg;
@property (copy, nonatomic) NSString * msg_word;
@property (copy, nonatomic) NSString * p_0;
@property (copy, nonatomic) NSString * p_1;
@property (copy, nonatomic) NSString * p_2;

@property (nonatomic, copy) NSString * i_month;
@property (nonatomic, copy) NSString * i_price;
@property (nonatomic, copy) NSString * ttid;
+(instancetype)woVipModelWithDict:(NSDictionary *)dict;
@end
