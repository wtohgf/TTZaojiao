//
//  UIImageView+MoreAttribute.m
//  TTzaojiao
//
//  Created by hegf on 15-4-27.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "UIImageView+MoreAttribute.h"
#import "TTWebServerAPI.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (MoreAttribute)
-(void)setImageIcon:(NSString *)icon{
    NSString* str = [NSString stringWithFormat:@"%@%@", TTBASE_URL, icon];
    [self sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"default_pic.png"]];
}
@end
