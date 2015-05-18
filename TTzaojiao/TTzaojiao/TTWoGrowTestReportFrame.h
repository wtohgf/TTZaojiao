//
//  TTWoGrowTestReportFrame.h
//  TTzaojiao
//
//  Created by dalianembeded on 15/5/18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTWoGrowTestReportModel.h"
#import <UIKit/UIKit.h>
@interface TTWoGrowTestReportFrame : NSObject
@property (nonatomic, strong) TTWoGrowTestReportModel  *model;


//@property (nonatomic, assign) CGRect titleFrame;
@property (nonatomic, assign) CGRect shengaotizhongFrame;
@property (nonatomic, assign) CGRect shengaonianlingFrame;
@property (nonatomic, assign) CGRect tizhongnianlingFrame;
@property (nonatomic,assign) float tigePicHeight;
@property (nonatomic,assign) float nianlingPicHeight;
//@property (nonatomic, assign) CGRect descFrame;
@end
