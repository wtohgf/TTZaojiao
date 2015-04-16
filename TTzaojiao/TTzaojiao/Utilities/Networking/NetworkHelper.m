//
//  NetworkHelper.m
//  LoveSport
//
//  Created by Liang Zhang on 14/11/28.
//  Copyright (c) 2014年 bangtianxia. All rights reserved.
//

#import "NetworkHelper.h"

@implementation NetworkHelper

+ (id)makeModelValueWithKey:(NSString *)key Model:(NSDictionary *)modelDic Null:(id)Null {
    return ([modelDic objectForKey:key]==nil||[[modelDic objectForKey:key] isEqual:[NSNull null]])?Null:[modelDic objectForKey:key];
}

+ (NSString *)makeDateStringWithString:(NSString *)dateStr {
    NSDateFormatter *formatter_s2d = [[NSDateFormatter alloc] init] ;
    NSDateFormatter *formatter_d2s = [[NSDateFormatter alloc] init] ;
    [formatter_s2d setDateFormat:@"yyyy/MM/dd"];
    [formatter_d2s setDateFormat:NSLocalizedString(@"MM/dd/yyyy", @"MM/dd/yyyy")];
    NSDate *date=[formatter_s2d dateFromString:dateStr];
    if (date==nil) {
        [formatter_s2d setDateFormat:@"MM/dd/yyyy"];
        date = [formatter_s2d dateFromString:dateStr];
    }
    NSString *result = [formatter_d2s stringFromDate:date];
    return result;
}

+ (void)isNetWorkReachable:(void (^)(AFNetworkReachabilityStatus result_ntwk_status))result{
    
    AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [afNetworkReachabilityManager startMonitoring];
    
    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                result(AFNetworkReachabilityStatusNotReachable);
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                result(AFNetworkReachabilityStatusReachableViaWiFi);
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                result(AFNetworkReachabilityStatusReachableViaWWAN);
                break;
            }
            default:
                break;
        }
    }];
}

+ (NSString *)makeMessageOfApiException:(NSInteger)code API:(NSString *)api{
    switch (code) {
        case 0:
            return NSLocalizedString(@"Sever exception", @"Sever exception");
            break;
            
        default:
            return NSLocalizedString(@"API Error!", @"API Error!");
            break;
    }
}

@end
