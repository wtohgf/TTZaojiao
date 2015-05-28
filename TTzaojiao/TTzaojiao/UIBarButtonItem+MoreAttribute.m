//
//  UIBarButtonItem+MoreAttribute.m
//  TTzaojiao
//
//  Created by hegf on 15-5-4.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "UIBarButtonItem+MoreAttribute.h"
#import "UIImage+MoreAttribute.h"

@implementation UIBarButtonItem (MoreAttribute)
+(instancetype)barButtonItemWithImage:(NSString *)image target:(id)target action:(SEL)action{
    UIButton* btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 65, 30);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
   return [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}

@end
