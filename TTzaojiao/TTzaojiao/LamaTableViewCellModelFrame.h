//
//  LamaTableViewCellModelFrame.h
//  TTzaojiao
//
//  Created by dalianembeded on 15/4/30.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LaMaDetailModel.h"
@interface LamaTableViewCellModelFrame : NSObject




@property (nonatomic, assign) CGFloat NameAndPicCellHeight;//公司名字和单图
@property (nonatomic, strong) NSArray* PicListCellHeightArray;//公司图片
//@property (nonatomic, assign) CGFloat ContentCellHeight;//公司简介
//@property (nonatomic, assign) CGFloat ContactCellHeight;//公司联系方式

@property (nonatomic, strong) LaMaDetailModel  *model;
@property (nonatomic, strong) NSArray  *picListArray;

@property (nonatomic, assign) CGRect i_picFrame;
@property (nonatomic, assign) CGRect i_nameFrame;
@property (nonatomic, assign) CGRect i_PicListFrame;
//@property (nonatomic, copy) NSString * i_tel;
//@property (nonatomic, copy) NSString * i_addresss;
//@property (nonatomic, copy) NSString * i_company;

//@property (nonatomic, assign) CGRect  msgFrame;
@property (nonatomic, assign) CGRect  i_contentFrame;
//@property (nonatomic, assign) CGRect  i_pic_listFrame;



@end
