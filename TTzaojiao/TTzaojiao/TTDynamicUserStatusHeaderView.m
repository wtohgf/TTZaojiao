//
//  TTDynamicUserStatusHeaderView.m
//  TTzaojiao
//
//  Created by hegf on 15-4-29.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTDynamicUserStatusHeaderView.h"
#import "UIView+NKMoreAttribute.h"

@implementation TTDynamicUserStatusHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [_iconView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeIcon:)]];
    
    [_coverImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeCover:)]];
}

- (IBAction)zanCover:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(dynamicHeaderView:didActionType:)]) {
        [_delegate dynamicHeaderView:self didActionType:kzanCover];
    }
}

-(void)changeIcon:(UITapGestureRecognizer*)sender{
    if ([_delegate respondsToSelector:@selector(dynamicHeaderView:didActionType:)]) {
        [_delegate dynamicHeaderView:self didActionType:kChangeIcon];
    }
}

-(void)changeCover:(UITapGestureRecognizer*)sender{
    if ([_delegate respondsToSelector:@selector(dynamicHeaderView:didActionType:)]) {
        [_delegate dynamicHeaderView:self didActionType:kChangeCover];
    }
}

- (IBAction)back:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(dynamicHeaderView:didActionType:)]) {
        [_delegate dynamicHeaderView:self didActionType:kBack];
    }
}


@end
