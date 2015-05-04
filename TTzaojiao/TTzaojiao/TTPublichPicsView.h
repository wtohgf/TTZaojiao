//
//  TTPublichPicsView.h
//  TTzaojiao
//
//  Created by hegf on 15-5-4.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kPicWRatio 0.2
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kBoder 8
#define kMargin 2

@interface TTPublichPicsView : UIView
@property (strong, nonatomic) NSMutableArray* pics;
-(void)addPic:(NSString*)picName;
@end
