//
//  TTNearBybabyInfoView.h
//  TTzaojiao
//
//  Created by hegf on 15-5-8.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearByBabyModel.h"
#import "UIImageView+MoreAttribute.h"
#import "UIView+NKMoreAttribute.h"
#import "TTUserModelTool.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define TTHeaderWithRatio 44.f/320.f
#define TTBlogTableBorder 8
#define TTBlogMaintitleFont [UIFont systemFontOfSize:16.f]
#define TTBlogSubtitleFont [UIFont systemFontOfSize:14.f]
#define TTBlogBackgroundColor [UIColor colorWithRed:244.f/255.f green:247.f/255.f blue:244.f/255.f alpha:1.f]
#define TTCellWidth [UIScreen mainScreen].bounds.size.width - 2*TTBlogTableBorder

#define TTPhotoW ((TTCellWidth-TTHeaderWithRatio*TTCellWidth - 2*TTBlogTableBorder)-2*TTPhotoMargin)*1/3
#define TTPhotoH TTPhotoW
#define TTPhotoMargin 2.f

@interface TTNearBybabyInfoView : UIView
//头像
@property (weak, nonatomic) UIImageView* iconView;
//昵称
@property (weak, nonatomic) UILabel* name;
//性别
@property (weak, nonatomic) UIImageView* gender;
//月龄
@property (weak, nonatomic) UILabel* age;
//vip
@property (weak, nonatomic) UIView* vip;
//距离
@property (weak, nonatomic) UILabel* distance;

@property (strong, nonatomic) NearByBabyModel* nearByBaby;

@end
