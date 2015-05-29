//
//  TTYuyingTableViewCell.h
//  TTzaojiao
//
//  Created by hegf on 15-5-29.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YuyingModel.h"

@interface TTYuyingTableViewCell : UITableViewCell
+(instancetype)yuyingTableViewCellWithTableView:(UITableView*)tableView;
+(CGFloat)cellHeight;
@property (strong, nonatomic) YuyingModel* yuyingModel;

@property (weak, nonatomic) UIImageView* icon;
@property (weak, nonatomic) UILabel* name;
@property (weak, nonatomic) UIButton* price;
@property (weak, nonatomic) UILabel* type;
@property (weak, nonatomic) UILabel* babyCount;
@property (weak, nonatomic) UILabel* expirence;
@property (weak, nonatomic) UILabel* masterrange;
@property (weak, nonatomic) UIButton* distance;
@property (weak, nonatomic) UIView* bottomView;
@end
