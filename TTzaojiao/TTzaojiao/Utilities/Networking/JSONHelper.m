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
        case ApiEnumGet_Login:
        {
            modelObj = [UserModel userModelWithDict:(NSDictionary *)modelObj];
        }
            break;
        case ApiEnumGet_Reg_1:
        {
            modelObj = [RegMsgFirst msgFirstWithDict:(NSDictionary *)modelObj];
        }
            break;
        case ApiEnumGet_Reg_2:
        {
            modelObj = [RegMsgSecond msgSecondWithDict:(NSDictionary *)modelObj];
        }
            break;
        case ApiEnumGet_List_Blog_Group:
        {
            id tmpModel = [BlogModel blogModeWithDict:(NSDictionary *)modelObj];
            if (tmpModel != nil) {
                modelObj = tmpModel;
            }
        }
            break;
        case ApiEnumGet_List_Active:
        {
            id tmpModel = [LamaModel LamaModelWithDict:(NSDictionary *)modelObj];
            if (tmpModel != nil) {
                modelObj = tmpModel;
            }
        }
            break;
        case ApiEnumGet_List_Blog_Replay:
        {
            id tmpModel = [BlogReplayModel blogReplayModelWithDict:(NSDictionary *)modelObj];
            if (tmpModel != nil) {
                modelObj = tmpModel;
            }
        }
            break;
        case ApiEnumGet_List_User_Info:
        {
            id tmpModel = [DynamicUserModel dynamicUserModelWithDict:(NSDictionary *)modelObj];
            if (tmpModel != nil) {
                modelObj = tmpModel;
                
            }
        }
            break;
        case ApiEnumGet_List_User_Blog:
        {
            id tmpModel = [BlogUserDynamicModel blogUserDynamicModelWithDict:(NSDictionary *)modelObj];
            if (tmpModel != nil) {
                modelObj = tmpModel;
            }
        }
            break;
        case ApiEnumGet_VIP_PRICE:{
            id tmpModel = [WoVipModel woVipModelWithDict:(NSDictionary *)modelObj];
            if (tmpModel != nil) {
                modelObj = tmpModel;
            }

        }
            break;
        case ApiEnumGet_PAY_BY_CARD:{
            modelObj = modelObj;
        }
            break;
        case ApiEnumGet_Test_User_List_Distance:{
            id tmpModel = [NearByBabyModel nearByBabyWithDict:(NSDictionary *)modelObj];
            if (tmpModel != nil) {
                modelObj = tmpModel;
            }
        }
            break;
        case ApiEnumGet_Me_Class_Info:{
            id tmpModel = [LessionModel lessionModelWithDict:(NSDictionary *)modelObj];
            if (tmpModel != nil) {
                modelObj = tmpModel;
            }
        }
            break;
        case ApiEnumGet_Me_ClassPart_Info:{
            id tmpModel = [DetailLessionModel detailLessionModelWithDict:(NSDictionary *)modelObj];
            if (tmpModel != nil) {
                modelObj = tmpModel;
            }
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
