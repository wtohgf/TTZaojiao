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

//Cell宽高比 确保显示协调
#define kWidthHeightRatio 188/640


@interface TTZaojiaoLessionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *lessionImage;
@property (weak, nonatomic) IBOutlet UILabel *lessionTitle;
@property (weak, nonatomic) IBOutlet UILabel *lessionIntroduce;
@property (weak, nonatomic) IBOutlet UILabel *babyCount;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UIImageView *baby1Icon;
@property (weak, nonatomic) IBOutlet UIImageView *baby2Icon;
@property (weak, nonatomic) IBOutlet UIImageView *baby4Icon;
@property (weak, nonatomic) IBOutlet UIImageView *baby3Icon;
@property (weak, nonatomic) IBOutlet UIImageView *baby0Icon;


@property (strong, nonatomic) LessionModel* lession;

+(instancetype)zaojiaoLessionCellWithTableView:(UITableView*)tableView;
+(CGFloat)cellHeight;

@end
