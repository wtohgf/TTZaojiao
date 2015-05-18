//
//  TTNearBybabyTableViewCell.m
//  TTzaojiao
//
//  Created by hegf on 15-5-8.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTNearBybabyTableViewCell.h"

@implementation TTNearBybabyTableViewCell

+(instancetype)nearBybabyCellWithTableView:(UITableView *)tableView{
    
    static NSString* ID = @"nearBybabyCell";
    
    TTNearBybabyTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TTNearBybabyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //背景色
        self.backgroundColor = TTBlogBackgroundColor;
        TTNearBybabyInfoView* babyInfoView = [[TTNearBybabyInfoView alloc]init];
        babyInfoView.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth*TTHeaderWithRatio+2*TTBlogTableBorder);
        
        [self.contentView addSubview:babyInfoView];
        self.frame = babyInfoView.frame;
        _babyInfoView = babyInfoView;
        
//        [_babyInfoView.iconView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTap:)]];
    }
    
    return self;
}

-(void)setNearByBaby:(NearByBabyModel *)nearByBaby{
    _nearByBaby = nearByBaby;
    _babyInfoView.nearByBaby = nearByBaby;
    
}

//- (void)iconTap:(UITapGestureRecognizer *)recognizer
//{
//    if ([_delegate respondsToSelector:@selector(didIconTaped:)]) {
//        [_delegate didIconTaped:_babyInfoView.nearByBaby.uid];
//    }
//}


@end
