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

@interface TTZaojiaoPlayLessionController : TTBaseViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) LessionModel* lession;
@end
