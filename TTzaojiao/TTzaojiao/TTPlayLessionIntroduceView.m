//
//  TTPlayLessionIntroduceView.m
//  TTzaojiao
//
//  Created by hegf on 15-5-11.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTPlayLessionIntroduceView.h"

@implementation TTPlayLessionIntroduceView

+(instancetype)playLessionIntroduceView{
    TTPlayLessionIntroduceView* view = [[TTPlayLessionIntroduceView alloc]init];
    return view;
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    UIView * titleView = [[UIView alloc]init];
    
    UILabel* title = [[UILabel alloc]init];
    _titleLabel = title;
    title.font = TTBlogMaintitleFont;
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor colorWithRed:1.f green:196.f/255.f blue:138.f/255.f alpha:1.f];
    [titleView addSubview:title];
    [self addSubview:titleView];
    
    UILabel* content = [[UILabel alloc]init];
    _contentLabel = content;
    content.font = TTBlogSubtitleFont;
    [self addSubview:content];
    
}

-(void)setTitle:(NSString*)title Content:(NSString*)content{
    _titleLabel.text = title;
    _contentLabel.text = content;
}

-(CGFloat)viewHeight{
    CGRect titlebound = [@"注意事项" boundByFont:TTBlogMaintitleFont andWidth:ScreenWidth - 2*TTBlogTableBorder];
    _titleLabel.frame = CGRectMake(0, 0, titlebound.size.width, kTitleButtonHeight);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_titleLabel superview].frame = _titleLabel.frame;
    [_titleLabel superview].layer.cornerRadius = 4.f;
    
    CGFloat contentX = _titleLabel.left;
    CGFloat contentY = _titleLabel.height+TTBlogTableBorder;
    CGFloat contentW = ScreenWidth - 2*TTBlogTableBorder;
    CGRect bound = [_contentLabel.text boundByFont:TTBlogSubtitleFont andWidth:contentW];
    CGFloat contentH = bound.size.height;
    _contentLabel.numberOfLines = 0;
    _contentLabel.frame = CGRectMake(contentX, contentY, contentW, contentH);
    
    self.bounds = CGRectMake(0, 0, contentW, _contentLabel.bottom);
    
    return self.bounds.size.height;
}

@end
