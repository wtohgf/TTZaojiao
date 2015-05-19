//
//  TTDongTaiViewController.h
//  TTzaojiao
//
//  Created by Liang Zhang on 15/4/21.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBaseViewController.h"
#import <MJRefresh.h>
#import "TTDynamicCommentsView.h"
#import "TTDynamicUserStatusTopView.h"
#import "TTDynamicSidebarViewController.h"
#import "TTDaynamicUserStatusZancountView.h"
#import "TTDyanmicUserStautsCell.h"
#import "TTNearBybabyTableViewCell.h"
#import "LessionModel.h"
#import "TTDynamicReleaseViewController.h"


@interface TTDongTaiViewController : TTBaseViewController<UITableViewDelegate, UITableViewDataSource, TTDyanmicUserStautsCellDelegate, TTDynamicSidebarViewControllerDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) CLLocation* location;

@property (strong, nonatomic) LessionModel * lession;//上课ID

@end
