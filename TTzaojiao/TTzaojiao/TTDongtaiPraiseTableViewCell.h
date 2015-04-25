//
//  TTDongtaiPraiseTableViewCell.h
//  TTzaojiao
//
//  Created by hegf on 15-4-24.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlogModel.h"

@interface TTDongtaiPraiseTableViewCell : UITableViewCell

@property (strong, nonatomic) BlogModel* blogModel;

@property (weak, nonatomic) IBOutlet UIButton *praisecount;
@property (weak, nonatomic) IBOutlet UIButton *commentcount;

+(instancetype)dongtaiTableViewCellWithTableView:(UITableView*)tableView;


@end
