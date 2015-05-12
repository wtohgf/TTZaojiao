//
//  TTZaojiaoPlayLessionController.h
//  TTzaojiao
//
//  Created by hegf on 15-5-11.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTBaseViewController.h"
#import "TTPlayLessionHeaderCell.h"
#import "LessionModel.h"
#import "TTPlayLessionIntroduceCell.h"
#import "TTLessionMngTool.h"
#import "DetailLessionModel.h"
#import "TTPlayLessionHeaderCell.h"
#import "AppMvPlayViewController.h"

@interface TTZaojiaoPlayLessionController : TTBaseViewController<UITableViewDataSource, UITableViewDelegate, TTPlayLessionHeaderCellDelegate>
@property (strong, nonatomic) LessionModel* lession;
@property (strong, nonatomic) DetailLessionModel* detailLession;

@end
