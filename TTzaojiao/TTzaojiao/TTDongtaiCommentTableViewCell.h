//
//  TTDongtaiCommentTableViewCell.h
//  TTzaojiao
//
//  Created by hegf on 15-4-23.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlogModel.h"

@interface TTDongtaiCommentTableViewCell : UITableViewCell

@property (strong, nonatomic) BlogModel* blogModel;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UIImageView *commentbabyIcon;

+(instancetype)dongtaiTableViewCellWithTableView:(UITableView*)tableView;
@end
