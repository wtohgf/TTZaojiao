//
//  LamaTableViewCellPicListAndContent.h
//  TTzaojiao
//
//  Created by dalianembeded on 15/5/4.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LamaTableViewCellModelFrame.h"
@interface LamaTableViewCellPicList : UITableViewCell
+ (instancetype)LamaTableViewCellPicListWithTabelView:(UITableView *)tableView;


@property (nonatomic, strong ) UIImageView *picListView;

@property (nonatomic,strong) LamaTableViewCellModelFrame *modelFrame;
@end
