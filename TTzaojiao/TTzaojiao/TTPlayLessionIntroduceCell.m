//
//  TTPlayLessionIntroduceCell.m
//  TTzaojiao
//
//  Created by hegf on 15-5-11.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTPlayLessionIntroduceCell.h"

@implementation TTPlayLessionIntroduceCell

+(instancetype)playLessionIntroduceCellWithTableView:(UITableView *)tableView{
    static NSString* ID = @"PlayLessionIntroduceCell";
    
    TTPlayLessionIntroduceCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TTPlayLessionIntroduceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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

-(void)addSubviews{
    TTPlayLessionIntroduceView * aim = [TTPlayLessionIntroduceView playLessionIntroduceView];
    _lessionAim = aim;
    [self.contentView addSubview:aim];
    
    TTPlayLessionIntroduceView * attention = [TTPlayLessionIntroduceView playLessionIntroduceView];
    _lessionAttention = attention;
    [self.contentView addSubview:attention];
    
    TTPlayLessionIntroduceView * step = [TTPlayLessionIntroduceView playLessionIntroduceView];
    _lessionStep = step;

    [self.contentView addSubview:step];
    

    TTPlayLessionIntroducePicsView* picsView = [TTPlayLessionIntroducePicsView playLessionIntroducePicsView];
    _picsView = picsView;
    [self.contentView addSubview:picsView];
    
}

-(void)setDetailLession:(DetailLessionModel *)detailLession{
    _detailLession = detailLession;
    [_lessionAim setTitle:@"课程目标" Content:detailLession.active_mubiao];
    
    _lessionAim.frame = CGRectMake(TTBlogTableBorder, TTBlogTableBorder, _lessionAim.contentLabel.bounds.size.width, _lessionAim.viewHeight);
    
    [_lessionAttention setTitle:@"注意事项" Content:detailLession.active_zhuyi];
    _lessionAttention.frame = CGRectMake(TTBlogTableBorder, _lessionAim.bottom + TTBlogTableBorder, _lessionAttention.contentLabel.bounds.size.width, _lessionAttention.viewHeight);
    
    [_lessionStep setTitle:@"操作步骤" Content: detailLession.active_buzhou];
    _lessionStep.frame = CGRectMake(TTBlogTableBorder, _lessionAttention.bottom + TTBlogTableBorder, _lessionStep.contentLabel.bounds.size.width, _lessionStep.viewHeight);
    
    _picsView.frame = CGRectMake(TTBlogTableBorder, _lessionStep.bottom, ScreenWidth-2*TTBlogTableBorder, _picsView.viewHeight);
    
    NSArray* picsList = [detailLession.pic componentsSeparatedByString:@"|"];
    
    if (picsList != nil && picsList.count >0) {
        _picsView.introducePics = picsList;
    }
    
    self.frame = CGRectMake(0, 0, ScreenWidth-2*TTBlogTableBorder, _picsView.bottom+TTBlogTableBorder);
}

+(CGFloat)cellHeightWithModel:(DetailLessionModel*)detailLession{
    
    NSString* aimstring = detailLession.active_mubiao;
    CGRect aimbound = [aimstring boundByFont:[UIFont systemFontOfSize:14.f] andWidth:ScreenWidth-2*TTBlogTableBorder];
    
    NSString* attetion = detailLession.active_zhuyi;
    CGRect attentionBound = [attetion boundByFont:[UIFont systemFontOfSize:14.f] andWidth:ScreenWidth-2*TTBlogTableBorder];
    
    NSString* step = detailLession.active_buzhou;
    CGRect stepbound = [step boundByFont:[UIFont systemFontOfSize:14.f] andWidth:ScreenWidth-2*TTBlogTableBorder];
    
    return
    (TTBlogTableBorder+kTitleButtonHeight+TTBlogTableBorder+aimbound.size.height)+
    (TTBlogTableBorder+kTitleButtonHeight+TTBlogTableBorder+attentionBound.size.height)+
    (TTBlogTableBorder+kTitleButtonHeight+TTBlogTableBorder+stepbound.size.height) + TTBlogTableBorder+
    [TTPlayLessionIntroducePicsView viewHeightWithPicsCount:8];
}

@end
