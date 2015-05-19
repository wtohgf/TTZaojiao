//
//  TTWoGrowTestReportModel.h
//  TTzaojiao
//
//  Created by dalianembeded on 15/5/18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTWoGrowTestReportModel : NSObject
@property (copy, nonatomic) NSString * msg;
@property (copy, nonatomic) NSString * msg_word;
@property (copy, nonatomic) NSString * p_0;
@property (copy, nonatomic) NSString * p_1;
@property (copy, nonatomic) NSString * p_2;

@property (nonatomic,strong) NSString *Weight;
@property (nonatomic,strong) NSString *Height;
@property (nonatomic,strong) NSString *tige_sort;
@property (nonatomic,strong) NSString *pid;
@property (nonatomic,strong) NSString *yueling;
@property (nonatomic,strong) NSString *tige_sort_content;
@property (nonatomic,strong) NSString *tige_sort_content_2;
@property (nonatomic,strong) NSString *TestDate;
@property (nonatomic,strong) NSString *tige_shengao_content;
@property (nonatomic,strong) NSString *tige_tizhong_content;
+(instancetype)WoGrowTestReportModelWithDict:(NSDictionary *)dict;
@end
