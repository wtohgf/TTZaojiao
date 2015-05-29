//
//  TTYuyingTableViewCell.m
//  TTzaojiao
//
//  Created by hegf on 15-5-29.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTYuyingTableViewCell.h"
#import "TTBlogFrame.h"
#import "UIView+NKMoreAttribute.h"
#import "UIImage+MoreAttribute.h"
#import "UIImageView+MoreAttribute.h"

#define iconHeight 100.f
#define bottomHeight 30.f

@implementation TTYuyingTableViewCell

+(instancetype)yuyingTableViewCellWithTableView:(UITableView *)tableView{
    static NSString* ID = @"yuyingCell";
    TTYuyingTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TTYuyingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _icon.frame = CGRectMake(TTBlogTableBorder, TTBlogTableBorder, iconHeight, iconHeight);
    
    _name.frame = CGRectMake(_icon.right+TTBlogTableBorder*0.5, TTBlogTableBorder, (ScreenWidth-_icon.right)*0.6, iconHeight*0.3);
    
    _price.frame = CGRectMake(_name.right, TTBlogTableBorder, (ScreenWidth-_icon.right)*0.4, iconHeight*0.3);
    
    _type.frame = CGRectMake(_name.left, _name.bottom, (ScreenWidth-_icon.right), iconHeight*0.3);
    
    _babyCount.frame = CGRectMake(_type.left, _type.bottom, (ScreenWidth-_icon.right), iconHeight*0.2);
    
    _expirence.frame = CGRectMake(_babyCount.left, _babyCount.bottom, (ScreenWidth-_icon.right), iconHeight*0.2);
    
    _bottomView.frame = CGRectMake(0.f, _icon.bottom+TTBlogTableBorder, ScreenWidth, bottomHeight);
    
    _masterrange.frame = CGRectMake(TTBlogTableBorder, 0.f, (ScreenWidth-2*TTBlogTableBorder)*0.7, bottomHeight);
    
    _distance.frame = CGRectMake(ScreenWidth*0.7, 0.f, (ScreenWidth-2*TTBlogTableBorder)*0.3, bottomHeight);
}

-(void)addSubviews{
    UIImageView* icon = [[UIImageView alloc]init];
    [self.contentView addSubview:icon];
    _icon = icon;
    
    UILabel* name = [[UILabel alloc]init];
    [self.contentView addSubview:name];
    name.font = TTBlogMaintitleFont;
    _name = name;
    
    UIButton* price = [[UIButton alloc]init];
    price.titleLabel.font = TTBlogMaintitleFont;
    price.titleLabel.textColor = [UIColor redColor];
    price.userInteractionEnabled = NO;
    [self.contentView addSubview:price];
    [price setImage:[UIImage imageWithName:@"renminbi.png"] forState:UIControlStateNormal];
    [price setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _price = price;
    
    UILabel* type = [[UILabel alloc]init];
    type.textColor = [UIColor orangeColor];
    type.font = TTBlogSubtitleFont;
    [self.contentView addSubview:type];
    _type = type;
    
    UILabel* babyCount = [[UILabel alloc]init];
    [self.contentView addSubview:babyCount];
    _babyCount = babyCount;
    
    UILabel* expirence = [[UILabel alloc]init];
    [self.contentView addSubview:expirence];
    expirence.font = TTBlogSubtitleFont;
    _expirence = expirence;
    
    UIView* bottomView = [[UIView alloc]init];
    _bottomView = bottomView;
    _bottomView.backgroundColor = TTBlogBackgroundColor;
    UILabel* masterrange = [[UILabel alloc]init];
    [bottomView addSubview:masterrange];
    _masterrange = masterrange;
    masterrange.font = TTBlogSubtitleFont;
    masterrange.textColor = [UIColor grayColor];
    
    UIButton* distance = [[UIButton alloc]init];
    distance.userInteractionEnabled = NO;
    [distance setImage:[UIImage imageWithName:@"distance.png"] forState:UIControlStateNormal];
    _distance = distance;
    distance.titleLabel.font = TTBlogSubtitleFont;
    [distance setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [bottomView addSubview:distance];
    
    [self.contentView addSubview:bottomView];
    
}

+(CGFloat)cellHeight{
    return iconHeight+bottomHeight+2*TTBlogTableBorder;
}

-(void)setYuyingModel:(YuyingModel *)yuyingModel{
    _yuyingModel = yuyingModel;
    self.frame = CGRectMake(0, 0, ScreenWidth, iconHeight+bottomHeight+2*TTBlogTableBorder);
    NSArray* icons = [_yuyingModel.i_photo componentsSeparatedByString:@"|"];
    
    [_icon setImageIcon:[icons firstObject]];
    [_type setText:yuyingModel.i_sort_name];
    [_name setText:yuyingModel.i_nickname];
    [_price setTitle:yuyingModel.i_price forState:UIControlStateNormal];
    //_price.titleLabel.text = yuyingModel.i_price;
    
    [_expirence setText:yuyingModel.i_intr];
    [_masterrange setText:yuyingModel.i_type];
    [_distance setTitle:@" 0.00km" forState:UIControlStateNormal];
}

-(void)dealloc{
    _yuyingModel = nil;
}

@end
