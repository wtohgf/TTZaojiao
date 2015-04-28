//
//  TTDynamicCommentsView.m
//  TTzaojiao
//
//  Created by hegf on 15-4-28.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTDynamicCommentsView.h"

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
        
        UIButton* showAllBtn = [[UIButton alloc]init];
        [self addSubview:showAllBtn];
        
        [showAllBtn setTitle:@"查看全部回复" forState:UIControlStateNormal];
        [showAllBtn setTitleColor:[UIColor colorWithRed:51.f/255.f green:144.f/255.f blue:207.f/255.f alpha:1.f] forState:UIControlStateNormal];
        [showAllBtn setTitleColor:[UIColor colorWithRed:245.f/255.f green:245.f/255.f blue:245.f/255.f alpha:1.f] forState:UIControlStateHighlighted];
        [showAllBtn addTarget:self action:@selector(showAllReplay:) forControlEvents:UIControlEventTouchUpInside];
        
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
    
}

@end
