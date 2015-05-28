//
//  TTZaojiaLessionCellView.m
//  TTzaojiao
//
//  Created by hegf on 15-5-20.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTZaojiaLessionCellView.h"
#import "UIImage+MoreAttribute.h"

@implementation TTZaojiaLessionCellView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

-(void)addSubviews{
    _imageViews = [NSMutableArray array];
    
    self.frame = CGRectMake(0, 0, ScreenWidth, kCellHeight);
    
    UIImageView* imageView = [[UIImageView alloc]init];
    _lessionImage = imageView;
    [self addSubview:imageView];
    imageView.frame = CGRectMake(TTBlogTableBorder, TTBlogTableBorder*0.5, kCellHeight-TTBlogTableBorder, kCellHeight-TTBlogTableBorder);
    
    UILabel* lessionTitle = [[UILabel alloc]init];
    _lessionTitle = lessionTitle;
    [self addSubview:lessionTitle];
    lessionTitle.font = TTBlogMaintitleFont;
    lessionTitle.textColor = [UIColor blackColor];
    lessionTitle.textAlignment = NSTextAlignmentLeft;
    lessionTitle.numberOfLines = 0;
    lessionTitle.frame = CGRectMake(_lessionImage.right+TTBlogTableBorder, TTBlogTableBorder*0.5, (ScreenWidth- 64.f-8.f - imageView.right - TTBlogTableBorder), 42.f);

    UIButton* playBtn = [[UIButton alloc]init];
    _startPlayButton = playBtn;
    playBtn.backgroundColor = [UIColor colorWithRed:74.f/255.f green:126.f/255.f blue:55.f/255.f alpha:1.f];
    [playBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    playBtn.frame = CGRectMake(lessionTitle.right, (42.f-30.f)*0.5, 64.f, 30.f);
    [playBtn setTitle:@"立即上课" forState:UIControlStateNormal];
    playBtn.titleLabel.font = TTBlogSubtitleFont;
    [self addSubview:playBtn];
    
    UIImageView* rightIcon = [[UIImageView alloc]initWithImage:[UIImage imageWithName:@"left_icon_right.png"]];
    [self addSubview:rightIcon];
    
    rightIcon.frame = CGRectMake(ScreenWidth-17.f, _lessionTitle.height*0.25, 9.f, 21.f);
    _rightIcon = rightIcon;
    
    UILabel* lessionIntro = [[UILabel alloc]init];
    _lessionIntroduce = lessionIntro;
    [self addSubview:lessionIntro];
    
    lessionIntro.font = [UIFont systemFontOfSize:13.f];
    lessionIntro.textAlignment = NSTextAlignmentLeft;
    lessionIntro.textColor = [UIColor grayColor];
    lessionIntro.frame = CGRectMake(lessionTitle.left, lessionTitle.bottom+TTBlogTableBorder*0.5, ScreenWidth-imageView.right-TTBlogTableBorder*2, 14.f);
    
    UIImageView* lessionCountImage = [[UIImageView alloc]init];
    [lessionCountImage setImage:[UIImage imageWithName:@"icon_user_pic.png"]];
    [self addSubview:lessionCountImage];
    
    lessionCountImage.frame = CGRectMake(_lessionIntroduce.left, lessionIntro.bottom+TTBlogTableBorder, 16.f, 16.f);
    
    UILabel* babyCount = [[UILabel alloc]init];
    _babyCount = babyCount;
    [self addSubview:babyCount];
    babyCount.font = [UIFont systemFontOfSize:12.f];
    babyCount.textAlignment = NSTextAlignmentLeft;
    babyCount.textColor = [UIColor purpleColor];

    babyCount.frame = CGRectMake(lessionCountImage.right, lessionCountImage.up, (ScreenWidth-imageView.right-2*TTBlogTableBorder - 2*16.f)*0.6, 16.f);
    
    UIImageView* commentCountImage= [[UIImageView alloc]init];
    [commentCountImage setImage:[UIImage imageWithName:@"icon_comment_pic.png"]];
    [self addSubview:commentCountImage];
    
    commentCountImage.frame = CGRectMake(_babyCount.right, lessionIntro.bottom+TTBlogTableBorder, 16.f, 16.f);
    
    UILabel* commentCount = [[UILabel alloc]init];
    _commentCount = commentCount;
    [self addSubview:commentCount];
    commentCount.font = [UIFont systemFontOfSize:12.f];
    commentCount.textAlignment = NSTextAlignmentLeft;
    commentCount.textColor = [UIColor purpleColor];
    
    commentCount.frame = CGRectMake(commentCountImage.right+2.f, babyCount.up, (ScreenWidth-imageView.right-2*TTBlogTableBorder - 2*16.f)*0.4, 16.f);
    
    for (int i = 0; i<5; i++) {
        UIImageView* imageView = [[UIImageView alloc]init];
        [_imageViews addObject:imageView];
        [self addSubview:imageView];
        imageView.frame = CGRectMake(_lessionImage.right + TTBlogTableBorder + (TTBlogTableBorder*0.25+30.f)*i, _commentCount.bottom+TTBlogTableBorder, 30.f, 30.f);
    }
}

@end
