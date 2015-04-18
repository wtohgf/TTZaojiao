//
//  TTMainPageViewController.m
//  TTzaojiao
//
//  Created by hegf on 15-4-15.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTMainPageViewController.h"
#import "HSDatePickerViewController.h"

@interface TTMainPageViewController ()
@property (weak, nonatomic) IBOutlet UIButton *logregButton;
@property (weak, nonatomic) IBOutlet UIView *year;
@property (weak, nonatomic) IBOutlet UILabel *mouth;
@property (weak, nonatomic) IBOutlet UILabel *day;

- (IBAction)startTryTeach:(UIButton *)sender;
- (IBAction)dateChoice:(UIButton *)sender;

@end

@implementation TTMainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //设置背景图片
    [self setBackGroundImages];
    
}

#pragma mark 开始体验
- (IBAction)startTryTeach:(UIButton *)sender {
    NSLog(@"startTryTeach");
}

#pragma mark 生日选择
- (IBAction)dateChoice:(UIButton *)sender {
    HSDatePickerViewController* dateVC = [[HSDatePickerViewController alloc]init];
    [self presentViewController:dateVC animated:YES completion:^{
        ;
    }];
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
        
        [self.view insertSubview:baby belowSubview:_logregButton];
    }
}

@end
