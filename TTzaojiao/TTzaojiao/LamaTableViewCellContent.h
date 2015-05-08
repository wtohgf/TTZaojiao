//
//  LamaTableViewCellContent.h
//  TTzaojiao
//
//  Created by dalianembeded on 15/5/6.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LamaTableViewCellModelFrame;
@interface LamaTableViewCellContent : UITableViewCell
+ (instancetype)LamaTableViewCellContentWithTabelView:(UITableView *)tableView;




@property (nonatomic,weak) UILabel *contentLabel;

@property (nonatomic,strong) LamaTableViewCellModelFrame *modelFrame;
@end
