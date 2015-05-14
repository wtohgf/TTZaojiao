//
//  CustomBottomBar.m
//  TTzaojiao
//
//  Created by hegf on 15-5-14.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "CustomBottomBar.h"

@implementation CustomBottomBar

+(instancetype)customBottomBarWithClickedBlock:(CustomClickedBlock)block{
    CustomBottomBar* bar = [[CustomBottomBar alloc]init];
    bar.block = block;
    return bar;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBasicProperty];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    int count = 0;
    CGFloat margin = .5f;
    CGFloat buttonW = (self.frame.size.width - (self.subviews.count-1)*margin)/self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    
    for (UIButton* view in self.subviews) {
        view.frame = CGRectMake(count*(buttonW+margin), 0, buttonW, buttonH);
        view.backgroundColor = [UIColor colorWithRed:155.f/255.f green:80.f/255.f blue:217.f/255.f alpha:1.f];
        view.tintColor = [UIColor whiteColor];
        view.titleLabel.font = [UIFont systemFontOfSize:16.f];
        count++;
    }
}

-(void)setupBasicProperty{
    NSMutableArray* items = [NSMutableArray array];
    _items = items;
    self.bounds = CGRectMake(0, 0, self.frame.size.width, 44.f);
    self.backgroundColor = [UIColor blackColor];
}

-(void)setItems:(NSArray *)items{
    [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            UIButton* button = [[UIButton alloc]init];
            [button setTitle:obj forState:UIControlStateNormal];
            [button addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }];
}

-(void)clicked:(UIButton*)sender{
    if (_block) {
        _block(sender.titleLabel.text);
    }
}

@end
