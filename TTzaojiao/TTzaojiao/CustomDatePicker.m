//
//  CustomDatePicker.m
//  TTzaojiao
//
//  Created by hegf on 15-4-22.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "CustomDatePicker.h"
#define kDuration 0.3

@implementation CustomDatePicker

-(id)initWithTitle:(NSString *)title delegate:(id)delegate{
    self = [[[NSBundle mainBundle] loadNibNamed:@"CustomDatePicker" owner:self options:nil] objectAtIndex:0];
    if (self) {
        self.delegate = delegate;
        self.toptitle.text = title;
    }
    return self;
}

- (void)showInView:(UIView *) view
{
    UIView* backMaskView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _backMaskView = backMaskView;
    backMaskView.backgroundColor = [UIColor whiteColor];
    backMaskView.alpha = 0.1;

    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [self setAlpha:1.0f];
    [self.layer addAnimation:animation forKey:@"TTDatePickerView"];
    self.backgroundColor = [UIColor whiteColor];
    self.alpha = 0.8;
    self.frame = CGRectMake(0, view.frame.size.height*0.7, view.frame.size.width, view.frame.size.height*0.3);
    [view addSubview:backMaskView];
    [view addSubview:self];
}

- (IBAction)SetDate:(UIButton *)sender {
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"TSLocateView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    [_backMaskView removeFromSuperview];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:1];
    }
  
}

- (IBAction)Cancel:(UIButton *)sender {
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"TTDatePickerView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    [_backMaskView removeFromSuperview];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:0];
    }
}


@end
