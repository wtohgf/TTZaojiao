//
//  TTUserModelTool.m
//  TTzaojiao
//
//  Created by hegf on 15-4-18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTUserModelTool.h"
#import "NSString+Extension.h"

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



@end
