//
//  TTZaojiaoViewController.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/4/21.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTZaojiaoViewController.h"

@interface TTZaojiaoViewController ()

@end

@implementation TTZaojiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"";
    
    // Do any additional setup after loading the view.
    TTZaojiaoHeaderLeftItem* leftView = [[TTZaojiaoHeaderLeftItem alloc]init];
    _leftView = leftView;
    leftView.logonUser = [TTUserModelTool sharedUserModelTool].logonUser;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    
    TTZaojiaoHeaderRightItem* rightView = [TTZaojiaoHeaderRightItem zaojiaoHeaderRightItemWithTarget:self Action:@selector(vipPay:)];
    
    _rightView = rightView;
    rightView.logonUser = [TTUserModelTool sharedUserModelTool].logonUser;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)vipPay:(TTZaojiaoHeaderRightItem*)sender{
    UIStoryboard *storyBoardDongTai=[UIStoryboard storyboardWithName:@"WoStoryboard" bundle:nil];
    TTWoVipViewController *vipPayController = (TTWoVipViewController *)[storyBoardDongTai instantiateViewControllerWithIdentifier:@"VIPPAY"];
    [self.navigationController pushViewController:vipPayController animated:YES];
}

@end
