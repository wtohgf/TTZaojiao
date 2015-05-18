//
//  TTWoTempTestAnswerCell.m
//  TTzaojiao
//
//  Created by hegf on 15-5-17.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoTempTestAnswerCell.h"

@implementation TTWoTempTestAnswerCell

- (void)awakeFromNib {
    // Initialization code
    _answerLessButton.layer.cornerRadius = 20.f;
    _answerOffenButton.layer.cornerRadius = 20.f;
    _answerAlways.layer.cornerRadius = 20.f;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)answerClicked:(UIButton *)sender {
    if (_block) {
        NSString* timuCheck = nil;
        if ([sender.titleLabel.text isEqualToString:@"极少这样"]) {
            timuCheck = @"1";
        }else if([sender.titleLabel.text isEqualToString:@"经常这样"]){
            timuCheck = @"2";
        }else{
            timuCheck = @"3";
        }
        _block(timuCheck);
    }
}
@end
