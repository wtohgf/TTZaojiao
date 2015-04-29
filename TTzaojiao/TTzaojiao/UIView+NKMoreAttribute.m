//
//  UIView+NKMoreAttribute.m
//  NKKugouIOS-1
//
//  Created by hegf on 14-12-29.
//  Copyright (c) 2014年 hegf. All rights reserved.
//

#import "UIView+NKMoreAttribute.h"

@implementation UIView (NKMoreAttribute)

-(CGFloat)width{
    return self.frame.size.width;
}

-(void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(CGFloat)left{
    return self.frame.origin.x;
}

-(void)setLeft:(CGFloat)left{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

-(CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}

-(void)setRight:(CGFloat)right{
    CGRect frame = self.frame;
    frame.origin.x = right-frame.size.width;
    self.frame = frame;
}

-(CGFloat)up{
    return self.frame.origin.y;
}

-(void)setUp:(CGFloat)up{
    CGRect frame = self.frame;
    frame.origin.y = up;
    self.frame = frame;
}

- (CGFloat)bottom{
    return self.frame.origin.y +self.frame.size.height;
}

-(void)setBottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    frame.origin.y = bottom-self.frame.size.height;
    self.frame = frame;
}

@end
