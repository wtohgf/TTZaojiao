//
//  LamaTotalModel.h
//  TTzaojiao
//
//  Created by dalianembeded on 15/4/24.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LamaTotalModel : NSObject
@property (nonatomic, copy) NSString * msg;
@property (nonatomic, copy) NSString * p_0;
@property (nonatomic, copy) NSString * p_1;
@property (nonatomic, copy) NSString * p_2;
+(instancetype) LamaTotalModelWithdict:(NSDictionary*)dict;
@end
