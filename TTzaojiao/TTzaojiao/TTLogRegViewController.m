//
//  TTLogRegViewController.m
//  TTzaojiao
//
//  Created by hegf on 15-4-17.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTLogRegViewController.h"

@implementation TTLogRegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //设置背景图片
    [self setBackGroundImages];
    
    self.title = @"登录注册";
    
}

#pragma mark 返回主页
- (IBAction)backtoMain:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 设置背景图片
- (void) setBackGroundImages{
    NSString* babyPicName;
    int line = 0, row = 0;
    const int linecount = 4;
    CGFloat babyPicWidth = self.view.frame.size.width/linecount;
    CGFloat babyPicHegiht = babyPicWidth;
    int realnum = 0;
    
    for(int i=0; i<100; i++) {
        line = i/linecount;
        row = i%linecount;
        realnum = i%25;
        babyPicName = [NSString stringWithFormat:@"baby_icon%d",realnum+1];
        UIImageView* baby = [[UIImageView alloc]init];
        [baby setImage:[UIImage imageNamed:babyPicName]];
        CGFloat x = row*babyPicWidth;
        CGFloat y = line*babyPicHegiht;
        
        if (y >= self.view.frame.size.height) {
            break;
        }
        baby.frame = CGRectMake(x, y, babyPicWidth, babyPicHegiht);
        
        [self.view insertSubview:baby belowSubview:self.view.subviews[0]];
    }
}

@end
