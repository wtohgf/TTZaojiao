//
//  LamaTableViewCell.h
//  TTzaojiao
//
//  Created by dalianembeded on 15/4/24.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LamaModel;

@interface LamaTableViewCell : UITableViewCell
@property (strong, nonatomic)  LamaModel *lamaModel;
@property (weak, nonatomic) UILabel *descLabel;
@property (weak, nonatomic) UILabel *time1Label;
@property (weak, nonatomic) UILabel *time2Label;
@property (weak, nonatomic) UIImageView *imgView;
+ (instancetype)lamaCellWithTabelView:(UITableView*)tableView;

@end
