//
//  BlogModel.m
//  TTzaojiao
//
//  Created by hegf on 15-4-24.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "BlogModel.h"

@implementation BlogModel
+(instancetype)blogModeWithDict:(NSDictionary *)dict{
    BlogModel* blog = [[BlogModel alloc]init];
    if ([dict objectForKey:@"id"] == nil) {
        return nil;
    }
    [blog setValuesForKeysWithDictionary:dict];
    return blog;
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
