//
//  TTCityMngTool.h
//  TTzaojiao
//
//  Created by hegf on 15-4-22.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCityMngTool : NSObject
+(instancetype)sharedCityMngTool;
-(NSString*)citytoCode:(NSString*)cityName;
-(NSString*)codetoCity:(NSString*)cityCode;
@property (strong, nonatomic) NSArray* cityCodeList;
@end
