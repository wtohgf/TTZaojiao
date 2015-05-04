//
//  NSString+MoreAttribute.m
//  TTzaojiao
//
//  Created by hegf on 15-5-4.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "NSString+MoreAttribute.h"
#import "TTWebServerAPI.h"

@implementation NSString (MoreAttribute)
+(instancetype)appendBaseURL:(NSString*)str{
    NSString* string = [NSString stringWithFormat:@"%@%@",TTBASE_URL, str];
    return string;
}
@end
