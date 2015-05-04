//
//  TTDynamicReleaseViewController.m
//  TTzaojiao
//
//  Created by hegf on 15-5-4.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTDynamicReleaseViewController.h"
#import <RDVTabBarController.h>
@interface TTDynamicReleaseViewController()
{
    CGFloat _backBottonBarY;
}
@end
@implementation TTDynamicReleaseViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"发布动态";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(release:)];
    
    [self addSubTextView];
    [self addPublichPicsView];
    [self addBottomBar];
    
    if(([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars
        = NO;
        self.modalPresentationCapturesStatusBarAppearance
        = NO;
    }
}

-(void)addSubTextView{
    UITextView* textView = [[UITextView alloc]init];
    textView.frame = CGRectMake(0, 0, self.view.width, self.view.height*1/4);
    textView.font = [UIFont systemFontOfSize:16];
    
    textView.layer.cornerRadius = 4.0f;
    textView.layer.borderWidth= 1.0f;
    textView.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    [self.view addSubview:textView];
    [_textView becomeFirstResponder];
    _textView = textView;
    _textView.delegate = self;
}


-(void)textViewDidChange:(UITextView *)textView
{
    
}


-(void)addPublichPicsView{
    TTPublichPicsView* publichPicsView = [[TTPublichPicsView alloc]init];
    publichPicsView.frame = CGRectMake(0, _textView.bottom, self.view.width, kBoder*2+(kScreenWidth*kPicWRatio+kMargin)*3);
    [self.view addSubview:publichPicsView];
    _publichPicsView = publichPicsView;
}

-(void)cancel:(UIBarButtonItem*)item{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)release:(UIBarButtonItem*)item{
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    [self addKeyNotification];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除观察者
}

-(void)publichViewdidPublicTo:(TTPublichView *)view{
    
}

-(void)publichViewdidSelBiaoqing:(TTPublichView *)view{
    
}

-(void)publichViewdidSelPic:(TTPublichView *)view{
    [_publichPicsView addPic:@"baby_icon1"];
    [_textView resignFirstResponder];
}

#pragma mark 添加低栏
-(void)addBottomBar{

    CGFloat h = [UIScreen mainScreen].bounds.size.height*44.f/600.f;
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat y = [UIScreen mainScreen].bounds.size.height - self.navigationController.navigationBar.height -[UIApplication sharedApplication].statusBarFrame.size.height - h;
    CGFloat x = 0;
    CGRect publicFrame = CGRectMake(x, y, w, h);
    _backBottonBarY = y;
    
    TTPublichView* publichView = [[TTPublichView alloc]initWithFrame:publicFrame];
    _bottomBar = publichView;
    
    publichView.delegate = self;
    
    [self.view addSubview:_bottomBar];
    [self.view bringSubviewToFront:_bottomBar];
    
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
    [_textView resignFirstResponder];
}

//键盘点击return自动消失


@end
