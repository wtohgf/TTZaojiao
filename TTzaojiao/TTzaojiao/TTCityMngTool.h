//
//  TTCityMngTool.h
//  TTzaojiao
//
//  Created by hegf on 15-4-22.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^actionLocationBlock)(CLLocation* location, NSError* error);

@interface TTCityMngTool : NSObject<CLLocationManagerDelegate>
+(instancetype)sharedCityMngTool;
-(NSString*)citytoCode:(NSString*)cityName;
-(NSString*)codetoCity:(NSString*)cityCode;
-(NSString*)provinceofCity:(NSString*)cityName;

@property (strong, nonatomic) CLLocationManager* locationManager;
-(void)startLocation:(actionLocationBlock)locationBlock;

@property (strong, nonatomic) NSArray* cityCodeList;
@property (strong, nonatomic) actionLocationBlock locationBlock ;

@end
