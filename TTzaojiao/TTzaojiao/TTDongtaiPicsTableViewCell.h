//
//  TTDongtaiPicsTableViewCell.h
//  TTzaojiao
//
//  Created by hegf on 15-4-25.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlogModel.h"
#import "BlogReplayModel.h"
#import <UIImageView+AFNetworking.h>
#import <UIButton+AFNetworking.h>
#import "TTWebServerAPI.h"

@interface TTDongtaiPicsTableViewCell : UITableViewCell

@property (weak, nonatomic) NSLayoutConstraint *cellheight;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) NSMutableArray *icons;
@property (strong, nonatomic) BlogModel* blogModel;
+(instancetype)dongtaiPicsTableViewCellWithTableView:(UITableView*)tableView;

@end
