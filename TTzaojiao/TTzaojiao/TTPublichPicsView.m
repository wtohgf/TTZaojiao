//
//  TTPublichPicsView.m
//  TTzaojiao
//
//  Created by hegf on 15-5-4.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTPublichPicsView.h"


@implementation TTPublichPicsView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    _pics = [NSMutableArray array];
    if (self) {
        // 初始化9个子控件
        int line = 0;
        int row = 0;
        CGFloat picW = kPicWRatio*kScreenWidth;
        CGFloat picH = picW;
        
        for (int i = 0; i<9; i++) {
            row = i%3;
            line = i/3;
            CGFloat picX = kBoder + row*(picW+kMargin);
            CGFloat picY = kBoder + line*(picH+kMargin);
            
            UIImageView *photoView = [[UIImageView alloc] init];
            photoView.frame = CGRectMake(picX, picY, picW, picH);
            photoView.userInteractionEnabled = YES;
            photoView.tag = i;
            [self addSubview:photoView];
            [_pics addObject:photoView];
            photoView.hidden = YES;
        }
    }
    return self;
}

-(void)addPic:(NSString *)picName{
    for (int i=0; i<_pics.count; i++) {
        UIImageView* imageView = self.subviews[i];
        if (imageView.hidden == YES) {
            imageView.hidden = NO;
            [imageView setImage:[UIImage imageNamed:picName]];
            break;
        }
    }
}

-(void)addPicImage:(UIImage *)image{
    for (int i=0; i<_pics.count; i++) {
        UIImageView* imageView = self.subviews[i];
        if (imageView.hidden == YES) {
            imageView.hidden = NO;
            [imageView setImage:image];
            break;
        }
    }
}

-(void)hidenAllImage{
    for (UIView* subview in self.subviews) {
        subview.hidden = YES;
    }
}

@end
