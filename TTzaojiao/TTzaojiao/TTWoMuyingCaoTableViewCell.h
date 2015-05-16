//
//  TTWoMuyingCaoTableViewCell.h
//  TTzaojiao
//
//  Created by hegf on 15-5-16.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTWoMuyingCaoTableViewCell : UITableViewCell

@property (weak, nonatomic) UILabel* title;
@property (weak, nonatomic) UILabel* content;

+(instancetype)woMuyingCaoTableViewCellWithTableView:(UITableView*)tableView;

+(CGFloat)cellHeight;
@end
