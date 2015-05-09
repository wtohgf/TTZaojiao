//
//  TTZaojiaoHeaderLeftItem.h
//  TTzaojiao
//
//  Created by hegf on 15-5-9.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+NKMoreAttribute.h"
#import "TTBlogFrame.h"
#import "UserModel.h"
#import "UIImageView+MoreAttribute.h"

@interface TTZaojiaoHeaderLeftItem : UIView
//头像
@property (weak, nonatomic) UIImageView* iconView;
//名字
@property (weak, nonatomic) UILabel* name;
//生日
@property (weak, nonatomic) UILabel* birthDay;

@property (strong, nonatomic) UserModel* logonUser;
@end
