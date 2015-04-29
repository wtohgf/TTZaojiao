//
//  TTUserDongtaiViewController.h
//  TTzaojiao
//
//  Created by hegf on 15-4-27.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTBaseViewController.h"
#import <MBTwitterScroll.h>
#import <UIImageView+WebCache.h>
#import "DynamicUserModel.h"

@interface TTUserDongtaiViewController : TTBaseViewController<UITableViewDataSource, UITableViewDelegate>
@property (copy, nonatomic) NSString * i_uid;
@end
