//
//  TTDongtaiPicsTableViewCell.m
//  TTzaojiao
//
//  Created by hegf on 15-4-25.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTDongtaiPicsTableViewCell.h"

@implementation TTDongtaiPicsTableViewCell

+(instancetype)dongtaiPicsTableViewCellWithTableView:(UITableView *)tableView{
    
    static NSString* ID = @"picsCell1to3";
    
    TTDongtaiPicsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TTDongtaiPicsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
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
    NSArray* picsArray = nil;
    if (blogModel.i_pic.length != 0) {
        picsArray = [blogModel.i_pic componentsSeparatedByString:@"|"];
    }
    if (picsArray != nil && picsArray.count > 1) {
        [_icons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIImageView* icon = (UIImageView*)obj;
            if (idx > picsArray.count-2) {
                *stop = YES;
            }else{
                NSString* str = [NSString stringWithFormat:@"%@%@",TTBASE_URL,[picsArray objectAtIndex:idx]];
                [icon setImageWithURL:[NSURL URLWithString:str]];
            }
        }];
    }
    _blogModel = blogModel;
}

@end
