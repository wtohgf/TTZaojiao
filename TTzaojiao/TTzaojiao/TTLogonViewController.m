//
//  TTLogonViewController.m
//  TTzaojiao
//
//  Created by hegf on 15-4-17.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTLogonViewController.h"
#import "TTTabBarController.h"
#import "TTKeyChainTool.h"
#import "CustomBottomBar.h"

@interface TTLogonViewController ()
{
    CGFloat _backBottonBarY;
}

@property (strong, nonatomic) UIViewController *mainViewController;
@property (weak, nonatomic) IBOutlet UIButton *savePassworkCheckButton;
@property (weak, nonatomic) IBOutlet UIView *siganBottomBar;
//@property (weak, nonatomic) IBOutlet UIView *bottomBar;
@property (weak, nonatomic) CustomBottomBar* bottomBar;
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)savePasswordCheck:(UIButton *)sender;

@end

@implementation TTLogonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //默认用户名密码
    [self userRecord];
//    //添加低栏
    [self addBottomBar];
    
    //注册键盘通知
    [self addKeyNotification];
   
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self.view bringSubviewToFront:_bottomBar];
    [[self rdv_tabBarController]setTabBarHidden:YES];
    
}

#pragma mark 设置记住的用户名密码
-(void)userRecord {
//    _account.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"account"];
//    _password.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
//    if (![_password.text isEqualToString:@""]) {
//        _savePassworkCheckButton.selected = YES;
//    }
    
    NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[TTKeyChainTool load:KEY_USERNAME_PASSWORD];
    if (usernamepasswordKVPairs != nil) {
        _savePassworkCheckButton.selected = YES;
        _account.text = [usernamepasswordKVPairs objectForKey:KEY_USERNAME];;
        _password.text = [usernamepasswordKVPairs objectForKey:KEY_PASSWORD];
    }
}
#pragma mark 设置记住密码按钮
-(void)setupSavePassworkButton{
    [_savePassworkCheckButton setImage:[UIImage imageNamed:@"pic_unchecked"] forState:UIControlStateNormal];
    [_savePassworkCheckButton setImage:[UIImage imageNamed:@"pic_checked"] forState:UIControlStateSelected];
}
#pragma mark 添加低栏
-(void)addBottomBar{
    CGFloat h = kBottomBarHeight;
    CGFloat w = [UIApplication sharedApplication].keyWindow.frame.size.width;
    CGFloat y = [UIApplication sharedApplication].keyWindow.frame.size.height -  h;
    CGFloat x = 0;
    
    CustomBottomBar* bottomBar = [CustomBottomBar customBottomBarWithClickedBlock:^(NSString *title) {
        if ([title isEqualToString:@"返回"]) {
            [self backLogRegPage];
        }else{
            if ([title isEqualToString:@"登录"]) {
                [self Logon];
            }
        }
        
    }];
    NSArray* items;
    _bottomBar = bottomBar;
    if ([TTUserModelTool sharedUserModelTool].logonUser == nil) {
        items = @[@"返回", @"登录"];
    }else{
        if(![[TTUserModelTool sharedUserModelTool].logonUser.ttid isEqualToString:@"1977"]){
            items = @[@"登录"];
        }else{
            items = @[@"返回", @"登录"];
        }
    }
    
    bottomBar.items = items;
    _bottomBar.frame = CGRectMake(x, y, w, h);
    _backBottonBarY = y;
    [self.view addSubview:_bottomBar];
}
#pragma mark 注册键盘通知
-(void)addKeyNotification{
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

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除观察者
    [[self rdv_tabBarController]setTabBarHidden:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 返回登录注册页面
- (void)backLogRegPage{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 登录
- (void)Logon{
    
    
    NSString* account = _account.text;
    NSString* password = _password.text;
    if (account.length == 0 || password.length == 0) {
        [[[UIAlertView alloc]init] showWithTitle:@"友情提示" message:@"账号或密码不能为空" cancelButtonTitle:@"重新输入"];
    }else{
        NSDictionary* parameters = @{
                                     @"name": account,
                                     @"password": password
                                     };
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[AFAppDotNetAPIClient sharedClient]apiGet:LOGIN Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (result_status == ApiStatusSuccess) {
                
                    if ([result_data isKindOfClass:[NSMutableArray class]]) {
                        if (((NSMutableArray*)result_data).count != 0) {
                            UserModel* mode = [result_data firstObject];
                            if ([mode.msg isEqualToString:@"Err_Normal"]&& mode.msg_word!= nil) {
                                [MBProgressHUD TTDelayHudWithMassage:mode.msg_word View:self.view];
                            }else{
                                [self longonSucess:mode];
                            }
                        }else{
                            [MBProgressHUD TTDelayHudWithMassage:@"登录失败" View:self.view];
                        }
                        
                }
                
            }else{
                [MBProgressHUD TTDelayHudWithMassage:@"网络连接错误 请检查网络" View:self.navigationController.view];
            };
        }];
      
    }
    
}

-(void)longonSucess:(UserModel*) user{
    
    [TTUserModelTool sharedUserModelTool].logonUser = user;
    [TTUserModelTool sharedUserModelTool].password = user.id_c;
    [TTUserModelTool sharedUserModelTool].account = _account.text;

    //装载tabbar
    TTTabBarController *tabBarController = [[TTTabBarController alloc] init];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top_bg"] forBarMetrics:UIBarMetricsDefault];
    //                    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [UINavigationBar appearance].hidden = NO;
    
    self.mainViewController = tabBarController;
    
//    [self.navigationController pushViewController:_mainViewController animated:YES];
    [UIApplication sharedApplication].keyWindow.rootViewController = _mainViewController;
    
    //保存用户名和密码
    if(_savePassworkCheckButton.selected == YES)
    {
        
        NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
        [usernamepasswordKVPairs setObject:_account.text forKey:KEY_USERNAME];
        [usernamepasswordKVPairs setObject:_password.text forKey:KEY_PASSWORD];
        [TTKeyChainTool save:KEY_USERNAME_PASSWORD data:usernamepasswordKVPairs];
    }else{
        [TTKeyChainTool delete:KEY_USERNAME_PASSWORD];
    }

}

#pragma mark 记住密码
- (IBAction)savePasswordCheck:(UIButton *)sender {
    sender.selected = !sender.selected;
//    [[NSUserDefaults standardUserDefaults] setValue:_account.text forKey:@"account"];
//    [[NSUserDefaults standardUserDefaults] setValue:_password.text forKey:@"password"];
//    [[NSUserDefaults standardUserDefaults] synchronize];

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
