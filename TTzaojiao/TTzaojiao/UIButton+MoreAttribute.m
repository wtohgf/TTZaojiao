//
//  UIButton+MoreAttribute.m
//  TTzaojiao
//
//  Created by hegf on 15-4-30.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "UIButton+MoreAttribute.h"

@implementation UIButton (MoreAttribute)
+(instancetype)buttonWithTitleForCell:(NSString*)title target:(id)target action:(SEL)action{
    UIButton* showAllBtn = [[UIButton alloc]init];
    
    [showAllBtn setTitle:title forState:UIControlStateNormal];
    [showAllBtn setTitleColor:[UIColor colorWithRed:51.f/255.f green:144.f/255.f blue:207.f/255.f alpha:1.f] forState:UIControlStateNormal];
    [showAllBtn setTitleColor:[UIColor colorWithRed:245.f/255.f green:245.f/255.f blue:245.f/255.f alpha:1.f] forState:UIControlStateHighlighted];
    [showAllBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return showAllBtn;
}
@end
