//
//  TTCommentRelaseView.m
//  TTzaojiao
//
//  Created by hegf on 15-4-29.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTCommentRelaseView.h"

#define kCommentViewRatio 44.f/600.f

@implementation TTCommentRelaseView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UITextField* textField = [[UITextField alloc]init];
        [self addSubview:textField];
        _commentTextField = textField;
        _commentTextField.borderStyle = UITextBorderStyleRoundedRect;
        //设置边框颜色
        [_commentTextField.layer setBorderColor:[UIColor blackColor].CGColor];
        
        textField.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*4/5, [UIScreen mainScreen].bounds.size.height*kCommentViewRatio);
        [textField addTarget:self action:@selector(editend:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:button];
        _replayButton = button;
        button.frame = CGRectMake(textField.right, 0, [UIScreen mainScreen].bounds.size.width - textField.right, textField.height);
        [button addTarget:self action:@selector(replay:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"发布" forState:UIControlStateNormal];
        
//        button.layer.borderWidth = 4;
//        button.layer.borderColor = (__bridge CGColorRef)([UIColor blackColor]);
        button.layer.cornerRadius = 10.f;
        self.backgroundColor = [UIColor purpleColor];
        [button setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
    }
    return self;
}

-(void)editend:(UITextField*)sender{
    if ([_delegate respondsToSelector:@selector(commentRelaseView:didEndEdit:)]) {
        [_delegate commentRelaseView:self didEndEdit:_commentTextField.text];
    }
}

-(void)replay:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(didReplayButtonClick)]) {
        [_delegate didReplayButtonClick];
    }
}

@end
