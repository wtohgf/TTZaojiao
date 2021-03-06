//
//  TTWoGrowTestReportTigeCellTableViewCell.h
//  TTzaojiao
//
//  Created by dalianembeded on 15/5/18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTWoGrowTestReportFrame.h"
@interface TTWoGrowTestReportTigeCellTableViewCell : UITableViewCell
@property (weak, nonatomic)  UILabel *titleLabel;
@property (weak, nonatomic)  UIView *picView;
@property (weak, nonatomic)  UILabel *descLabel;
@property (nonatomic,strong) TTWoGrowTestReportFrame * modelFrame;
+ (instancetype)WoGrowTestReportTigeCellWithTabelView:(UITableView *)tableView;
@end
