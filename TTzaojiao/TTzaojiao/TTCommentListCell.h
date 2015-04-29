//
//  TTCommentListCell.h
//  TTzaojiao
//
//  Created by hegf on 15-4-29.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTCommentFrame.h"
#import "TTDynamicCommentView.h"

@interface TTCommentListCell : UITableViewCell
@property (strong, nonatomic) TTCommentFrame* commentFrame;
@property (weak, nonatomic) TTDynamicCommentView* commentView;

+(instancetype)commentListCellWithTableView:(UITableView *)tableView;
@end
