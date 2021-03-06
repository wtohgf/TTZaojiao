//
//  TTWoVipViewController.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/5/6.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoVipViewController.h"
#import "AlipayRequestConfig+TTAlipay.h"
#import <RDVTabBarController.h>
#import "TTUserModelTool.h"
#import "TTUserDongtaiViewController.h"

@interface TTWoVipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *cardTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property (weak, nonatomic) IBOutlet UIButton *payButton;

@end

@implementation TTWoVipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _commitButton.layer.borderWidth = 1;
    _commitButton.layer.borderColor = (__bridge CGColorRef)([UIColor colorWithRed:0.710 green:0.251 blue:0.357 alpha:1.000]);
    _commitButton.layer.cornerRadius = 20.f;
    _payButton.layer.borderWidth = 1;
    _payButton.layer.borderColor = (__bridge CGColorRef)([UIColor colorWithRed:0.710 green:0.251 blue:0.357 alpha:1.000]);
    _payButton.layer.cornerRadius = 20.f;
    
    NSString *account = [[TTUserModelTool sharedUserModelTool] account];
    if (account != nil &&
        ![account isEqualToString:@""]) {
        _accountTextFiled.text = account;
    }
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

- (IBAction)endEdit:(UITextField *)sender {
    [sender resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)commitAction:(UIButton *)sender {
//    PAY_BY_CARD
    [[AFAppDotNetAPIClient sharedClient] apiGet:PAY_BY_CARD Parameters:@{@"i_uid":[[[TTUserModelTool sharedUserModelTool] logonUser] ttid],@"i_psd":[[[TTUserModelTool sharedUserModelTool] logonUser] id_c],@"i_card":_cardTextField.text,@"i_password":_passwordTextField.text} Result:^(id result_data, ApiStatus result_status, NSString *api) {
        if (result_status == ApiStatusSuccess) {
            [[[UIAlertView alloc] init] showWithTitle:@"" message:[[result_data firstObject] objectForKey:@"msg_word"] cancelButtonTitle:@"重试一下"];
        }
        else {
            [MBProgressHUD TTDelayHudWithMassage:@"网络连接有问题 请检查网络" View:self.view];
        }
    }];
}

- (IBAction)alipayAction:(UIButton *)sender {
//    VIP_PRICE
    [self performSegueWithIdentifier:@"vippriceSegue" sender:self];
}

-(void)dealloc{
    
}
@end
