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

@interface TTDongTaiViewController : TTBaseViewController<UITableViewDelegate, UITableViewDataSource, TTDynamicCommentsViewDelegate, TTDynamicUserStatusTopViewDelegate>

@end
