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
#import "BlogModel.h"
#import "LamaModel.h"
#import "BlogReplayModel.h"
#import "DynamicUserModel.h"
#import "BlogUserDynamicModel.h"
#import "WoVipModel.h"
#import "NearByBabyModel.h"
#import "LessionModel.h"

//Api Name
typedef enum : NSUInteger {
    ApiEnumNone,
//    ApiEnumxxxxxx,
    ApiEnumGet_Login,
    ApiEnumGet_Reg_1,
    ApiEnumGet_Reg_2,
    ApiEnumGet_List_Active, //辣妈街刷列表
    ApiEnumGet_List_Blog_Group, //动态
    ApiEnumGet_List_Blog_Replay,  //一条blog的评论列表
    ApiEnumGet_List_User_Info,
    ApiEnumGet_List_User_Blog,
    ApiEnumGet_VIP_PRICE,
    ApiEnumGet_PAY_BY_CARD,
    ApiEnumGet_Test_User_List_Distance,
    ApiEnumGet_Me_Class_Info,
} ApiEnum;

@interface JSONHelper : NSObject

+(id)jsonToModel:(id)modelObj Api:(ApiEnum)apienum Idx:(NSInteger)idx ImageURL:(NSString *)url;

@end
