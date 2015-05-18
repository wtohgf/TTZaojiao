//
//  TTZaojiaoViewController.h
//  TTzaojiao
//
//  Created by Liang Zhang on 15/4/21.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBaseViewController.h"
#import "TTZaojiaoHeaderLeftItem.h"
#import "TTZaojiaoHeaderRightItem.h"
#import "TTWoVipViewController.h"
#import "TTZaojiaoIntroduceCell.h"
#import "TTLessionMngTool.h"
#import "TTZaojiaoLessionCell.h"
#import "TTRegeistViewController.h"

@interface TTZaojiaoViewController : TTBaseViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) TTZaojiaoHeaderLeftItem* leftView;
@property (weak, nonatomic) TTZaojiaoHeaderRightItem* rightView;
@end
