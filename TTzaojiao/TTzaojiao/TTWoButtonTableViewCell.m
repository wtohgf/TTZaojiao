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
    [TTUserModelTool getWoisSigned:^(id isSigned) {
        if ([isSigned isEqualToString:@"Error"]) {
            [self.signButton setTitle:@"立即签到" forState:UIControlStateNormal];
            self.signButton.enabled = YES;
            return;
        }
        if ([isSigned isEqualToString:@"YES"]) {
            [self.signButton setTitle:@"已经签到" forState:UIControlStateNormal];
            self.signButton.enabled = NO;
        }else{
            [self.signButton setTitle:@"立即签到" forState:UIControlStateNormal];
            self.signButton.enabled = YES;
        }
    }];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)signAction:(id)sender {
    [TTUserModelTool getWoisSigned:^(id isSigned) {
        if ([isSigned isEqualToString:@"Error"]) {
            actionSginBlock(@"neterror", nil);
            return;
        }
        if ([isSigned isEqualToString:@"YES"]) {
            actionSginBlock(@"isSigned", nil);
        }else{
            [TTUserModelTool BlogSignResult:^(id isSucsses, id baby_jifen) {
                if (isSucsses) {
                    actionSginBlock(@"SingedOK", baby_jifen);
                    [self.signButton setTitle:@"已经签到" forState:UIControlStateNormal];
                    self.signButton.enabled = NO;
                }else{
                    actionSginBlock(@"neterror", nil);
                }
            }];
        }
    }];
}

@end
