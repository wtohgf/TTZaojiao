//
//  TTWoPersonalInfoViewController.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/5/7.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoPersonalInfoViewController.h"
#import <RDVTabBarController.h>
#import "TTUserModelTool.h"

@interface TTWoPersonalInfoViewController ()
@property (strong, nonatomic) IBOutlet UITextField *accountTextFeild;
@property (strong, nonatomic) IBOutlet UITextField *nameTextFeild;
@property (strong, nonatomic) IBOutlet UIButton *commitButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButtonItem;

@end

@implementation TTWoPersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _commitButton.layer.borderWidth = 1;
    _commitButton.layer.borderColor = (__bridge CGColorRef)([UIColor colorWithRed:0.710 green:0.251 blue:0.357 alpha:1.000]);
    _commitButton.layer.cornerRadius = 20.f;
    
    _accountTextFeild.text = [[TTUserModelTool sharedUserModelTool] account];
    _nameTextFeild.text = [[[TTUserModelTool sharedUserModelTool] logonUser] name];
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

- (IBAction)commitAction:(UIButton *)sender {
}

@end
