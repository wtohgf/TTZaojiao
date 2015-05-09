//
//  TTLessionMngTool.m
//  TTzaojiao
//
//  Created by hegf on 15-5-9.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTLessionMngTool.h"

@implementation TTLessionMngTool

+(void)getLessionID:(LessionIDBlock)block{
    NSDictionary* parameters = @{
                                 @"i_uid": [TTUserModelTool sharedUserModelTool].logonUser.ttid,
                                 @"i_psd": [TTUserModelTool sharedUserModelTool].password,
                                 };

    [[AFAppDotNetAPIClient sharedClient]apiGet:GET_THIS_WEEK_LESSON_ID Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        if (result_status == ApiStatusSuccess) {
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                if (((NSMutableArray*)result_data).count > 0) {
                    NSDictionary* dict = [result_data firstObject];
                    if (dict!=nil) {
                        NSString* lessionID = [dict objectForKey:@"Get_Me_Class_Now"];
                        if (block != nil) {
                            block(lessionID);
                        }else{
                            block(nil);
                        }
                    }
                    else{
                        block(nil);
                    }
                }
                else{
                    block(nil);
                }
            }
        }else{
            if (result_status != ApiStatusNetworkNotReachable) {
                [[[UIAlertView alloc]init] showWithTitle:@"友情提示" message:@"服务器好像罢工了" cancelButtonTitle:@"重试一下"];
            }
            block(nil);
        };
        
    }];
}

+(void)getWeekLessions:(NSString *)lessionID Result:(WeekLessionBlock)block{
    NSDictionary* parameters = @{
                                 @"i_uid": [TTUserModelTool sharedUserModelTool].logonUser.ttid,
                                 @"i_psd": [TTUserModelTool sharedUserModelTool].password,
                                 @"id": lessionID,
                                 };

    [[AFAppDotNetAPIClient sharedClient]apiGet:GET_LESSON_INFO Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {

        if (result_status == ApiStatusSuccess) {
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                NSMutableArray* retList = (NSMutableArray*)result_data;
                if (retList.count > 0) {
                    LessionModel* lessionheader = [retList firstObject];
                    if(lessionheader.active_id == nil){
                        [retList removeObject:lessionheader];
                    }
                    if (block!=nil && retList.count > 0) {
                        block(retList);
                    }else{
                        block(nil);
                    }
                }else{
                    block(nil);
                }
            }else{
                block(nil);
            }
        }else{
            if (result_status != ApiStatusNetworkNotReachable) {
                [[[UIAlertView alloc]init] showWithTitle:@"友情提示" message:@"服务器好像罢工了" cancelButtonTitle:@"重试一下"];
            }
            block(nil);
        };
        
    }];
}
@end
