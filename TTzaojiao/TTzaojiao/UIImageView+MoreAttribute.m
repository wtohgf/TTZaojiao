//
//  UIImageView+MoreAttribute.m
//  TTzaojiao
//
//  Created by hegf on 15-4-27.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "UIImageView+MoreAttribute.h"
#import "TTWebServerAPI.h"
#import <UIImageView+AFNetworking.h>

@implementation UIImageView (MoreAttribute)
-(void)setImageIcon:(NSString *)icon{
    NSString* str = [NSString stringWithFormat:@"%@%@", TTBASE_URL, icon];
    [self setImageWithURL:[NSURL URLWithString:str]];
}
@end
