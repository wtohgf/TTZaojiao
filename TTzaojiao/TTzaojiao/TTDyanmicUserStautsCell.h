//
//  TTDyanmicUserStautsCell.h
//  TTzaojiao
//
//  Created by hegf on 15-4-27.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBlogFrame.h"
#import "TTDynamicUserStatusTopView.h"
#import "TTDaynamicUserStatusZancountView.h"

@interface TTDyanmicUserStautsCell : UITableViewCell

@property (weak, nonatomic) TTDynamicUserStatusTopView* topView;
@property (weak, nonatomic) TTDaynamicUserStatusZancountView* zanCountView;

@property (strong, nonatomic) TTBlogFrame* blogFrame;

+(instancetype)dyanmicUserStautsCellWithTableView:(UITableView *)tableView;
@end
