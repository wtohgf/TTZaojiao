//
//  NetworkHelper.h
//  LoveSport
//
//  Created by Liang Zhang on 14/11/28.
//  Copyright (c) 2014年 bangtianxia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"

#define UID @"com.bbhouses.uid"
#define USERNAME @"com.bbhouses.username"

@interface NetworkHelper : NSObject

+ (id)makeModelValueWithKey:(NSString *)key Model:(NSDictionary *)modelDic Null:(id)Null;
+ (NSString *)makeDateStringWithString:(NSString *)dateStr;
+ (void)isNetWorkReachable:(void (^)(AFNetworkReachabilityStatus result_ntwk_status))result;
+ (NSString *)makeMessageOfApiException:(NSInteger)code API:(NSString *)api;

@end
