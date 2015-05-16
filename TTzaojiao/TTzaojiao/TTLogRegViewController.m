//
//  TTLogRegViewController.m
//  TTzaojiao
//
//  Created by hegf on 15-4-17.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTLogRegViewController.h"
#import "CustomBottomBar.h"

@interface TTLogRegViewController()
@property (weak, nonatomic) CustomBottomBar* bottomBar;
@end

@implementation TTLogRegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //设置背景图片
    [self setBackGroundImages];
    //    //添加低栏
    [self addBottomBar];
    
    self.title = @"登录注册";
    
}

#pragma mark 添加低栏
-(void)addBottomBar{
    CGFloat h = kBottomBarHeight;
    CGFloat w = [UIApplication sharedApplication].keyWindow.frame.size.width;
    CGFloat y = [UIApplication sharedApplication].keyWindow.frame.size.height -  h;
    CGFloat x = 0;
    
    CustomBottomBar* bottomBar = [CustomBottomBar customBottomBarWithClickedBlock:^(NSString *title) {
        if ([title isEqualToString:@"返回"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else if ([title isEqualToString:@"注册"]) {
            [self performSegueWithIdentifier:@"LogRegToReg" sender:nil];
        }else if([title isEqualToString:@"登录"]){
            [self performSegueWithIdentifier:@"LogRegToLogon" sender:nil];
        }
        
    }];
    NSArray* items;
    _bottomBar = bottomBar;
//    if ([TTUserModelTool sharedUserModelTool].logonUser == nil) {
        items = @[@"返回", @"注册", @"登录"];
//    }else{
//        items = @[@"注册", @"登录"];
//    }
    
    bottomBar.items = items;
    _bottomBar.frame = CGRectMake(x, y, w, h);
    [self.view addSubview:_bottomBar];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
     [[self rdv_tabBarController] setTabBarHidden:NO];
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
