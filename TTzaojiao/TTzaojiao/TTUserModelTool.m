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
                if (result_status != ApiStatusNetworkNotReachable) {
                    [[[UIAlertView alloc]init] showWithTitle:@"友情提示" message:@"服务器好像罢工了" cancelButtonTitle:@"重试一下"];
                }
                block(nil);
            }
        }
    }];
}

@end
