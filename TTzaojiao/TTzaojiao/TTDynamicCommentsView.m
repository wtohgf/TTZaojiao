//
//  TTDynamicCommentsView.m
//  TTzaojiao
//
//  Created by hegf on 15-4-28.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTDynamicCommentsView.h"
#import "UIButton+MoreAttribute.h"

@implementation TTDynamicCommentsView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i = 0; i<3; i++) {
            TTDynamicCommentView *commentView = [[TTDynamicCommentView alloc] init];
            commentView.userInteractionEnabled = NO;
            commentView.tag = i;
            commentView.hidden = YES;
            [self addSubview:commentView];
        };
        
        UIButton* showAllBtn = [UIButton buttonWithTitleForCell:@"查看全部回复" target:self action:@selector(showAllReplay:)];
        [self addSubview:showAllBtn];
        _showAllReplayButton = showAllBtn;
    }
    return self;
}

-(void)setBlogFrame:(TTBlogFrame *)blogFrame{
    _blogFrame = blogFrame;
    NSMutableArray* commentsFrame = blogFrame.commentsFrame;
    
    if (commentsFrame!= nil && commentsFrame.count != 0) {

        for (int i =0; i<self.subviews.count; i++) {
            if ([self.subviews[i] isKindOfClass:[UIButton class]]) {
                UIButton* btn = self.subviews[i];
                btn.hidden = NO;
            }else{
                TTDynamicCommentView* view = self.subviews[i];
                if (i < commentsFrame.count) {
                    view.hidden = NO;
                    view.commentFrame = commentsFrame[i];
                }else{
                    view.hidden = YES;
                }
            }
        }
        
        CGFloat showAllBtnX = 0;
        CGFloat showAllBtnY = CGRectGetHeight(blogFrame.commentsViewF) - ScreenWidth*TTHeaderWithRatio*0.6;
        CGFloat showAllBtnW = ScreenWidth;
        CGFloat showAllBtnH = ScreenWidth*TTHeaderWithRatio*0.6;
        _showAllReplayButton.frame = CGRectMake(showAllBtnX, showAllBtnY, showAllBtnW, showAllBtnH);
  
        self.frame = blogFrame.commentsViewF;
        
    }else{
        [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIView* view = obj;
            view.hidden = YES;
        }];
    }

}
#pragma mark 显示全部回复 此处用代理
-(void)showAllReplay:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(dynamicCommentsView:didShowCommentList:)]) {
        if (_blogFrame.blog != nil) {
            BlogModel* blog = _blogFrame.blog;
            [_delegate dynamicCommentsView:self didShowCommentList:blog.id];
        }
        
    }
}

@end
