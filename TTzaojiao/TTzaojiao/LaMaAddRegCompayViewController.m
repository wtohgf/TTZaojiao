//
//  LaMaAddRegCompayViewController.m
//  TTzaojiao
//
//  Created by dalianembeded on 15/5/10.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "LaMaAddRegCompayViewController.h"
#import "TTUserDongtaiViewController.h"
#import "MBProgressHUD+TTHud.h"
@implementation LaMaAddRegCompayViewController
#pragma mark 显示个人信息
- (UIImage *) loadWebImage
{
    UIImage* image=nil;
    NSString *url = [NSString stringWithFormat:@"%@%@",TTBASE_URL,[[[TTUserModelTool sharedUserModelTool] logonUser] icon]];
    
    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];//获取网咯图片数据
    if(data!=nil)
    {
        image = [[UIImage alloc] initWithData:data];//根据图片数据流构造image
    }
    return image;
}
#pragma mark 入驻申请布局
- (void)viewDidLoad
{
    //NSLog(@"reg");
    self.navigationItem.title = @"申请入驻辣妈街";
    
    //right
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[self loadWebImage] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBtnClick:)
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem= right;
    
    //content
    _compayNameTextField = [self settingItemWith:@"商家名称" andNameTextField:@"请输入商家名称" andPos:CGRectMake(0,64,[UIScreen mainScreen].bounds.size.width,40) andTag:1];
     _contactNameField = [self settingItemWith:@"联系人" andNameTextField:@"请输入联系人姓名" andPos:CGRectMake(0,64+40,[UIScreen mainScreen].bounds.size.width,40) andTag:2];
     _telField = [self settingItemWith:@"联系电话" andNameTextField:@"请输入联系人电话" andPos:CGRectMake(0,64+40+40,[UIScreen mainScreen].bounds.size.width,40) andTag:3];
    _telField.keyboardType =  UIKeyboardTypeNumbersAndPunctuation;
   
    UIButton *regBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 64+40+40+40+10, [UIScreen mainScreen].bounds.size.width-40, 40) ];
    [self.view addSubview:regBtn];
    [regBtn setTitle:@"提交入驻申请" forState:UIControlStateNormal];
    regBtn.titleLabel.textColor = [UIColor whiteColor];
    regBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [regBtn setBackgroundColor:[UIColor colorWithRed:252/255.0 green:33/255.0 blue:94/255.0 alpha:1.0]];
    [regBtn addTarget:self action:@selector(regBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];

    
}

#pragma mark 文本代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark 提交注册信息
- (void) regBtnClick:(UIButton*)btn
{
      //NSLog(@"btn click");
    if (_compayNameTextField.text.length == 0) {
        //NSLog(@"请输入商家名称");
        //[self createLabelWith:@"请输入商家名称"];
         [MBProgressHUD TTDelayHudWithMassage:@"请输入商家名称" View:self.navigationController.view];
    }
    else if(_contactNameField.text.length == 0)
    {
         //NSLog(@"请输入联系人姓名");
        //[self createLabelWith:@"请输入联系人姓名"];
         [MBProgressHUD TTDelayHudWithMassage:@"请输入联系人姓名" View:self.navigationController.view];
    }
    else if(_telField.text.length == 0)
    {
        //NSLog(@"请输入联系电话");
        //[self createLabelWith:@"请输入联系电话"];
        [MBProgressHUD TTDelayHudWithMassage:@"请输入联系电话" View:self.navigationController.view];
    }
    else
    {
        //NSLog(@"记录了");
        [self createLabelWith:@"提交成功等待我们与您联系"];
        NSDictionary* parameters = @{
                                     @"i_id":@"test",
                                     @"i_psd":[TTUserModelTool sharedUserModelTool].password,
                                               @"i_company":_compayNameTextField.text,
                                               @"i_name":_contactNameField.text,
                                               @"i_tel":_telField.text
                                     };
        [[AFAppDotNetAPIClient sharedClient]apiGet:ADD_REG_COMPAY Parameters:parameters  Result:^(id result_data, ApiStatus result_status, NSString *api) {
        }
];
    }
}

#pragma mark 创建复用的label
-(void) createLabelWith:(NSString*)title
{
    CGRect screen = [UIScreen mainScreen].bounds;
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(screen.size.width/2-125, screen.size.height-100, 250, 40)];
    [self.view addSubview:label];
    
    label.text = title;
    label.backgroundColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.alpha = 0;
    
    [UIView animateWithDuration:1.0 animations:^{
        label.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
        
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark 键盘通知处理函数
- (void) keyboardChange:(NSNotification*)notification
{
    //NSLog(@"keyboard change");
    
    CGRect end =  [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat time = [notification.userInfo[ UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // CGRect begin =  [notification.userInfo[UIKeyboardFrameBeginUserInfoKey]CGRectValue];
    
    [UIView animateWithDuration:time animations:^{
        self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, end.origin.y- [UIScreen mainScreen].bounds.size.height) ;
    }];
}

#pragma mark 显示个人信息的处理
- (void) rightBtnClick:(UIBarButtonItem*)btn
{
    
    UIStoryboard *storyBoardDongTai=[UIStoryboard storyboardWithName:@"DongTaiStoryboard" bundle:nil];
    TTUserDongtaiViewController *userViewController = (TTUserDongtaiViewController *)[storyBoardDongTai instantiateViewControllerWithIdentifier:@"UserUIM"];
    [userViewController setI_uid:[[[TTUserModelTool sharedUserModelTool] logonUser] ttid]];
    [self.navigationController pushViewController:userViewController animated:YES];
    //导航
}

#pragma mark 创建复用文本框
- (UITextField*) settingItemWith:(NSString*)title andNameTextField:(NSString*)name andPos:(CGRect)pos andTag:(int)tag
{
    UIView * view1 = [[UIView alloc]initWithFrame:pos];
    [self.view addSubview:view1];
    //[view1 setBackgroundColor:[UIColor greenColor]];
    
    UIView *separateView = [[UIView alloc]initWithFrame:CGRectMake(0, pos.size.height-1, pos.size.width, 1)];
    [view1 addSubview:separateView];
    [separateView setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0]];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 20)];
    titleLabel.textAlignment = NSTextAlignmentNatural;
    [view1 addSubview:titleLabel];
    titleLabel.text = title;

    UITextField *nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(120, 10, pos.size.width-120, 20)];
    [view1 addSubview:nameTextField];
    nameTextField.placeholder = name;
    //nameTextField.tag = tag;
    nameTextField.delegate = self;
    return  nameTextField;
}



@end
