//
//  TTDongtaiCommentTableViewCell.h
//  TTzaojiao
//
//  Created by hegf on 15-4-23.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlogModel.h"
#import "BlogReplayModel.h"
#import <UIImageView+AFNetworking.h>
#import "TTWebServerAPI.h"

@interface TTDongtaiCommentTableViewCell : UITableViewCell

@property (strong, nonatomic) BlogReplayModel * blogReplayModel;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UIImageView *commentbabyIcon;
@property (weak, nonatomic) IBOutlet UILabel *commentbabyName;

+(instancetype)dongtaiTableViewCellWithTableView:(UITableView*)tableView;
@end
