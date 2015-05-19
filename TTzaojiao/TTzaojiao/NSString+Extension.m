//
//  NSString+Extension.m
//  Demo
//
//  Created by dalianembeded on 14/12/22.
//  Copyright (c) 2014年 neuedu. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (CGSize)sizeWithMaxSize:(CGSize)maxSize andFont:(UIFont *)font
{
    
    CGRect textRect = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    return textRect.size;

}

+(NSString *) compareCurrentTime:(NSDate*) compareDate
{
    
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    
    timeInterval = -timeInterval;
    
    NSUInteger temp = 0;
    
    NSString *result;
    
    if (timeInterval < 60) {
        
        result = [NSString stringWithFormat:@"刚刚"];
        
    }
    else if((temp = timeInterval/60) <60){
    
        result = [NSString stringWithFormat:@"%ld分前",temp];
        
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小前",temp];
        
    }

    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
        
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
        
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
        
    }
    
    return  result;
}

+(NSString *) getMounthOfDate:(NSDate*) compareDate
{
    
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    
    timeInterval = -timeInterval;
    
    NSUInteger temp = 0;
    
    NSString *result;
    
    if (timeInterval < 60) {
        
        result = [NSString stringWithFormat:@"0"];
        
    }
    else if((temp = timeInterval/60) <60){
        
        result = [NSString stringWithFormat:@"0"];
        
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"0"];
        
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"0"];
        
    }
    
    else if((temp = temp/30) >= 1){
        result = [NSString stringWithFormat:@"%ld",temp];
        
    }

    return  result;
}

+(NSString *)getMounthOfDateString:(NSString *)dateString{
    NSDateFormatter* formater = [[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    
    NSDate* date = [formater dateFromString:dateString];
    NSString* mouth = [self getMounthOfDate:date];
    mouth = [mouth stringByAppendingString:@"个月"];
    return mouth;
}

+(NSComparisonResult)compareDateNow:(NSString *)dateString{
    NSDateFormatter* formater = [[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
     NSDate* date = [formater dateFromString:dateString];
    if (date == nil) {
        [formater setDateFormat:@"yyyy-MM-dd"];
        date = [formater dateFromString:dateString];
    }
    return [date compare:[NSDate date]];
}

+(NSString *)getChnYMDWithString:(NSString *)dateString{
    NSArray* dateComps = [dateString componentsSeparatedByString:@" "];
    
    NSString* dateStrOldType = [dateComps firstObject];
    NSArray* ymdArray = [dateStrOldType componentsSeparatedByString:@"-"];
    
    NSString* dateChnString = [NSString stringWithFormat:@"%@年%@月%@日", ymdArray[0], ymdArray[1], ymdArray[2]];
    return dateChnString;
}

-(CGRect)boundByFont:(UIFont *)font andWidth:(CGFloat)width{
    CGSize rect = {width, MAXFLOAT};
    NSDictionary* attr = @{NSFontAttributeName:font};
    CGRect bound = [self boundingRectWithSize:rect options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    return bound;
}



@end
