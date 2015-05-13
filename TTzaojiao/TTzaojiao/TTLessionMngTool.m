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
    if (block == nil) {
        return;
    }
    //uid为1977为体验用户
    if ([[TTUserModelTool sharedUserModelTool].logonUser.ttid isEqualToString:@"1977"]) {
        
        NSString* birthDay = [TTUserModelTool sharedUserModelTool].logonUser.birthday;
        
        NSArray* birthDaylist = [birthDay componentsSeparatedByString:@"-"];
        
        NSDictionary* parameters = @{
                                     @"i_year":birthDaylist[0],
                                     @"i_month":birthDaylist[1],
                                     @"i_day":birthDaylist[2],
                                     };
        
        [[AFAppDotNetAPIClient sharedClient]apiGet:GET_ME_CLASS_NOW_EXPERIENCE Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
            if (result_status == ApiStatusSuccess) {
                if ([result_data isKindOfClass:[NSMutableArray class]]) {
                    if (((NSMutableArray*)result_data).count > 0) {
                        NSDictionary* dict = [result_data firstObject];
                        if (dict!=nil) {
                            NSString* lessionID = [dict objectForKey:@"Get_Me_Class_Now"];
                            block(lessionID);
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

    }else{
    
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
                            block(lessionID);
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
}

+(void)getWeekLessions:(NSString *)lessionID Result:(WeekLessionBlock)block{
    if (block == nil) {
        return;
    }
    //uid为1977为体验用户
    if ([[TTUserModelTool sharedUserModelTool].logonUser.ttid isEqualToString:@"1977"]) {
        NSString* birthDay = [TTUserModelTool sharedUserModelTool].logonUser.birthday;
        
        NSArray* birthDaylist = [birthDay componentsSeparatedByString:@"-"];
        
        NSDictionary* parameters = @{
                                     @"id": lessionID,
                                     @"i_year":birthDaylist[0],
                                     @"i_month":birthDaylist[1],
                                     @"i_day":birthDaylist[2]
                                     };
        
        [[AFAppDotNetAPIClient sharedClient]apiGet:GET_ME_CLASS_INFO_EXPERIENCE Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
            
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

        
    }else{
    
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
}

+(void)getDetailLessionInfo:(NSString*)activeID Result:(DetailLessionBlock)block{
    if (block == nil) {
        return;
    }
    NSDictionary* parameters = @{
                                 @"i_uid": [TTUserModelTool sharedUserModelTool].logonUser.ttid,
                                 @"i_psd": [TTUserModelTool sharedUserModelTool].password,
                                 @"id": activeID,
                                 };
    
    [[AFAppDotNetAPIClient sharedClient]apiGet:GET_LESSON_DETAIL_INFO Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        
        if (result_status == ApiStatusSuccess) {
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                NSMutableArray* retList = (NSMutableArray*)result_data;
                if (retList.count > 0) {
                    DetailLessionModel* detailLession = [retList firstObject];
                    block(detailLession);
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

+(void)getLessionVideoPath:(NSString *)activeID Result:(LessionVideoPathBlock)block{
    if (block == nil) {
        return;
    }
    NSDictionary* parameters = @{
                                 @"i_uid": [TTUserModelTool sharedUserModelTool].logonUser.ttid,
                                 @"i_psd": [TTUserModelTool sharedUserModelTool].password,
                                 @"id": activeID,
                                 };
    
    [[AFAppDotNetAPIClient sharedClient]apiGet:GET_LESSON_VIDEO_PATH Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        
        if (result_status == ApiStatusSuccess) {
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                NSMutableArray* retList = (NSMutableArray*)result_data;
                if (retList.count > 0) {
                    NSDictionary* ret = [retList firstObject];
                    if ([[ret objectForKey:@"msg"] isEqualToString:@"1"]) {
                        NSString* videoPath = [ret objectForKey:@"msg_word"];
                        block(videoPath);
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
