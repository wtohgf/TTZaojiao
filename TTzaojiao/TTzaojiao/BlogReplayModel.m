//
//  BlogReplayModel.m
//  TTzaojiao
//
//  Created by hegf on 15-4-25.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "BlogReplayModel.h"

@implementation BlogReplayModel
+(instancetype)blogReplayModelWithDict:(NSDictionary *)dict{
    if (dict.count == 4) {
        return nil;
    }
    BlogReplayModel* model = [[BlogReplayModel alloc]init];
    if (model) {
        [model setValuesForKeysWithDictionary:dict];
    }
    return model;
}
@end
