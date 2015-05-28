//
//  TTCommentListViewController.h
//  TTzaojiao
//
//  Created by hegf on 15-4-29.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTBaseViewController.h"
#import <MJRefresh.h>
#import "TTCommentListCell.h"
#import <RDVTabBarController.h>
#import "TTCommentRelaseView.h"
#import "TTCityMngTool.h"

@interface TTCommentListViewController : TTBaseViewController<UITableViewDataSource, UITableViewDelegate, TTCommentRelaseViewDelegate,UIAlertViewDelegate>
@property (copy, nonatomic) NSString* blog_id;
@end
