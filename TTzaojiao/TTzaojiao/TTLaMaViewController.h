//
//  TTLaMaViewController.h
//  TTzaojiao
//
//  Created by Liang Zhang on 15/4/21.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBaseViewController.h"

@interface TTLaMaViewController : TTBaseViewController<UITableViewDataSource, UITableViewDelegate,UIActionSheetDelegate>
@property (copy, nonatomic) NSString * i_uid;
@property (copy, nonatomic)    NSString* pageIndex;
@end
