//
//  TTWoChengzhangHistoryCell.h
//  TTzaojiao
//
//  Created by hegf on 15-5-16.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTWoChengzhangHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *point;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *result;

@property (strong, nonatomic) NSDictionary* growTestDict;

+(instancetype)woChengzangHistoryCellWithTableView:(UITableView*)tableView;
@end
