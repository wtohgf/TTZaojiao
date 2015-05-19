//
//  TTWoTemperatureTestCell.h
//  TTzaojiao
//
//  Created by dalianembeded on 15/5/18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTWoTemperatureTestCell : UITableViewCell
@property (weak, nonatomic)  UILabel *titleLabel;
@property (weak, nonatomic)  UILabel *resultLabel;
@property (weak, nonatomic)  UIView *lineView;

@property (weak, nonatomic)  UILabel *nameTitleLabel;
@property (weak, nonatomic)  UILabel *nameLabel;

@property (weak, nonatomic)  UILabel *pingjiaTitleLabel;
@property (weak, nonatomic)  UILabel *pingjiaLabel;

@property (weak, nonatomic)  UILabel *jianyiTitleLabel;
@property (weak, nonatomic)  UILabel *jianyiLabel;

@property (nonatomic,strong) NSArray *modelArray;

+ (instancetype)WoTemperatureTestCellWithTabelView:(UITableView *)tableView;
@end
