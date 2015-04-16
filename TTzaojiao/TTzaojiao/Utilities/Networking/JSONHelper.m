//
//  JSONHelper.m
//  Houses
//
//  Created by Liang Zhang on 14/12/15.
//  Copyright (c) 2014年 bangbangtianxia. All rights reserved.
//

#import "JSONHelper.h"
#import "NetworkHelper.h"

@implementation JSONHelper

+(id)jsonToModel:(id)modelObj Api:(ApiEnum)apienum Idx:(NSInteger)idx ImageURL:(NSString *)url {
    
    switch (apienum) {
//        case ApiEnumNone:
//        {
//            NSDictionary *dic = (NSDictionary *)modelObj;
//            xxxxModel *model = [[xxxxModel alloc] init];
//            model.address = [NetworkHelper makeModelValueWithKey:@"xxxx" Model:dic Null:@""];
//            return model;
//        }
//            break;

        default:
        {
            return nil;
        }
            break;
    }
}

@end
