//
//  JSONHelper.h
//  Houses
//
//  Created by Liang Zhang on 14/12/15.
//  Copyright (c) 2014年 bangbangtianxia. All rights reserved.
//

#import <Foundation/Foundation.h>
//Model Header File
//#import "xxxxxModel.h"
#import "UserModel.h"
#import "RegMsgFirst.h"
#import "RegMsgSecond.h"

//Api Name
typedef enum : NSUInteger {
    ApiEnumNone,
//    ApiEnumxxxxxx,
    ApiEnumGet_Login,
    ApiEnumGet_Reg_1,
    ApiEnumGet_Reg_2,
    ApiEnumGet_List_Active //辣妈街刷列表
} ApiEnum;

@interface JSONHelper : NSObject

+(id)jsonToModel:(id)modelObj Api:(ApiEnum)apienum Idx:(NSInteger)idx ImageURL:(NSString *)url;

@end
