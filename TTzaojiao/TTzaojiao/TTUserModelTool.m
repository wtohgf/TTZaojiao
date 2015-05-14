//
//  TTUserModelTool.m
//  TTzaojiao
//
//  Created by hegf on 15-4-18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTUserModelTool.h"
#import "NSString+Extension.h"
#import "AFAppDotNetAPIClient.h"
#import "UIAlertView+MoreAttribute.h"
#import "TTWebServerAPI.h"

static TTUserModelTool* tool;

@implementation TTUserModelTool

+(instancetype)sharedUserModelTool{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        tool = [[TTUserModelTool alloc]init];
    });
    return tool;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        tool = [super allocWithZone:zone];
    });
    return tool;
}

-(NSString *)group{
    if (_logonUser == nil) {
        return @"";
    }
    NSUInteger group = [self.mouth integerValue] / 3 + ([self.mouth integerValue]% 3 > 0 ? 1 : 0);
    if ( group > 8) {
        group = 9;
    }
    return [NSString stringWithFormat:@"%ld",group];
}

-(NSString *)mouth{
    if (_logonUser == nil) {
        return @"";
    }
    NSDate* date = [[NSDate alloc]init];
    NSDateFormatter* dateFormater = [[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    date = [dateFormater dateFromString:_logonUser.birthday];
    
    NSString* mouth = [NSString getMounthOfDate:date];
    return mouth;
}


+(void)getUserInfo:(NSString *)uid Result:(DynamicUserGet)block{
    NSDictionary* parameters = @{
                                 @"i_uid": uid,
                                 };
    [[AFAppDotNetAPIClient sharedClient]apiGet:USER_INFO Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        if (result_status == ApiStatusSuccess) {
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                NSMutableArray *modes = result_data;
                if (modes.count == 2) {
                    DynamicUserModel* ret = result_data[0];
                    if ([ret.msg isEqualToString:@"Get_List_User_Info"]) {
                        if (block!= nil) {
                            block(result_data[1]);
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
                block(nil);
            }
        }
    }];
}

+(void)getWoisSigned:(WoisSigned)block{
    NSDictionary* parameters = @{
                                 @"i_uid": [TTUserModelTool sharedUserModelTool].logonUser.ttid,
                                 @"i_psd":[TTUserModelTool sharedUserModelTool].password
                                 };
    [[AFAppDotNetAPIClient sharedClient]apiGet:BLOG_SIGN_YES Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        if (result_status == ApiStatusSuccess) {
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                NSMutableArray *modes = result_data;
                if (modes!=nil && modes.count > 0) {
                    NSDictionary* dict = modes[0];
                    if ([[dict objectForKey:@"msg"] isEqualToString:@"Blog_Sign_Yes"]) {
                        if ([[dict objectForKey:@"msg_word"] isEqualToString:@"1"]) {
                            block(@"YES");
                        }else{
                            block(@"NO");
                        }
                    }else{
                        block(@"Error");
                    }
                }else{
                    block(@"Error");
                }
            }else{
                block(@"Error");
            }
        }else{
            block(@"Error");
        }
    }];
}


+(void)BlogSignResult:(WoBlogSign)block{
    NSDictionary* parameters = @{
                                 @"i_uid": [TTUserModelTool sharedUserModelTool].logonUser.ttid,
                                 @"i_psd":[TTUserModelTool sharedUserModelTool].password
                                 };
    [[AFAppDotNetAPIClient sharedClient]apiGet:BLOG_SIGN Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        if (result_status == ApiStatusSuccess) {
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                NSMutableArray *modes = result_data;
                if (modes!=nil && modes.count > 0) {
                    NSDictionary* dict = modes[0];
                    if ([[dict objectForKey:@"msg"] isEqualToString:@"Blog_Sign"]) {
                        block(@"YES", [dict objectForKey:@"baby_jifen"]);
                    }else{
                        block(@"NO", nil);
                    }
                }else{
                    block(@"Error", nil);
                }
            }else{
                block(@"Error", nil);
            }
        }else{
            block(@"Error", nil);
        }
        
    }];
}

+(void)ScorePayLessionWithMouth:(NSString*)mounth UserAccount:(NSString*) account Result:(ScorePayLessio)block{
    NSDictionary* parameters = @{
                                 @"i_uid": [TTUserModelTool sharedUserModelTool].logonUser.ttid,
                                 @"i_psd":[TTUserModelTool sharedUserModelTool].password,
                                 @"i_user":account,
                                 @"i_month":mounth
                                 };
    [[AFAppDotNetAPIClient sharedClient]apiGet:BLOG_JIFEN_CLASS Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        if (result_status == ApiStatusSuccess) {
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                NSMutableArray *modes = result_data;
                if (modes!=nil && modes.count > 0) {
                    NSDictionary* dict = modes[0];
                    if ([[dict objectForKey:@"msg"] isEqualToString:@"Blog_Jifen_Class"]) {
                            block(@"YES");
                        }else{
                            block(@"NO");
                        }
                    }
                }else{
                    block(@"Error");
                }
            }else{
                block(@"Error");
            }
    }];
}
@end
