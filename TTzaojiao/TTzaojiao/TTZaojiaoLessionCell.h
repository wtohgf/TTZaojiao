//
//  TTZaojiaoLessionCell.h
//  TTzaojiao
//
//  Created by hegf on 15-5-9.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LessionModel.h"
#import "UIImageView+MoreAttribute.h"
#import "TTZaojiaLessionCellView.h"

@interface TTZaojiaoLessionCell : UITableViewCell

@property (strong, nonatomic) LessionModel* lession;
@property (weak, nonatomic) TTZaojiaLessionCellView* subView;
+(instancetype)zaojiaoLessionCellWithTableView:(UITableView*)tableView;
+(CGFloat)cellHeight;

@end
