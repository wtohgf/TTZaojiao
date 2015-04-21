//
//  RegMsgSecond.h
//  TTzaojiao
//
//  Created by hegf on 15-4-21.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegMsgSecond : NSObject
@property (copy, nonatomic) NSString* msg;
@property (copy, nonatomic) NSString* msg_word;

+(instancetype)msgSecondWithDict:(NSDictionary *)dict;
@end
