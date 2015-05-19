//
//  LamaModel.h
//  TTzaojiao
//
//  Created by dalianembeded on 15/4/24.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LamaModel : NSObject
@property (copy, nonatomic) NSString * msg;
@property (copy, nonatomic) NSString * msg_word;
@property (copy, nonatomic) NSString * p_0;
@property (copy, nonatomic) NSString * p_1;
@property (copy, nonatomic) NSString * p_2;

@property (nonatomic, copy) NSString * i_name;
@property (nonatomic, copy) NSString * i_otime_end;
@property (nonatomic, copy) NSString * i_pic;
@property (nonatomic, copy) NSString * ttid;
+(instancetype)LamaModelWithDict:(NSDictionary *)dict;
@end
