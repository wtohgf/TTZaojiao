//
//  UIImage+MoreAttribute.m
//  TTzaojiao
//
//  Created by hegf on 15-4-20.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "UIImage+MoreAttribute.h"

@implementation UIImage (MoreAttribute)

- (UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    
    return scaledImage;
}

@end
