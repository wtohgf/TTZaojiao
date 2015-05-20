//
//  TTZaojiaoLessionCell.m
//  TTzaojiao
//
//  Created by hegf on 15-5-9.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTZaojiaoLessionCell.h"

@implementation TTZaojiaoLessionCell

+(instancetype)zaojiaoLessionCellWithTableView:(UITableView *)tableView{

        static NSString* ID = @"lessionCell";
        
        TTZaojiaoLessionCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[TTZaojiaoLessionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        TTZaojiaLessionCellView* view = [[TTZaojiaLessionCellView alloc]init];
        [self.contentView addSubview:view];
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kCellHeight);
        _subView = view;
    }
    return self;
}

-(void)setLession:(LessionModel *)lession{
    _lession = lession;
    [_subView.lessionImage setImageIcon:lession.i_pic];
    _subView.lessionTitle.text = lession.active_name;
    
    _subView.rightIcon.hidden = NO;
    _subView.startPlayButton.hidden = YES;
    
    _subView.lessionIntroduce.text = lession.active_intr;
    NSString* lessionnum = [NSString stringWithFormat:@"%@宝宝上课", lession.active_num_person];
    _subView.babyCount.text = lessionnum;
    NSString* blognum = [NSString stringWithFormat:@"%@讨论", lession.active_num_blog];
    _subView.commentCount.text = blognum;
    
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
    
    [icons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIImageView* imageView =  _subView.imageViews[idx];
        [imageView setImageIcon:obj];
        if (idx == _subView.imageViews.count-1) {
            *stop = YES;
        }
    }];
    
}

+(CGFloat)cellHeight{
    return kCellHeight;
}


@end
