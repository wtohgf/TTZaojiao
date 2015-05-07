//
//  TTWoPasswordModifyViewController.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/5/7.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoPasswordModifyViewController.h"
#import <RDVTabBarController.h>
#import "TTUserModelTool.h"

@interface TTWoPasswordModifyViewController ()
@property (strong, nonatomic) IBOutlet UITextField *oldTextField;
@property (strong, nonatomic) IBOutlet UITextField *nnewTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmTextField;
@property (strong, nonatomic) IBOutlet UIButton *confirmButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButtonItem;

@end

@implementation TTWoPasswordModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _confirmButton.layer.borderWidth = 1;
    _confirmButton.layer.borderColor = (__bridge CGColorRef)([UIColor colorWithRed:0.710 green:0.251 blue:0.357 alpha:1.000]);
    _confirmButton.layer.cornerRadius = 20.f;
}

-(void)viewWillAppear:(BOOL)animated {
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)rightAction:(id)sender {
#ifdef DEBUG
    NSLog(@"right button item action");
#endif
}

- (IBAction)confirmAction:(UIButton *)sender {
}

@end
