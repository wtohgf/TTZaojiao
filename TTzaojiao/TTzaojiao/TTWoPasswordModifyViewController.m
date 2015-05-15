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
#import "TTUserDongtaiViewController.h"

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
    UIStoryboard *storyBoardDongTai=[UIStoryboard storyboardWithName:@"DongTaiStoryboard" bundle:nil];
    TTUserDongtaiViewController *userViewController = (TTUserDongtaiViewController *)[storyBoardDongTai instantiateViewControllerWithIdentifier:@"UserUIM"];
    [userViewController setI_uid:[[[TTUserModelTool sharedUserModelTool] logonUser] ttid]];
    [self.navigationController pushViewController:userViewController animated:YES];
}

- (IBAction)confirmAction:(UIButton *)sender {
    if (_oldTextField.text.length < 4 || _oldTextField.text.length > 14) {
        [MBProgressHUD TTDelayHudWithMassage:@"请输入4到14密码" View:self.navigationController.view];
        return;
    }
    
    if (_nnewTextField.text.length < 4 || _nnewTextField.text.length > 14) {
        [MBProgressHUD TTDelayHudWithMassage:@"请输入4到14密码" View:self.navigationController.view];
        return;
    }
    
    if (_confirmTextField.text.length < 4 || _confirmTextField.text.length > 14) {
        [MBProgressHUD TTDelayHudWithMassage:@"请输入4到14密码" View:self.navigationController.view];
        return;
    }
    
    if (![_confirmTextField.text isEqualToString:_nnewTextField.text]) {
        [MBProgressHUD TTDelayHudWithMassage:@"两次输入的密码不一致 请重新输入" View:self.navigationController.view];
        return;
    }
    [[AFAppDotNetAPIClient sharedClient] apiGet:UPDATE_PASSWORD
                                     Parameters:@{@"i_uid":[[[TTUserModelTool sharedUserModelTool] logonUser] ttid],
                                                  @"i_psd":[[TTUserModelTool sharedUserModelTool] password],
                                                  @"opsd":_oldTextField.text,
                                                  @"psd":_nnewTextField.text,
                                                  @"rpsd":_confirmTextField.text}
                                         Result:^(id result_data, ApiStatus result_status, NSString *api) {
                                             if (result_status == ApiStatusSuccess) {
                                                 if ([result_data isKindOfClass:[NSMutableArray class]]) {
                                                     NSMutableArray* resultList = result_data;
                                                     if (resultList.count > 0) {
                                                         NSDictionary* dict = [resultList firstObject];
                                                         if ([[dict objectForKey:@"msg"] isEqualToString:@"Err_Normal"]) {
                                                             [MBProgressHUD TTDelayHudWithMassage:[dict objectForKey:@"msg_word"] View:self.navigationController.view];
                                                         }else if([[dict objectForKey:@"msg"]isEqualToString:@"No_Login"]){
                                                            [MBProgressHUD TTDelayHudWithMassage:@"原始密码错误" View:self.navigationController.view];
                                                         }else if([[dict objectForKey:@"msg"]isEqualToString:@"Get_Mod_User_Psd"]){
                                                             [[TTUserModelTool sharedUserModelTool]setPassword:[dict objectForKey:@"i_psd"]];
                                                            [MBProgressHUD TTDelayHudWithMassage:@"密码修改成功" View:self.navigationController.view];
                                                         }
                                                     }
                                                 }
                                             }
                                             else {
                                                 [MBProgressHUD TTDelayHudWithMassage:@"网络连接有问题 请检查网络" View:self.navigationController.view];
                                             }
                                         }];
}

@end
