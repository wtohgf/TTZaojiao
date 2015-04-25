//
//  TTDongtaiCommentTableViewCell.m
//  TTzaojiao
//
//  Created by hegf on 15-4-23.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTDongtaiCommentTableViewCell.h"

@implementation TTDongtaiCommentTableViewCell

+(instancetype)dongtaiTableViewCellWithTableView:(UITableView *)tableView{
    static NSString* ID = @"commentCell";
    
    TTDongtaiCommentTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TTDongtaiCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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

-(void)setBlogReplayModel:(BlogReplayModel *)blogReplayModel{
    _comment.text = blogReplayModel.i_content;
//    NSString* str = [NSString stringWithFormat:@"%@%@",TTBASE_URL ,blogReplayModel.face];
//    [_commentbabyIcon setImageWithURL:[NSURL URLWithString:str]];
    _commentbabyName.text = blogReplayModel.baby_name;
}


@end
