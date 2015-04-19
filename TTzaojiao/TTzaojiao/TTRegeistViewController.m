//
//  TTRegeistTableViewController.m
//  TTzaojiao
//
//  Created by hegf on 15-4-18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTRegeistViewController.h"

@interface TTRegeistViewController ()
{
    CGFloat _backBottonBarY;
}
@property (strong, nonatomic) IBOutlet UIView *bottomBar;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *firstPassword;
@property (weak, nonatomic) IBOutlet UITextField *sencondPassword;

@end

@implementation TTRegeistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"注册";
    //添加低栏
    [self addBottomBar];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    //首次进入不隐藏 Bug？
    //self.navigationController.navigationBarHidden = NO;
    //注册键盘通知
    [self addKeyNotification];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除观察者
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
    
    [self.view bringSubviewToFront:_bottomBar];
    
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

//点击背景键盘消失
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_phoneNumber resignFirstResponder];
    [_firstPassword resignFirstResponder];
    [_sencondPassword resignFirstResponder];
}

//返回上一页
- (IBAction)backPage:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 下一步
- (IBAction)nextStep:(UIButton *)sender {
    
    //对手机号合理性判断
    if (_phoneNumber.text.length != 11 || ![_phoneNumber.text hasPrefix:@"1"]) {
        [[[UIAlertView alloc]init]showAlert:@"您输入的手机号无效" byTime:kALertTiem];
        _phoneNumber.text = @"";
        return;
    }
    //对密码长度进行判断
    if (_firstPassword.text.length < 6 || _firstPassword.text.length>14) {
        [[[UIAlertView alloc]init]showAlert:@"请您输入6~14位密码" byTime:kALertTiem];
        _firstPassword.text = @"";
        return;
    }
    
    //对确认密码和首次密码一致性判断
    if (![_sencondPassword.text isEqualToString:_firstPassword.text]) {
        [[[UIAlertView alloc]init]showAlert:@"两次密码不一致" byTime:kALertTiem];
        _sencondPassword.text = @"";
        return;
    }
    
    //验证用户是否已注册
    
    
    [self performSegueWithIdentifier:@"nextStep" sender:nil];

}

#pragma mark 点击retrun，隐藏键盘
- (IBAction)editEnd:(UITextField *)sender {
    [sender resignFirstResponder];
}


@end
