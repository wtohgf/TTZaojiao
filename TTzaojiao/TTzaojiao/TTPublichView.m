//
//  TTPublichView.m
//  TTzaojiao
//
//  Created by hegf on 15-5-4.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTPublichView.h"
#define kCommentViewRatio 44.f/600.f

@implementation TTPublichView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor colorWithRed:245.f/255.f green:243.f/255.f blue:239.f/255.f alpha:1.0f];
    if (self) {

        UIButton* selpic = [[UIButton alloc]init];
        
        [self addSubview:selpic];
        _selPicButton = selpic;
        
        selpic.frame = CGRectMake(8, (self.height-30)/2, 30, 30);
        [selpic setImage:[UIImage imageNamed:@"publish_pic1"] forState:UIControlStateNormal];
        [selpic addTarget:self action:@selector(selPic:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton* selbiaoqing = [[UIButton alloc]init];
        
        [self addSubview:selbiaoqing];
        _selBiaoqingButton = selbiaoqing;
        
        selbiaoqing.frame = CGRectMake(_selPicButton.right+8, (self.height-30)/2, 30, 30);
        [selbiaoqing setImage:[UIImage imageNamed:@"publish_pic2"] forState:UIControlStateNormal];
        [selbiaoqing addTarget:self action:@selector(selBiaoqing:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton* publich = [[UIButton alloc]init];
        
        [self addSubview:publich];
        _publicToButton = publich;

        publich.frame = CGRectMake(self.right-8-60, (self.height-30)/2, 60, 30);
        [publich setTitle:@"发布到" forState:UIControlStateNormal];
        [publich setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [publich setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        [publich addTarget:self action:@selector(publictTo:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(void)selPic:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(publichViewdidSelPic:)]) {
        [_delegate publichViewdidSelPic:self];
    }
}

-(void)selBiaoqing:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(publichViewdidSelBiaoqing:)]) {
        [_delegate publichViewdidSelBiaoqing:self];
    }
}

-(void)publictTo:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(publichViewdidPublicTo:)]) {
        [_delegate publichViewdidPublicTo:self];
    }
}

@end
