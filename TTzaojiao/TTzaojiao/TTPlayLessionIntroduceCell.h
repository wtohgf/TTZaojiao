//
//  TTPlayLessionIntroduceCell.h
//  TTzaojiao
//
//  Created by hegf on 15-5-11.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTPlayLessionIntroduceView.h"
#import "TTPlayLessionIntroducePicsView.h"
#import "DetailLessionModel.h"

@interface TTPlayLessionIntroduceCell : UITableViewCell
+(instancetype)playLessionIntroduceCellWithTableView:(UITableView*)tableView;
@property (weak, nonatomic) TTPlayLessionIntroduceView* lessionAim;
@property (weak, nonatomic) TTPlayLessionIntroduceView* lessionAttention;
@property (weak, nonatomic) TTPlayLessionIntroduceView* lessionStep;
@property (weak, nonatomic) TTPlayLessionIntroducePicsView* picsView;

@property (strong, nonatomic) DetailLessionModel* detailLession;

+(CGFloat)cellHeightWithModel:(DetailLessionModel*)detailLession;
@end
