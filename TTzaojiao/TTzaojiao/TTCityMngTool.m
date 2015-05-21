//
//  TTCityMngTool.m
//  TTzaojiao
//
//  Created by hegf on 15-4-22.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTCityMngTool.h"
#import "AFAppDotNetAPIClient.h"
#import "FileManagerHelper.h"
#import "Constants.h"

#define kCityCodeListFile @"cityCodeList.data"

static TTCityMngTool* tool;

@implementation TTCityMngTool

+(instancetype)sharedCityMngTool{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        tool = [[TTCityMngTool alloc]init];
    });
    return tool;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        tool = [super allocWithZone:zone];
    });
    return tool;
}

-(NSArray *)cityCodeList{
    NSString* filepath = [NSString stringWithFormat:@"%@/%@",pathDocuments,kCityCodeListFile];
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filepath]) {
        NSArray* codeList = [NSArray arrayWithContentsOfFile:filepath];
        if (codeList !=nil && codeList.count>1) {
            _cityCodeList =  codeList;
        }else{
            [manager removeItemAtPath:filepath error:nil];
        }
    }else{
        NSDictionary* parameters = @{
                                     @"p_1": @"1",
                                     @"p_2": @"99999"
                                     };
        [[AFAppDotNetAPIClient sharedClient]apiGet:LOCATION_INFO Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                NSMutableArray* array = (NSMutableArray*)result_data;
                if (array != nil && array.count!=0) {
                    NSLog(@"%@ %ld",array, array.count);
                    [array writeToFile:filepath atomically:YES];
                }
                _cityCodeList = array;
            }
            
        }];
    }
    return _cityCodeList;
}

-(NSString *)citytoCode:(NSString *)cityName{
    NSArray* cityList = self.cityCodeList;
    __block NSString* cityCode = @"";
    if (cityList.count!=0) {
        [cityList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary* dict = (NSDictionary*)obj;
                if ([[dict objectForKey:@"CityName"]isEqualToString:cityName]) {
                    cityCode = [dict objectForKey:@"CityPostCode"];
                    *stop = YES;
                }
            }
        }];
    }
    return cityCode;
}

-(NSString *)codetoCity:(NSString *)cityCode{
    NSArray* cityList = self.cityCodeList;
    __block NSString* cityName = @"";
    if (cityList.count!=0) {
        [cityList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary* dict = (NSDictionary*)obj;
                if ([[dict objectForKey:@"CityPostCode"]isEqualToString:cityCode]) {
                    cityName = [dict objectForKey:@"CityName"];
                    *stop = YES;
                }
            }
        }];
    }
    cityName = [cityName stringByReplacingOccurrencesOfString:@"市" withString:@""];
    return cityName;
}

-(NSString *)provinceofCity:(NSString *)cityName{
    NSString* path = [[NSBundle mainBundle]pathForResource:@"ProvincesAndCities.plist" ofType:nil];
    NSArray* rootList = [NSArray arrayWithContentsOfFile:path];
    __block NSString* retpro = nil;
    [rootList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary* dict = (NSDictionary*)obj;
        __block NSString* province = dict[@"State"];
        NSArray* citys = dict[@"Cities"];
        [citys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary* city = (NSDictionary*)obj;
            if ([city[@"city"] isEqualToString:cityName]) {
                *stop = YES;
                retpro = province;
            }
        }];
    }];
    return retpro;
}

//开始定位
-(void)startLocation:(actionLocationBlock)locationBlock{
    
//    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
//    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) {
//        
////        [[UIAlertView alloc]showWithTitle:@"定位失败" message:@"请您在设置中打开定位服务" cancelButtonTitle:@"知道了"];
////        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
////        
////        if ([[UIApplication sharedApplication] canOpenURL:url]) {
////            //如果点击打开的话，需要记录当前的状态，从设置回到应用的时候会用到
////            [[UIApplication sharedApplication] openURL:url];
////        }
//        if (locationBlock) {
//            locationBlock(nil, nil);
//        }
//        return;
//    }
    
    _locationBlock = locationBlock;
    if ([CLLocationManager locationServicesEnabled])
    {
        
        if (!self.locationManager)
        {
            self.locationManager = [[CLLocationManager alloc] init];
        }
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter=1.0;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [self.locationManager requestAlwaysAuthorization]; // 永久授权
            [self.locationManager requestWhenInUseAuthorization]; //使用中授权
        }
        
        [self.locationManager startUpdatingLocation];//开启位置更新
    }else{
        if (locationBlock) {
            locationBlock(nil, @"定位服务未开启 请到设置中设定");
        }
    }
}

//定位代理经纬度回调
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    [_locationManager stopUpdatingLocation];
    
    CLLocation *newLocation = [locations lastObject];
    NSString* lat = @"0";
    NSString* lon = @"0";
    if (newLocation != nil) {
        lat = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
        lon = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    }
    
    NSDictionary* parameters = @{
                                 @"i_x": lat,
                                 @"i_y": lon,
                                 @"i_uid": [TTUserModelTool sharedUserModelTool].logonUser.ttid,
                                 @"i_psd": [TTUserModelTool sharedUserModelTool].password
                                 };
    [[AFAppDotNetAPIClient sharedClient]apiGet:UPDATE_LOCATION Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        if (result_status == ApiStatusSuccess) {
            _locationBlock(newLocation, nil);
        }else{
            _locationBlock(nil, @"定位失败");
        };
        
    }];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    [_locationManager stopUpdatingLocation];
  
    _locationBlock(nil, @"定位错误");
}

//经纬度转cityCode
- (void) getReverseGeocode:(CLLocation *)location Result:(actionCityCodeBlock)block
{
    
    // 保存 Device 的现语言 (英语 法语 ，，，)
    NSMutableArray
    *userDefaultLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    
    // 强制 成 简体中文
    [[NSUserDefaults
      standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans", nil] forKey:@"AppleLanguages"];
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error!= nil) {
            block(nil, error);
            return;
        }
        for (CLPlacemark * placemark in placemarks) {
            
            NSDictionary *test = [placemark addressDictionary];
            
            //  Country(国家)  State(城市)  SubLocality(区)
            NSString* cityCode = [[TTCityMngTool sharedCityMngTool]citytoCode:[test objectForKey:@"City"]];
            _cityCode = cityCode;
            if (cityCode!= nil) {
                block(cityCode, nil);
                break;
            }
        }
        if (_cityCode == nil) {
            block(nil, error);
        }
        
        // 还原Device 的语言
        [[NSUserDefaults
          standardUserDefaults] setObject:userDefaultLanguages
         forKey:@"AppleLanguages"];
    }];
    
    
}

@end
