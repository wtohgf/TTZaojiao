//
//  LamaTableViewCellLabel.h
//  TTzaojiao
//
//  Created by dalianembeded on 15/5/6.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LamaTableViewCellModelFrame;
@interface LamaTableViewCellLabel : UITableViewCell
+ (instancetype)LamaTableViewCellContactWithTabelView:(UITableView *)tableView ;
@property (nonatomic,weak) UILabel *label;

@property (nonatomic,strong) LamaTableViewCellModelFrame *modelFrame;
@end
