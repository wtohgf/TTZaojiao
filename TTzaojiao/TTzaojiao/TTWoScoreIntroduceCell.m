//
//  TTWoScoreIntroduceCell.m
//  TTzaojiao
//
//  Created by hegf on 15-5-17.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoScoreIntroduceCell.h"

@implementation TTWoScoreIntroduceCell

- (void)awakeFromNib {
    // Initialization code
    if ([UIScreen mainScreen].bounds.size.width <=320) {
        _title.font = [UIFont systemFontOfSize:10.f];
        _score.font = [UIFont systemFontOfSize:10.f];
        _introduce.font = [UIFont systemFontOfSize:10.f];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
