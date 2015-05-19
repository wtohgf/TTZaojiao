//
//  RegMsgFirst.h
//  TTzaojiao
//
//  Created by hegf on 15-4-20.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegMsgFirst : NSObject
@property (copy, nonatomic) NSString * msg;
@property (copy, nonatomic) NSString * msg_word;
@property (copy, nonatomic) NSString * p_0;
@property (copy, nonatomic) NSString * p_1;
@property (copy, nonatomic) NSString * p_2;

+(instancetype)msgFirstWithDict:(NSDictionary *)dict;
@end
