//
//  TTDongtaiPraiseTableViewCell.m
//  TTzaojiao
//
//  Created by hegf on 15-4-24.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTDongtaiPraiseTableViewCell.h"

@implementation TTDongtaiPraiseTableViewCell

+(instancetype)dongtaiTableViewCellWithTableView:(UITableView *)tableView{
    static NSString* ID = @"praiseCell";
    
    TTDongtaiPraiseTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TTDongtaiPraiseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setBlogModel:(BlogModel *)blogModel{
    _praisecount.titleLabel.text = blogModel.i_zan;
    _commentcount.titleLabel.text = blogModel.i_replay;
}

@end
