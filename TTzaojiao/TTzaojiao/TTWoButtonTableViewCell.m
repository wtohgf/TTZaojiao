//
//  TTWoButtonTableViewCell.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/4/23.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoButtonTableViewCell.h"

@implementation TTWoButtonTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)signAction:(id)sender {
    actionSginBlock();
}

@end
