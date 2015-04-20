//
//  TTRealRegisitViewController.m
//  TTzaojiao
//
//  Created by hegf on 15-4-18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTRealRegisitViewController.h"
#import <AFHTTPSessionManager.h>
#import "UIImage+MoreAttribute.h"

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
    UIAlertController* ac = [UIAlertController alertControllerWithTitle:@"请选择宝宝性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    ac.view.backgroundColor = [UIColor whiteColor];
    
    UIAlertAction* male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

    }];
    [ac addAction:male];
    UIAlertAction* female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        ;
    }];
    [ac addAction:female];
    
    [self presentViewController:ac animated:YES completion:nil];
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
    image = [image scaleToSize:image size:CGSizeMake(100, 100)];
    [_icon setImage:image forState:UIControlStateNormal];
    
    NSMutableArray* images = [NSMutableArray array];
    [images addObject:image];
    [[AFAppDotNetAPIClient sharedClient]uploadImage:nil Images:images Result:^(id result_data, ApiStatus result_status) {
        if ([result_data isKindOfClass:[NSMutableArray class]]) {
            if (((NSMutableArray*)result_data).count!=0) {
                NSDictionary* dict = (NSDictionary*)result_data[0];
                if ([dict[@"msg_1"] isEqualToString:@"Up_Ok"]) {
                    NSString* filePath = dict[@"msg_word_1"];
                    NSLog(@"%@",filePath);
                }
            }
        }
    } Progress:^(CGFloat progress) {
        NSLog(@"failure");
    }];
}

#pragma mark 更改生日
- (IBAction)changBirthDay:(UIButton *)sender {
    
    UIAlertController* ac = [UIAlertController alertControllerWithTitle:@"请选择宝宝类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    ac.view.backgroundColor = [UIColor whiteColor];

    
    UIAlertAction* ownBaby = [UIAlertAction actionWithTitle:@"已有宝宝" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            HSDatePickerViewController* dateVC = [[HSDatePickerViewController alloc]init];
            [self presentViewController:dateVC animated:YES completion:^{
                ;
            }];
    }];
    [ac addAction:ownBaby];
    UIAlertAction* yunBaby = [UIAlertAction actionWithTitle:@"孕期宝宝" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        ;
    }];
    [ac addAction:yunBaby];
    UIAlertAction* futureBaby = [UIAlertAction actionWithTitle:@"未来宝宝" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        ;
    }];
    [ac addAction:futureBaby];

    [self presentViewController:ac animated:YES completion:nil];

}

#pragma mark 注册
- (IBAction)regist:(UIButton *)sender {
    
    
    
//    NSDictionary* parameters = @{
//                                 @"phone": ,
//                                 @"password":,
//                                 @"gender":,
//                                 @"birthday": ,
//                                 @"city":,
//                                 @"name":,
//                                 @"icon": ,
//                                 @"type":,
//                                 };
//    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [[AFAppDotNetAPIClient sharedClient]apiGet:REGISTER_SECOND_STEP Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        if (result_status == ApiStatusSuccess) {
//            if ([result_data isKindOfClass:[NSMutableArray class]]) {
//                if (((NSMutableArray*)result_data).count!=0) {
//                    RegMsgFirst* msgFirst = (RegMsgFirst*)result_data[0];
//                }
//            }
//        }else{
//            if (result_status != ApiStatusNetworkNotReachable) {
//                [[[UIAlertView alloc]init] showWithTitle:@"友情提示" message:@"服务器好像罢工了" cancelButtonTitle:@"重试一下"];
//            }
//        };
//        
//    }];

}
@end
