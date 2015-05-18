//
//  TTWoGrowTestStartCell.m
//  TTzaojiao
//
//  Created by hegf on 15-5-17.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoGrowTestStartCell.h"

@implementation TTWoGrowTestStartCell

- (void)awakeFromNib {
    // Initialization code
    _startButton.layer.cornerRadius = 20.f;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)startGrowTest:(UIButton *)sender {
    if (_block != nil) {
        _block();
    }
}
@end
