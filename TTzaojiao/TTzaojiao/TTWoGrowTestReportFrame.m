//
//  TTWoGrowTestReportFrame.m
//  TTzaojiao
//
//  Created by dalianembeded on 15/5/18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoGrowTestReportFrame.h"
#import "NSString+Extension.h"
#define ktizhongShengaoAll (15.0+30+489+15.0)
#define ktizhongShengaoLeftRatio 30/ktizhongShengaoAll
#define ktizhongShengaoPicRatio 489/ktizhongShengaoAll
#define ktizhongShengaoPaddingRatio 15/ktizhongShengaoAll

#define knianlingShengaoAll (15.0+30+503+15.0)
#define knianlingShengaoLeftRatio 30/(15.0+30+503+15.0)
#define knianlingShengaoPicRatio 503/(15.0+30+503+15.0)
#define knianlingShengaoPaddingRatio 15/(15.0+30+503+15.0)

@implementation TTWoGrowTestReportFrame
- (void)setModel:(TTWoGrowTestReportModel *)model
{
    _model = model;
    //左边图 算图片高度
    
    UIImageView *tempView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tizhong_v.png"]];
    CGFloat leftW = CGImageGetWidth(tempView1.image.CGImage);
    CGFloat leftH = CGImageGetHeight(tempView1.image.CGImage);
   
    CGFloat  leftWidth1 = [UIScreen mainScreen].bounds.size.width*ktizhongShengaoLeftRatio;
    CGFloat leftHeight1 = (CGFloat)((leftWidth1 * leftH)/leftW) ;
    _tigePicHeight = leftHeight1;
    
    CGFloat  leftWidth2 = [UIScreen mainScreen].bounds.size.width*knianlingShengaoLeftRatio;
    CGFloat leftHeight2 = (CGFloat)((leftWidth2 * leftH)/leftW) ;
    _nianlingPicHeight = leftHeight2;
    
    _shengaotizhongFrame = [model.tige_sort_content boundByFont:[UIFont systemFontOfSize:14.f] andWidth:[UIScreen mainScreen].bounds.size.width - 16.f];
    _shengaonianlingFrame  = [model.tige_shengao_content boundByFont:[UIFont systemFontOfSize:14.f] andWidth:[UIScreen mainScreen].bounds.size.width - 16.f];
    
    _tizhongnianlingFrame =[model.tige_tizhong_content boundByFont:[UIFont systemFontOfSize:14.f] andWidth:[UIScreen mainScreen].bounds.size.width - 16.f];
    
}


@end
