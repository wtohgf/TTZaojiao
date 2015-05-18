//
//  TTWoGrowTestIntroduceCell.h
//  TTzaojiao
//
//  Created by hegf on 15-5-17.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTWoGrowTestIntroduceCell : UITableViewCell
@property (weak, nonatomic) UILabel* title;
@property (weak, nonatomic) UILabel* content;

@property (strong, nonatomic) NSDictionary* titleContent;

+(instancetype)woGrowTestIntroduceCellWithTableView:(UITableView *)tableView;
+(CGFloat)cellHeightWith:(NSDictionary *)content;
@end
