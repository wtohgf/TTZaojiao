//
//  TTZaojiaoHeaderRightItem.h
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
#import "TTGenderAgeView.h"
#import "TTVipView.h"
#import "TTVipPayView.h"
#import "NSString+Extension.h"

@interface TTZaojiaoHeaderRightItem : UIView
@property (weak, nonatomic) TTGenderAgeView* genderAge;
@property (weak, nonatomic) TTVipView* vip;
@property (weak, nonatomic) TTVipPayView* vipPay;

@property (strong, nonatomic) UserModel* logonUser;

+(instancetype)zaojiaoHeaderRightItemWithTarget:(id)target Action:(SEL)aciton;
@end
