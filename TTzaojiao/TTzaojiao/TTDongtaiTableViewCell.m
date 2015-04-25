//
//  TTDongtaiTableViewCell.m
//  TTzaojiao
//
//  Created by hegf on 15-4-23.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTDongtaiTableViewCell.h"


@implementation TTDongtaiTableViewCell

+(instancetype)dongtaiTableViewCellWithTableView:(UITableView *)tableView{
    static NSString* ID = @"dongtaiCell";
    
    TTDongtaiTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TTDongtaiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    _dongtai.text = blogModel.i_content;
    _babyName.text = blogModel.baby_name;

}

@end
