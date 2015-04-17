//
//  TTLogonViewController.m
//  TTzaojiao
//
//  Created by hegf on 15-4-17.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTLogonViewController.h"
#import "AFAppDotNetAPIClient.h"
#import "TTWebServerAPI.h"

@interface TTLogonViewController ()
{
    CGFloat _backBottonBarY;
}

@property (weak, nonatomic) IBOutlet UIView *bottomBar;
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)backLogRegPage:(UIButton *)sender;
- (IBAction)Logon:(UIButton *)sender;

@end

@implementation TTLogonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //注册键盘出现与隐藏时候的通知
    
    CGFloat h = self.view.frame.size.height*44/600;
    CGFloat w = self.view.frame.size.width;
    CGFloat y = self.view.frame.size.height -  h;
    CGFloat x = 0;
    _bottomBar.frame = CGRectMake(x, y, w, h);
    _backBottonBarY = y;
    [self.view addSubview:_bottomBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboadWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


//键盘出现时候调用的事件
-(void) keyboadWillShow:(NSNotification *)note{
    NSDictionary *info = [note userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//键盘的frame
    CGFloat offY = (self.view.frame.size.height-keyboardSize.height)-_bottomBar.frame.size.height;//屏幕总高度-键盘高度-bottomBar高度
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame =  _bottomBar.frame;
        frame.origin.y =  offY;//UITextField位置的y坐标移动到offY
        _bottomBar.frame = frame;
    }];

}
//键盘消失时候调用的事件
-(void)keyboardWillHide:(NSNotification *)note{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame =  _bottomBar.frame;
        frame.origin.y =  _backBottonBarY;
        _bottomBar.frame = frame;
    }];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除观察者
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 返回登录注册页面
- (IBAction)backLogRegPage:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 登录
- (IBAction)Logon:(UIButton *)sender {
    NSString* account = _account.text;
    NSString* password = _password.text;
    if (account.length == 0 || password.length == 0) {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"友情提示" message:@"账号或密码不能为空" delegate:nil cancelButtonTitle:@"重新输入" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        NSDictionary* parameters = @{
                                     @"name": account,
                                     @"password": password
                                     };
        
        [[AFAppDotNetAPIClient sharedClient]apiGet:LOGIN Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
            NSLog(@"%@", result_data);
        }];
    }
    
}

- (IBAction)endEdit:(UITextField *)sender {
    [_password resignFirstResponder];
    [_account resignFirstResponder];
}

#pragma mark 点击背景隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [_password resignFirstResponder];
    [_account resignFirstResponder];
}
@end
