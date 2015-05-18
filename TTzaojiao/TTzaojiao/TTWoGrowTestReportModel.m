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
    
    if ([dict objectForKey:@"id"] != nil) {
        NSMutableDictionary* tmpdict = [dict mutableCopy];
        [tmpdict setObject:dict[@"id"] forKey:@"pid"];
        [tmpdict removeObjectForKey:@"id"];
        [mode setValuesForKeysWithDictionary:tmpdict];
    }else{
        mode = nil;
    }
    return mode;
}
@end
