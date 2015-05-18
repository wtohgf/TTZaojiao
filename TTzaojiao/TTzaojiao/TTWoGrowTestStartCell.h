//
//  TTWoGrowTestStartCell.h
//  TTzaojiao
//
//  Created by hegf on 15-5-17.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^startCrowTestBlock) ();

@interface TTWoGrowTestStartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)startGrowTest:(UIButton *)sender;
@property (strong, nonatomic) startCrowTestBlock block;
@end
