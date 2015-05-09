//
//  TTGenderAgeView.h
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
#import "NSString+Extension.h"

@interface TTGenderAgeView : UIView
@property (weak, nonatomic) UIImageView* gender;
@property (weak, nonatomic) UILabel* age;
@property (strong, nonatomic) UserModel* logonUser;
@end
