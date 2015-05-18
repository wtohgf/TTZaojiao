//
//  TTPlayLessionIntroducePicsView.m
//  TTzaojiao
//
//  Created by hegf on 15-5-11.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTPlayLessionIntroducePicsView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@implementation TTPlayLessionIntroducePicsView

+(instancetype)playLessionIntroducePicsView{
    TTPlayLessionIntroducePicsView* view = [[TTPlayLessionIntroducePicsView alloc]init];
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

    UILabel* title = [[UILabel alloc]init];
    _titleLabel = title;
    title.text = @"课程截图";
    title.font = TTBlogMaintitleFont;
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor colorWithRed:1.f green:196.f/255.f blue:138.f/255.f alpha:1.f];
    
    CGRect titlebound = [@"课程截图" boundByFont:TTBlogMaintitleFont andWidth:ScreenWidth - 2*TTBlogTableBorder];
    _titleLabel.frame = CGRectMake(0, TTBlogTableBorder, titlebound.size.width, kTitleButtonHeight);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:title];
    
    int line = 0;
    int row = 0;
    int linenum = 4;
    
    CGFloat picW = (ScreenWidth - 4*TTBlogTableBorder)/4-2*TTBlogTableBorder;
    CGFloat picH = picW;
    CGFloat leftMargin = 2*TTBlogTableBorder;

    for (int i=0; i<8; i++) {
        row = i%linenum;
        line = i/linenum;
        CGFloat picX = leftMargin+(TTBlogTableBorder + picW)*row;
        CGFloat picY = _titleLabel.bottom + TTBlogTableBorder+(TTBlogTableBorder+picH)*line;
        
        UIImageView* imageView = [[UIImageView alloc]init];
        [self addSubview:imageView];
        imageView.frame = CGRectMake(picX, picY, picW, picH);
        
    }
    
}

-(void)setIntroducePics:(NSArray *)introducePics{
    if (introducePics != nil && introducePics.count > 0) {
        _introducePics = introducePics;
        if (_introducePics.count>=8) {
            int j = 0;
            for (int i= 0; i<self.subviews.count; i++) {
                UIView* subView = self.subviews[i];
                if ([subView isKindOfClass:[UIImageView class]]) {
                    UIImageView * imageView = (UIImageView*)subView;
                    [imageView setImageIcon:_introducePics[j]];
                    j++;
                }
            }
        }
    }
}

+(CGFloat)viewHeightWithPicsCount:(NSUInteger)count{

    NSUInteger line = count/4;
    CGFloat picH = (ScreenWidth - 4*TTBlogTableBorder)/4-2*TTBlogTableBorder;
    CGFloat titleH = kTitleButtonHeight;
    
    return 3*TTBlogTableBorder+titleH+picH*line;
}

@end
