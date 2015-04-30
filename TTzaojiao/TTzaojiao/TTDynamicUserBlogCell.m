//
//  TTDynamicUserBlogCell.m
//  TTzaojiao
//
//  Created by hegf on 15-4-30.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTDynamicUserBlogCell.h"
#import "UIButton+MoreAttribute.h"

@implementation TTDynamicUserBlogCell

+(instancetype)dyanmicUserBlogCellWithTableView:(UITableView *)tableView{
    
    static NSString* ID = @"dynamicUserBlogCell";
    
    TTDynamicUserBlogCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TTDynamicUserBlogCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //背景色
        self.backgroundColor = TTBlogBackgroundColor;
        
        TTDynamicUserStatusTopView* topView = [[TTDynamicUserStatusTopView alloc]init];
        _topView = topView;
        [self.contentView addSubview:topView];
        
        TTDynamicPhotosView* photosView = [[TTDynamicPhotosView alloc]init];
        _photosView = photosView;
        [self.contentView addSubview:photosView];
        
        TTDaynamicUserStatusZancountView* zanCountView = [[TTDaynamicUserStatusZancountView alloc]init];
        _zanCountView = zanCountView;
        [self.contentView addSubview:zanCountView];

        UIButton* showAllBtn = [UIButton buttonWithTitleForCell:@"查看全部回复" target:self action:@selector(showAllReplay:)];
        [self.contentView addSubview:showAllBtn];
        _showAllReplayButton = showAllBtn;
    }
    return self;
}

-(void)setBlogFrame:(TTUserBlogFrame *)blogFrame{
    _blogFrame = blogFrame;
    self.contentView.frame = blogFrame.topViewF;
    _topView.userblogFrame = blogFrame;
    
    _photosView.userblogFrame = blogFrame;
    
    _zanCountView.userblogFrame = blogFrame;
    
    CGFloat showAllBtnX = 0;
    CGFloat showAllBtnY = CGRectGetMaxY(blogFrame.zanCountViewF);
    CGFloat showAllBtnW = ScreenWidth;
    CGFloat showAllBtnH = ScreenWidth*TTHeaderWithRatio*0.6;
    _showAllReplayButton.frame = CGRectMake(showAllBtnX, showAllBtnY, showAllBtnW, showAllBtnH);
    
}

#pragma mark 显示全部回复 此处用代理
-(void)showAllReplay:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(dynamicUserBlogCell:didShowCommentList:)]) {
        if (_blogFrame.userblog != nil) {
            BlogUserDynamicModel* blog = _blogFrame.userblog;
            [_delegate dynamicUserBlogCell:self didShowCommentList:blog.id];
        }
    }
}
@end
