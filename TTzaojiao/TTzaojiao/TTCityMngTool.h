//
//  TTCityMngTool.h
//  TTzaojiao
//
//  Created by hegf on 15-4-22.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "TTUserModelTool.h"
#import "MBProgressHUD+TTHud.h"
#import "UIAlertView+MoreAttribute.h"

typedef void(^actionLocationBlock)(CLLocation* location, NSError* error);
typedef void(^actionCityCodeBlock)(NSString* cityCode, NSError* error);

@interface TTCityMngTool : NSObject<CLLocationManagerDelegate>
+(instancetype)sharedCityMngTool;
-(NSString*)citytoCode:(NSString*)cityName;
-(NSString*)codetoCity:(NSString*)cityCode;
-(NSString*)provinceofCity:(NSString*)cityName;

@property (strong, nonatomic) CLLocationManager* locationManager;
-(void)startLocation:(actionLocationBlock)locationBlock;
//经纬度转cityCode
- (void) getReverseGeocode:(CLLocation *)location Result:(actionCityCodeBlock)block;
@property (strong, nonatomic) NSArray* cityCodeList;
@property (strong, nonatomic) actionLocationBlock locationBlock ;
@property (copy, nonatomic) NSString* cityCode; //110000
@end
