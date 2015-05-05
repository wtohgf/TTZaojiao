//
//  LaMaDetailModel.h
//  TTzaojiao
//
//  Created by dalianembeded on 15/4/28.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LaMaDetailModel : NSObject
typedef enum : NSUInteger {
    CellEnumNameAndPic,
    //    ApiEnumxxxxxx,
    CellEnumPicListAndContent
    
} CellType;
@property (nonatomic, assign) CellType cellType;
@property (nonatomic, copy) NSString * i_name;
@property (nonatomic, copy) NSString * i_otime_end;
@property (nonatomic, copy) NSString * i_tel;
@property (nonatomic, copy) NSString * i_addresss;
@property (nonatomic, copy) NSString * i_pic;
@property (nonatomic, copy) NSString * msg;
@property (nonatomic, copy) NSString * i_content;
@property (nonatomic, copy) NSString * i_pic_list;
@property (nonatomic, copy) NSString * i_company;

+(instancetype)LaMaDetailModelWithDict:(NSDictionary *)dict;
@end
