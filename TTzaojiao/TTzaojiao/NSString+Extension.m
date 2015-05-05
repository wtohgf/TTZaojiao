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
@end
