//
//  BlogUserDynamicModel.m
//  TTzaojiao
//
//  Created by hegf on 15-4-30.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "BlogUserDynamicModel.h"

@implementation BlogUserDynamicModel
+(instancetype)blogUserDynamicModelWithDict:(NSDictionary *)dict{
    if (dict.count == 4) {
        return nil;
    }
    BlogUserDynamicModel* model = [[BlogUserDynamicModel alloc]init];
    if (model) {
        [model setValuesForKeysWithDictionary:dict];
    }
    return model;
}

-(NSArray *)photosURLStr{
    
    NSString* picurlstrs = self.i_pic;
    if (self.i_pic.length != 0) {
        NSArray* picurls = [picurlstrs componentsSeparatedByString:@"|"];
        NSMutableArray* tmparray = [picurls mutableCopy];
        
        [picurls enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isEqualToString:@""]) {
                [tmparray removeObject:obj];
            }
        }];
        _photosURLStr = tmparray;
    }else{
        _photosURLStr = nil;
    }
    
    return _photosURLStr;
}
@end
