//
//  TTDongtaiTableViewCell.h
//  TTzaojiao
//
//  Created by hegf on 15-4-23.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTDongtaiCommentTableViewCell.h"
#import "BlogModel.h"

@interface TTDongtaiTableViewCell : UITableViewCell

@property (strong, nonatomic) BlogModel* blogModel;

@property (weak, nonatomic) IBOutlet UILabel *blogTime;
@property (weak, nonatomic) IBOutlet UIImageView *icon1;
@property (weak, nonatomic) IBOutlet UIImageView *icon2;
@property (weak, nonatomic) IBOutlet UIImageView *icon3;
@property (weak, nonatomic) IBOutlet UILabel *babyName;
@property (weak, nonatomic) IBOutlet UIImageView *babyIcon;
@property (weak, nonatomic) IBOutlet UILabel *dongtai;

+(instancetype)dongtaiTableViewCellWithTableView:(UITableView*)tableView;

@end
