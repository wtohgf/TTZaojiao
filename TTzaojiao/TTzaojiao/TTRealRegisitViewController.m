//
//  TTRealRegisitViewController.m
//  TTzaojiao
//
//  Created by hegf on 15-4-18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTRealRegisitViewController.h"


@interface TTRealRegisitViewController ()
{
    CGFloat _backBottonBarY;

}
@property (strong, nonatomic) IBOutlet UIView *bottomBar;
@property (weak, nonatomic) IBOutlet UIButton *icon;
@property (weak, nonatomic) IBOutlet UITextField *babyName;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *gental;
@property (weak, nonatomic) IBOutlet UILabel *birthDay;

- (IBAction)changGental:(UIButton *)sender;
- (IBAction)changLocation:(UIButton *)sender;
- (IBAction)changIcon:(UIButton *)sender;
- (IBAction)changBirthDay:(UIButton *)sender;
- (IBAction)regist:(UIButton *)sender;

@end

@implementation TTRealRegisitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"注册信息";
    //添加低栏
    [self addBottomBar];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//返回上一页
- (IBAction)backPage:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
    [_babyName resignFirstResponder];

}

//键盘点击return自动消失
- (IBAction)endEdit:(UITextField *)sender {
    [_babyName resignFirstResponder];
}

#pragma mark 更改性别
- (IBAction)changGental:(UIButton *)sender {
}

#pragma mark 更改位置
- (IBAction)changLocation:(UIButton *)sender {
    TSLocateView *locateView = [[TSLocateView alloc] initWithTitle:@"定位城市" delegate:self];
    [locateView showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    TSLocateView *locateView = (TSLocateView *)actionSheet;
    TSLocation *location = locateView.locate;
    NSLog(@"city:%@ lat:%f lon:%f", location.city, location.latitude, location.longitude);
    //You can uses location to your application.
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        NSLog(@"Select");
    }
}

#pragma mark 更改头像
- (IBAction)changIcon:(UIButton *)sender {
    JSImagePickerViewController *imagePicker = [[JSImagePickerViewController alloc] init];
    imagePicker.delegate = self;
    [imagePicker showImagePickerInController:self animated:YES];
    
}

-(void)imagePickerDidSelectImage:(UIImage *)image{
    [_icon setImage:image forState:UIControlStateNormal];
}


#pragma mark 更改生日
- (IBAction)changBirthDay:(UIButton *)sender {
    HSDatePickerViewController* dateVC = [[HSDatePickerViewController alloc]init];
    [self presentViewController:dateVC animated:YES completion:^{
        ;
    }];
}

#pragma mark 注册
- (IBAction)regist:(UIButton *)sender {
}
@end
