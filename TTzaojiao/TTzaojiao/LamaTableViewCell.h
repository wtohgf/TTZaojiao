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
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *time1Label;
@property (weak, nonatomic) IBOutlet UILabel *time2Label;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
+ (instancetype)lamaCellWithTabelView:(UITableView*)tableView;

@end
