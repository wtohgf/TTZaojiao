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


+(void)getTempTestListWithPageindex:(NSString*)pageIndex Result:(GrownTestListBlock)block{
    NSDictionary* parameters = @{
                                 @"i_uid": [TTUserModelTool sharedUserModelTool].logonUser.ttid,
                                 @"i_psd": [TTUserModelTool sharedUserModelTool].password,
                                 @"p_1": pageIndex,
                                 @"p_2": @"10"
                                 };
    
    [[AFAppDotNetAPIClient sharedClient]apiGet:TEMPERAMENT_TEST_LIST Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        
        if (result_status == ApiStatusSuccess) {
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                NSMutableArray* retList = (NSMutableArray*)result_data;
                if (retList.count > 0) {
                    NSDictionary* ret = [retList firstObject];
                    if ([[ret objectForKey:@"msg"] isEqualToString:@"Get_Test_QiZhi_List"]) {
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

+(void)getTempReportWithResultID:(NSString*)resultId Result:(GrownTestListBlock)block{
    
    NSDictionary* parameters = @{
                                 @"i_uid": [TTUserModelTool sharedUserModelTool].logonUser.ttid,
                                 @"i_psd": [TTUserModelTool sharedUserModelTool].password,
                                 @"id": resultId,
                                 };
    
    [[AFAppDotNetAPIClient sharedClient]apiGet:TEMPERAMENT_REPORT Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        
        if (result_status == ApiStatusSuccess) {
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                NSMutableArray* retList = (NSMutableArray*)result_data;
                if (retList.count > 0) {
                    NSDictionary* ret = [retList firstObject];
                    block(ret);
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
 final String path = WebServer.TEMPERAMENT_TEST + "&i_uid=" + uid
 + "&i_psd=" + secondPassword + "&timu_sort=" + timuSort
 + "&i_1=" + i1 + "&i_2=" + i2 + "&i_3=" + i3 + "&i_4=" + i4
 + "&i_5=" + i5 + "&i_6=" + i6 + "&i_7=" + i7 + "&i_8=" + i8
 + "&i_9=" + i9 + "&timu_id=" + timuId + "&timu_fenshu="
 + timuFenshu + partPath;
 */
/*
 if (isFirstTest) {
 partPath = "&sort_date=0&ok=0";
 } else {
 partPath = "&timu_check=" + timuCheck + "&sort_date=" + sortDate;
 }
 */

/*
 {
 "i_1" = 0;
 "i_2" = 0;
 "i_3" = 0;
 "i_4" = 0;
 "i_5" = 0;
 "i_6" = 0;
 "i_7" = 0;
 "i_8" = 0;
 "i_9" = 0;
 msg = "Get_Test_Qizhi";
 "sort_date" = 1;
 "timu_content" = "\U6bcf\U5929\U5b69\U5929\U5403\U4e00\U5b9a\U6570\U91cf\U7684\U5976\U3002";
 "timu_fenshu" = 0;
 "timu_id" = 1;
 "timu_sort" = 1;
 }
 )
 */
+(void)startTempTestWithFrist:(BOOL)isFrist timuCheck:(NSString *)timuCheck Result:(GrownTestListBlock)block{
    
    static NSString* timuSort = @"0";
    static NSString* timuFenshu = @"0";
    static NSString* timuId = @"0";
    static NSString* sortDate = @"0";
    
    static NSString* i1 = @"0";
    static NSString* i2 = @"0";
    static NSString* i3 = @"0";
    static NSString* i4 = @"0";
    static NSString* i5 = @"0";
    static NSString* i6 = @"0";
    static NSString* i7 = @"0";
    static NSString* i8 = @"0";
    static NSString* i9 = @"0";
    
    NSDictionary* parameters;
    
    if (isFrist) {
        timuSort = @"0";
        timuFenshu = @"0";
        timuId = @"0";
        sortDate = @"0";
        
        i1 = @"0";
        i2 = @"0";
        i3 = @"0";
        i4 = @"0";
        i5 = @"0";
        i6 = @"0";
        i7 = @"0";
        i8 = @"0";
        i9 = @"0";
        
        NSDictionary* tparameters = @{
                                      @"i_uid": [TTUserModelTool sharedUserModelTool].logonUser.ttid,
                                      @"i_psd": [TTUserModelTool sharedUserModelTool].password,
                                      @"timu_sort":timuSort,
                                      @"i_1":i1,
                                      @"i_2":i2,
                                      @"i_3":i3,
                                      @"i_4":i4,
                                      @"i_5":i5,
                                      @"i_6":i6,
                                      @"i_7":i7,
                                      @"i_8":i8,
                                      @"i_9":i9,
                                      @"timu_id":timuId,
                                      @"timu_fenshu":timuFenshu,
                                      @"sort_date":sortDate,
                                      @"ok":@"0"
                                      };
        parameters = tparameters;
    }else{
        NSDictionary* tparameters = @{
                                      @"i_uid": [TTUserModelTool sharedUserModelTool].logonUser.ttid,
                                      @"i_psd": [TTUserModelTool sharedUserModelTool].password,
                                      @"timu_sort":timuSort,
                                      @"i_1":i1,
                                      @"i_2":i2,
                                      @"i_3":i3,
                                      @"i_4":i4,
                                      @"i_5":i5,
                                      @"i_6":i6,
                                      @"i_7":i7,
                                      @"i_8":i8,
                                      @"i_9":i9,
                                      @"timu_id":timuId,
                                      @"timu_fenshu":timuFenshu,
                                      @"timu_check":timuCheck,
                                      @"sort_date":sortDate
                                      };
        parameters = tparameters;
    }
    
    [[AFAppDotNetAPIClient sharedClient]apiGet:TEMPERAMENT_TEST Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        
        if (result_status == ApiStatusSuccess) {
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                NSMutableArray* retList = (NSMutableArray*)result_data;
                if (retList.count > 0) {
                    NSDictionary* ret = [retList firstObject];
                    
                    if ([[ret objectForKey:@"msg"] isEqualToString:@"Get_Test_Qizhi"]) {
                        timuSort = ret[@"timu_sort"];
                        timuFenshu = ret[@"timu_fenshu"];
                        timuId = ret[@"timu_id"];
                        sortDate = ret[@"sort_date"];
                        
                        i1 = ret[@"i_1"];
                        i2 = ret[@"i_2"];
                        i3 = ret[@"i_3"];
                        i4 = ret[@"i_4"];
                        i5 = ret[@"i_5"];
                        i6 = ret[@"i_6"];
                        i7 = ret[@"i_7"];
                        i8 = ret[@"i_8"];
                        i9 = ret[@"i_9"];
                        block(ret);
                    }else if([[ret objectForKey:@"msg"] isEqualToString:@"Get_Test_Qizhi_Ok"]){
                        //测评完成
                        block(ret);
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


@end
