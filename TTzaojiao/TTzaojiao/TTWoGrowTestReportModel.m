//
//  TTWoGrowTestReportModel.m
//  TTzaojiao
//
//  Created by dalianembeded on 15/5/18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoGrowTestReportModel.h"

@implementation TTWoGrowTestReportModel
+(instancetype)WoGrowTestReportModelWithDict:(NSDictionary *)dict{
    TTWoGrowTestReportModel* mode = [[TTWoGrowTestReportModel alloc]init];
    if (mode) {
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
     */
    
    self.Weight = [dict objectForKey:@"Weight"];
    self.Height = [dict objectForKey:@"Height"];
    self.tige_sort = [dict objectForKey:@"tige_sort"];
    self.pid = [dict objectForKey:@"id"];
    self.yueling = [dict objectForKey:@"yueling"];
    self.tige_sort_content = [dict objectForKey:@"tige_sort_content"];
    self.tige_sort_content_2 = [dict objectForKey:@"tige_sort_content_2"];
    self.TestDate = [dict objectForKey:@"TestDate"];
    self.tige_shengao_content = [dict objectForKey:@"tige_shengao_content"];
    self.tige_tizhong_content = [dict objectForKey:@"tige_tizhong_content"];
}

@end
