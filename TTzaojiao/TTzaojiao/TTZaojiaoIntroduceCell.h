//
//  TTZaojiaoIntroduceCell.h
//  TTzaojiao
//
//  Created by hegf on 15-5-9.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "NSString+Extension.h"
#import "TTBlogFrame.h"

#define INTRODUCETEXT @"  天天的宝宝家长，您好！宝宝生日是：%@， 目前月龄为%@，我们为您安排的早教课程如下，请您认真学习并与宝宝互动，随着宝宝的成长，早教课程会阶梯式提供给您，请您合理安排好上课时间！"

@interface TTZaojiaoIntroduceCell : UITableViewCell
@property (strong, nonatomic) UserModel* logonUser;
@property (weak, nonatomic) UILabel* introduceText;

+(instancetype)zaojiaoIntroduceCellWithTableView:(UITableView*)tableView;
+(CGFloat)cellHeightWithModel:(UserModel*)logonUser;
@end
