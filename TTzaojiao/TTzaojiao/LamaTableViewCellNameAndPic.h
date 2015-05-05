//
//  LamaTableViewCell1.h
//  TTzaojiao
//
//  Created by dalianembeded on 15/4/30.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LamaTableViewCellModelFrame.h"
@interface LamaTableViewCellNameAndPic : UITableViewCell
+ (instancetype)LamaTableViewCellNameAndPicWithTabelView:(UITableView *)tableView;


@property (nonatomic,weak) UIImageView *picView;
@property (nonatomic,weak) UILabel *nameLabel;
//@property (nonatomic,weak ) UIImageView *picListView;
//@property (nonatomic,weak ) UILabel *companyLabel;
@property (nonatomic,strong) LamaTableViewCellModelFrame *modelFrame;

@end
