//
//  TTDyanmicUserStautsCell.m
//  TTzaojiao
//
//  Created by hegf on 15-4-27.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTDyanmicUserStautsCell.h"

@implementation TTDyanmicUserStautsCell
+(instancetype)dyanmicUserStautsCellWithTableView:(UITableView *)tableView{
    
    static NSString* ID = @"dynamicUserStatusCell";
    
    TTDyanmicUserStautsCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TTDyanmicUserStautsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //背景色
        self.backgroundColor = TTBlogBackgroundColor;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    for (UIView* subview in self.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    TTDynamicUserStatusTopView* topView = [[TTDynamicUserStatusTopView alloc]init];
    _topView = topView;
    [self.contentView addSubview:topView];
    [_topView.iconView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTap:)]];
    _topView.blogFrame = _blogFrame;
    
    
    TTDaynamicUserStatusZancountView* zanCountView = [[TTDaynamicUserStatusZancountView alloc]init];
    _zanCountView = zanCountView;
    [self.contentView addSubview:zanCountView];
    [_zanCountView.remsgBtn addTarget:self action:@selector(remsg:) forControlEvents:UIControlEventTouchUpInside];
    [_zanCountView.zanBtn addTarget:self action:@selector(zan:) forControlEvents:UIControlEventTouchUpInside];
    _zanCountView.blogFrame = _blogFrame;
    
    
    if (_blogFrame.photosViewF.size.height == 0) {
        if (_photosView != nil) {
            [_photosView removeFromSuperview];
        }
    }else{
        TTDynamicPhotosView* photosView = [[TTDynamicPhotosView alloc]init];
        _photosView = photosView;
        [self.contentView addSubview:photosView];
        _photosView.blogFrame = _blogFrame;
    }
    
    if (_blogFrame.commentsViewF.size.height == 0) {
        if (_commentsView != nil) {
            [_commentsView removeFromSuperview];
        }
    }else{
        TTDynamicCommentsView* commentsView = [[TTDynamicCommentsView alloc]init];
        [self.contentView addSubview:commentsView];
        _commentsView = commentsView;
        _commentsView.blogFrame = _blogFrame;
        [_commentsView.showAllReplayButton addTarget:self action:@selector(showAllReplay:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(void)setBlogFrame:(TTBlogFrame *)blogFrame{
    _blogFrame = blogFrame;
    self.frame = _blogFrame.topViewF;
}

- (void)iconTap:(UITapGestureRecognizer *)recognizer
{
    if ([_delegate respondsToSelector:@selector(dynamicUserStatusTopView:didIconTaped:)]) {
        [_delegate dynamicUserStatusTopView:_topView didIconTaped:_blogFrame.blog.i_uid];
    }
}

-(void)remsg:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(dynamicCell:UserStatusRemsgClicked:)]) {
        
        if (_blogFrame.blog != nil) {
            BlogModel* blog = _blogFrame.blog;
            [_delegate dynamicCell:self UserStatusRemsgClicked:blog.id];
        }
        
    }
}

-(void)zan:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(daynamicUserStatusZanClicked:)]) {
        if (_blogFrame.blog != nil) {
            BlogModel* blog = _blogFrame.blog;
            [_delegate daynamicUserStatusZanClicked:blog.id];
        }
    }
}

#pragma mark 显示全部回复 此处用代理
-(void)showAllReplay:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(dynamicCell:didShowCommentList:)]) {
        if (_blogFrame.blog != nil) {
            BlogModel* blog = _blogFrame.blog;
            [_delegate dynamicCell:self didShowCommentList:blog.id];
        }
        
    }
}

@end

