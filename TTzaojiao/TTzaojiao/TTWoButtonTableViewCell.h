//
//  TTWoButtonTableViewCell.h
//  TTzaojiao
//
//  Created by Liang Zhang on 15/4/23.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
void(^actionSginBlock)();

@interface TTWoButtonTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *signButton;

@end
