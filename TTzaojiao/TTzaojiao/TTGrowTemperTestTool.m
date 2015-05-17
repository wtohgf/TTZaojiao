//
//  TTGrowTemperTestTool.m
//  TTzaojiao
//
//  Created by hegf on 15-5-16.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTGrowTemperTestTool.h"

@implementation TTGrowTemperTestTool
/*
 String result = WebServer
 .requestByGet(WebServer.GROW_TEST_LIST + "&i_uid="
 + uid + "&i_psd=" + secondPassword
 + "&p_1=" + pageIndex + "&p_2=10");
 */
+(void)getTestListWithPageindex:(NSString*)pageIndex Result:(GrownTestListBlock)block{
    NSDictionary* parameters = @{
                                 @"i_uid": [TTUserModelTool sharedUserModelTool].logonUser.ttid,
                                 @"i_psd": [TTUserModelTool sharedUserModelTool].password,
                                 @"p_1": pageIndex,
                                 @"p_2": @"10"
                                 };
    
    [[AFAppDotNetAPIClient sharedClient]apiGet:GROW_TEST_LIST Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        
        if (result_status == ApiStatusSuccess) {
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                NSMutableArray* retList = (NSMutableArray*)result_data;
                if (retList.count > 0) {
                    NSDictionary* ret = [retList firstObject];
                    if ([[ret objectForKey:@"msg"] isEqualToString:@"Get_Test_ChengZhang_List"]) {
                        NSMutableArray* gymList = [retList mutableCopy];
                        [gymList removeObjectAtIndex:0];
                        block(gymList);
                    }else{
                        block(@"error");
                    }
                }else{
                    block(@"error");
                }
            }else{
                block(@"error");
            }
        }else{
            block(@"neterror");
        };
        
    }];
    
}

/*json = WebServer
.requestByGet(WebServer.GROW_TEST_SUBMIT
              + "&Weight=" + weight + "&Height="
              + stature + "&i_uid=" + uid + "&i_psd="
              + secondPwd);
*/

/*
 json = WebServer
 .requestByGet(WebServer.GROW_TEST_GET_REPORT
 + "&i_uid=" + uid + "&i_psd=" + secondPwd
 + "&id=" + resultId);
 */

+(void)getTestReportWithResultID:(NSString*)resultId Result:(GrownTestListBlock)block{
  
        NSDictionary* parameters = @{
                                     @"i_uid": [TTUserModelTool sharedUserModelTool].logonUser.ttid,
                                     @"i_psd": [TTUserModelTool sharedUserModelTool].password,
                                     @"id": resultId,
                                     };
        
        [[AFAppDotNetAPIClient sharedClient]apiGet:GROW_TEST_GET_REPORT Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
            
            if (result_status == ApiStatusSuccess) {
                if ([result_data isKindOfClass:[NSMutableArray class]]) {
                    NSMutableArray* retList = (NSMutableArray*)result_data;
                    if (retList.count > 0) {
                        NSDictionary* ret = [retList firstObject];
                        if ([[ret objectForKey:@"msg"] isEqualToString:@"Get_Test_ChengZhang_List_View"]) {
                            
                            NSMutableArray* reportList = [retList mutableCopy];
                            [reportList removeObjectAtIndex:0];
                            NSDictionary* reportDict = [reportList firstObject];
                            block(reportDict);
                        }else{
                            block(@"error");
                        }
                    }else{
                        block(@"error");
                    }
                }else{
                    block(@"error");
                }
            }else{
                block(@"neterror");
            };
            
        }];
}
/*
 json = WebServer
 .requestByGet(WebServer.GROW_TEST_SUBMIT
 + "&Weight=" + weight + "&Height="
 + stature + "&i_uid=" + uid + "&i_psd="
 + secondPwd);
 */

+(void)submitGrowTestWithWeight:(NSString*)weight Height:(NSString*)height Result:(GrownTestListBlock)block{
    
    NSDictionary* parameters = @{
                                 @"i_uid": [TTUserModelTool sharedUserModelTool].logonUser.ttid,
                                 @"i_psd": [TTUserModelTool sharedUserModelTool].password,
                                 @"Weight": weight,
                                 @"Height": height
                                 };
    
    [[AFAppDotNetAPIClient sharedClient]apiGet:GROW_TEST_SUBMIT Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        
        if (result_status == ApiStatusSuccess) {
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                NSMutableArray* retList = (NSMutableArray*)result_data;
                if (retList.count > 0) {
                    NSDictionary* ret = [retList firstObject];
                    if ([[ret objectForKey:@"msg"] isEqualToString:@"Get_Test_ChengZhang"]) {
                        block(ret);
                    }else{
                        if ([ret objectForKey:@"msg_word"]!= nil) {
                            block([ret objectForKey:@"msg_word"]);
                        }else{
                            block(@"error");
                        }
                    }
                }else{
                    block(@"error");
                }
            }else{
                block(@"error");
            }
        }else{
            block(@"neterror");
        };
        
    }];
}
@end
