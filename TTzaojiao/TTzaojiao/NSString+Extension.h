//
//  NSString+Extension.h
//  Demo
//
//  Created by dalianembeded on 14/12/22.
//  Copyright (c) 2014年 neuedu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Extension)
-(CGSize)sizeWithMaxSize:(CGSize)maxSize andFont:(UIFont*)font;

+(NSString *) compareCurrentTime:(NSDate*) compareDate;
+(NSString *) getMounthOfDate:(NSDate*) compareDate;
//yyyy－MM-HH
+(NSString *) getMounthOfDateString:(NSString*) dateString;
+(NSComparisonResult)compareDateNow:(NSString *)dateString;
+(NSString *) getChnYMDWithString:(NSString*) dateString;
-(CGRect)boundByFont:(UIFont*)font andWidth:(CGFloat)width;

@end
