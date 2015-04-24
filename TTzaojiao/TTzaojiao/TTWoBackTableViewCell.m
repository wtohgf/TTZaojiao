//
//  TTWoBackTableViewCell.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/4/23.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoBackTableViewCell.h"

@implementation TTWoBackTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _backButton.layer.borderWidth = 1;
    _backButton.layer.borderColor = (__bridge CGColorRef)([UIColor colorWithRed:0.710 green:0.251 blue:0.357 alpha:1.000]);
    _backButton.layer.cornerRadius = 20.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)backAction:(id)sender {
    actionBackBlock();
}

@end
