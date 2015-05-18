//
//  TTPlayLessionHeaderCell.m
//  TTzaojiao
//
//  Created by hegf on 15-5-11.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTPlayLessionHeaderCell.h"

@implementation TTPlayLessionHeaderCell

+(instancetype)playLessionHeaderCellWithTableView:(UITableView *)tableView{

        static NSString* ID = @"PlayCell";
        
        TTPlayLessionHeaderCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            NSArray* views = [[NSBundle mainBundle]loadNibNamed:@"TTZaojiaoLessionCell" owner:self options:nil];
            if (views != nil && views.count>1) {
                cell = views[1];
            }
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*kWidthHeightRatio);
}

-(void)setLession:(LessionModel *)lession{
    _lession = lession;
    [_lessionImage setImageIcon:lession.i_pic];
    _lessionImage.userInteractionEnabled = YES;
    [_lessionImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playLession:)]];
    _lessionTitle.text = lession.active_name;
 
    NSString* lessionnum = [NSString stringWithFormat:@"%@宝宝在上课", lession.active_num_person];
    _babyCount.text = lessionnum;
    NSString* blognum = [NSString stringWithFormat:@"%@讨论话题", lession.active_num_blog];
    _commentCount.text = blognum;
    
    NSArray* users = [lession.active_user componentsSeparatedByString:@"|"];
    NSMutableArray* icons = [NSMutableArray array];
    if (users.count>0) {
        [users enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString* icon = obj;
            if ([icon hasPrefix:@"/AppCode"]) {
                NSArray* list = [icon componentsSeparatedByString:@","];
                [icons addObject:[list firstObject]];
            }
        }];
    }
    
    if (icons.count>=5) {
        [_baby0Icon setImageIcon:icons[0]];
        [_baby1Icon setImageIcon:icons[1]];
        [_baby2Icon setImageIcon:icons[2]];
        [_baby3Icon setImageIcon:icons[3]];
        [_baby4Icon setImageIcon:icons[4]];
    }else{
        [_baby0Icon setImage:[UIImage imageNamed:@"baby_icon1"]];
        [_baby1Icon setImage:[UIImage imageNamed:@"baby_icon2"]];
        [_baby2Icon setImage:[UIImage imageNamed:@"baby_icon3"]];
        [_baby3Icon setImage:[UIImage imageNamed:@"baby_icon4"]];
        [_baby4Icon setImage:[UIImage imageNamed:@"baby_icon5"]];
    }
    
}

+(CGFloat)cellHeight{
    return [UIScreen mainScreen].bounds.size.width*kWidthHeightRatio;
}

- (IBAction)playLession:(UIButton *)sender {
    if([_delegate respondsToSelector:@selector(didPlayLession)])
    {
        [_delegate didPlayLession];
    }
}


@end
