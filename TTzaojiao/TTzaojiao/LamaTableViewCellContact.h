//
//  LamaTableViewCellContact.h
//  TTzaojiao
//
//  Created by dalianembeded on 15/5/6.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LamaTableViewCellModelFrame;
@interface LamaTableViewCellContact : UITableViewCell<UIAlertViewDelegate>
+ (instancetype)LamaTableViewCellContactWithTabelView:(UITableView *)tableView;
@property (nonatomic,weak) UILabel *companyLabel;
@property (nonatomic,weak) UILabel *addresssLabel;
@property (nonatomic,weak) UILabel *telLabel;
@property (nonatomic,weak) UIButton *telButton;

@property (nonatomic,strong) LamaTableViewCellModelFrame *modelFrame;
@end
