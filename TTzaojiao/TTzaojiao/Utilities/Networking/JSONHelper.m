//
//  JSONHelper.m
//  Houses
//
//  Created by Liang Zhang on 14/12/15.
//  Copyright (c) 2014年 bangbangtianxia. All rights reserved.
//

#import "JSONHelper.h"
#import "NetworkHelper.h"
#import "UserModel.h"

@implementation JSONHelper

+(id)jsonToModel:(id)modelObj Api:(ApiEnum)apienum Idx:(NSInteger)idx ImageURL:(NSString *)url {
    
    switch (apienum) {
        case ApiEnumNone:
        {
            modelObj = [UserModel userModelWithDict:(NSDictionary *)modelObj];
        }
            break;

        default:
        {
            
        }
            break;
    }
    return modelObj;
}

@end
