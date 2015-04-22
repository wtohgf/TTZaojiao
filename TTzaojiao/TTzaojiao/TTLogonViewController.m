//
//  TTLogonViewController.m
//  TTzaojiao
//
//  Created by hegf on 15-4-17.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTLogonViewController.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"

@interface TTLogonViewController ()
{
    CGFloat _backBottonBarY;
}

@property (strong, nonatomic) UIViewController *mainViewController;
@property (weak, nonatomic) IBOutlet UIButton *savePassworkCheckButton;
@property (weak, nonatomic) IBOutlet UIView *bottomBar;
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)backLogRegPage:(UIButton *)sender;
- (IBAction)Logon:(UIButton *)sender;
- (IBAction)savePasswordCheck:(UIButton *)sender;

@end

@implementation TTLogonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //默认用户名密码
    [self userRecord];
    //添加低栏
    [self addBottomBar];
    //注册键盘通知
    [self addKeyNotification];
    //装载tabbar
    [self setupViewControllers];
    
    _account.text = @"13381109915";
    _password.text = @"123456";
    
}

-(void)viewDidAppear:(BOOL)animated {
    [self.view bringSubviewToFront:_bottomBar];
}

#pragma mark 设置记住的用户名密码
-(void)userRecord {
    _account.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"account"];
    _password.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
    if (![_password.text isEqualToString:@""]) {
        _savePassworkCheckButton.selected = YES;
    }
}
#pragma mark 设置记住密码按钮
-(void)setupSavePassworkButton{
    [_savePassworkCheckButton setImage:[UIImage imageNamed:@"pic_unchecked"] forState:UIControlStateNormal];
    [_savePassworkCheckButton setImage:[UIImage imageNamed:@"pic_checked"] forState:UIControlStateSelected];
}
#pragma mark 添加低栏
-(void)addBottomBar{
    CGFloat h = self.view.frame.size.height*44/600;
    CGFloat w = self.view.frame.size.width;
    CGFloat y = self.view.frame.size.height -  h;
    CGFloat x = 0;
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
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

#pragma mark 登录
- (IBAction)Logon:(UIButton *)sender {
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
                    UserModel* user = result_data[0];
                    [TTUserModelTool sharedUserModelTool].logonUser = user;
                    NSLog(@"%@ %@", user.name, user.icon);
                    
                    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top_bg"] forBarMetrics:UIBarMetricsDefault];
                    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
                    [UINavigationBar appearance].hidden = NO;
                    [self.navigationController pushViewController:_mainViewController animated:YES];                    
                    //保存用户名和密码
                    if(_savePassworkCheckButton.selected == YES)
                    {
                        
                    }
                }
                
                
            }else{
                if (result_status != ApiStatusNetworkNotReachable) {
                    [[[UIAlertView alloc]init] showWithTitle:@"友情提示" message:@"服务器好像罢工了" cancelButtonTitle:@"重试一下"];
                }
            };
        }];
    }
}

#pragma mark 记住密码
- (IBAction)savePasswordCheck:(UIButton *)sender {
    sender.selected = !sender.selected;
    [[NSUserDefaults standardUserDefaults] setValue:_account.text forKey:@"account"];
    [[NSUserDefaults standardUserDefaults] setValue:_password.text forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];

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

#pragma mark Tabbar

- (void)setupViewControllers {
    UIStoryboard *storyBoardZaoJiao=[UIStoryboard storyboardWithName:@"ZaoJiaoStoryboard" bundle:nil];
    UIViewController *zaojiaoNavigationController = [storyBoardZaoJiao instantiateViewControllerWithIdentifier:@"ZaoJiaoNav"];
    
    UIStoryboard *storyBoardDongTai=[UIStoryboard storyboardWithName:@"DongTaiStoryboard" bundle:nil];
    UIViewController *dongtaiNavigationController = [storyBoardDongTai instantiateViewControllerWithIdentifier:@"DongTaiNav"];
    
    UIStoryboard *storyBoardLaMaJie=[UIStoryboard storyboardWithName:@"LaMaJieStoryboard" bundle:nil];
    UIViewController *lamajieNavigationController = [storyBoardLaMaJie instantiateViewControllerWithIdentifier:@"LaMaJieNav"];
    
    UIStoryboard *storyBoardWo=[UIStoryboard storyboardWithName:@"WoStoryboard" bundle:nil];
    UIViewController *woNavigationController = [storyBoardWo instantiateViewControllerWithIdentifier:@"WoNav"];

    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[zaojiaoNavigationController,
                                           dongtaiNavigationController,
                                           lamajieNavigationController,
                                           woNavigationController]];
    self.mainViewController = tabBarController;
    
    [self customizeTabBarForController:tabBarController];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"bottom_btn1", @"bottom_btn2", @"bottom_btn4", @"bottom_btn5"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_checked",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_unchecked",
                                                        [tabBarItemImages objectAtIndex:index]]];
        
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        item.unselectedTitleAttributes = @{
                                           NSFontAttributeName: [UIFont systemFontOfSize:12],
                                           NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                           };
        
        item.selectedTitleAttributes = @{
                                         NSFontAttributeName: [UIFont systemFontOfSize:12],
                                         NSForegroundColorAttributeName: [UIColor colorWithRed:181.f/255.f green:64.f/355.f blue:92.f/255.f alpha:1],
                                         };
        
        switch (index) {
            case 0:
            {
                [item setTitle:@"早教"];
            }
                break;
            case 1:
            {
                [item setTitle:@"动态"];
            }
                break;
            case 2:
            {
                [item setTitle:@"辣妈街"];
            }
                break;
            case 3:
            {
                [item setTitle:@"我"];
            }
                break;
                
            default:
                break;
        }
        
        index++;
    }
}

- (void)customizeInterface {
    //    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    //
    //    UIImage *backgroundImage = nil;
    //    NSDictionary *textAttributes = nil;
    //
    //    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
    //        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
    //
    //        textAttributes = @{
    //                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
    //                           NSForegroundColorAttributeName: [UIColor blackColor],
    //                           };
    //    } else {
    //#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    //        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
    //
    //        textAttributes = @{
    //                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
    //                           UITextAttributeTextColor: [UIColor blackColor],
    //                           UITextAttributeTextShadowColor: [UIColor clearColor],
    //                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
    //                           };
    //#endif
    //    }
    //
    //    [navigationBarAppearance setBackgroundImage:backgroundImage
    //                                  forBarMetrics:UIBarMetricsDefault];
    //    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}


@end
