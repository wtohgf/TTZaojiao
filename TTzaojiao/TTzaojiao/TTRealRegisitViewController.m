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
//@property (weak, nonatomic) HSDatePickerViewController* dateVC;

@property (copy, nonatomic) NSString* genderType; //0 男 1 女
@property (copy, nonatomic) NSString* birthdayString; //1970-01-01
@property (copy, nonatomic) NSString* cityCode; //110000
@property (copy, nonatomic) NSString* iconPath;
@property (copy, nonatomic) NSString* name;
@property (copy, nonatomic) NSString* type; //0已有宝宝 1孕期宝宝 2未来宝宝

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
    
    [self initAllParameters];
}


- (void)initAllParameters{
    _genderType= @"0";
    _birthdayString = @"";
    
    _cityCode= @"210200";
    NSString* cityName = [[TTCityMngTool sharedCityMngTool]codetoCity:_cityCode];
    NSString* provence = [[TTCityMngTool sharedCityMngTool]provinceofCity:cityName];
    _location.text = [NSString stringWithFormat:@"%@ %@",provence, cityName];
    
    _babyName.text= @"";
    _iconPath= @"";
    _type= @"";
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除观察者
}

#pragma mark 添加低栏
-(void)addBottomBar{
    CGFloat h = kBottomBarHeight;
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
    [_babyName resignFirstResponder];
    
    UIAlertController* ac = [UIAlertController alertControllerWithTitle:@"请选择宝宝性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    ac.view.backgroundColor = [UIColor whiteColor];
    
    UIAlertAction* male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        _genderType = @"0";
        _gental.text = @"男";
    }];
    [ac addAction:male];
    UIAlertAction* female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        ;
        _genderType = @"1";
        _gental.text = @"女";
    }];
    [ac addAction:female];
    
    [self presentViewController:ac animated:YES completion:nil];
}

#pragma mark 更改位置
- (IBAction)changLocation:(UIButton *)sender {
    [_babyName resignFirstResponder];
    
    TSLocateView *locateView = [[[NSBundle mainBundle] loadNibNamed:@"TSLocateView" owner:self options:nil] objectAtIndex:0];
    locateView.titleLabel.text = @"定位城市";
    locateView.delegate = self;
    //[[TSLocateView alloc] initWithTitle:@"定位城市" delegate:self];
    [locateView showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([actionSheet isKindOfClass:[TSLocateView class]]) {
        TSLocateView *locateView = (TSLocateView *)actionSheet;
        TSLocation *location = locateView.locate;
        NSLog(@"provice%@ city:%@", location.state, location.city);
        //You can uses location to your application.
        
        if(buttonIndex == 0) {
            _cityCode = @"";
        }else {
            NSString* cityName = [NSString stringWithFormat:@"%@市", location.city];
            _cityCode = [[TTCityMngTool sharedCityMngTool]citytoCode:cityName];
            NSLog(@"code %@", _cityCode);
            NSString* cityString = [NSString stringWithFormat:@"%@ %@",location.state, location.city];
            [_location setText:cityString];
        }

    }else if([actionSheet isKindOfClass:[CustomDatePicker class]]){
        CustomDatePicker *datePickerView = (CustomDatePicker *)actionSheet;
        
        if(buttonIndex == 0) {
            _birthdayString = @"";
        }else {
            NSDate* date = datePickerView.datePicker.date;
            NSDateFormatter* formater = [[NSDateFormatter alloc]init];
            [formater setDateFormat:@"yyyy-MM-dd"];
            _birthdayString = [formater stringFromDate:date];
            [_birthDay setText:_birthdayString];
        }
    }
 }

#pragma mark 更改头像
- (IBAction)changIcon:(UIButton *)sender {
    [_babyName resignFirstResponder];
    JSImagePickerViewController *imagePicker = [[JSImagePickerViewController alloc] init];
    imagePicker.delegate = self;
    [imagePicker showImagePickerInController:self animated:YES];
    
}

-(void)imagePickerDidSelectImage:(UIImage *)image{
    image = [image scaleToSize:image size:CGSizeMake(100, 100)];
    
    NSMutableArray* images = [NSMutableArray array];
    [images addObject:image];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[AFAppDotNetAPIClient sharedClient]uploadImage:nil Images:images Result:^(id result_data, ApiStatus result_status) {
        if ([result_data isKindOfClass:[NSMutableArray class]]) {
            if (((NSMutableArray*)result_data).count!=0) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                NSDictionary* dict = (NSDictionary*)result_data[0];
                if ([dict[@"msg_1"] isEqualToString:@"Up_Ok"]) {
                    NSString* filePath = dict[@"msg_word_1"];
                    _iconPath = filePath;
                    [_icon setImage:image forState:UIControlStateNormal];
                }else{
                    _iconPath = @"";
                }
            }
        }
    } Progress:^(CGFloat progress) {
        _iconPath = @"";
        [[[UIAlertView alloc]init]showAlert:@"图片设置失败" byTime:3.0];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

#pragma mark 更改生日
- (IBAction)changBirthDay:(UIButton *)sender {
    [_babyName resignFirstResponder];
    UIAlertController* ac = [UIAlertController alertControllerWithTitle:@"请选择宝宝类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    ac.view.backgroundColor = [UIColor whiteColor];
    
    UIAlertAction* ownBaby = [UIAlertAction actionWithTitle:@"已有宝宝" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        _type = @"0";
        CustomDatePicker* cdate = [[CustomDatePicker alloc]init];
        cdate.frame = CGRectMake(0, self.view.frame.size.height*2/3, self.view.frame.size.width, self.view.frame.size.height*1/3);
        cdate = [cdate initWithTitle:@"给宝宝选择生日" delegate:self];
        [cdate showInView:self.view];
        NSDateFormatter* formater = [[NSDateFormatter alloc]init];
        [formater setDateFormat:@"yyyy-MM-dd"];
        cdate.datePicker.minimumDate = [formater dateFromString:@"1970-01-01"];
        cdate.datePicker.maximumDate = [NSDate date];
    }];
    [ac addAction:ownBaby];
    UIAlertAction* yunBaby = [UIAlertAction actionWithTitle:@"孕期宝宝" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        ;
        _type = @"1";
        _birthdayString = @"1970-01-01";
    }];
    [ac addAction:yunBaby];
    UIAlertAction* futureBaby = [UIAlertAction actionWithTitle:@"未来宝宝" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        ;
        _type = @"2";
        _birthdayString = @"1970-01-01";
    }];
    [ac addAction:futureBaby];

    [self presentViewController:ac animated:YES completion:nil];

}

#pragma mark 注册
- (IBAction)regist:(UIButton *)sender {
    
    if (_iconPath.length == 0) {
        [[[UIAlertView alloc]init]showAlert:@"请设置宝宝头像" byTime:2.0];
        return;
    }
    if (_genderType.length == 0){
        [[[UIAlertView alloc]init]showAlert:@"请选择性别" byTime:2.0];
        return;
    }
    if (_birthdayString.length == 0){
        [[[UIAlertView alloc]init]showAlert:@"请选择生日" byTime:2.0];
        return;
    }
    if (_babyName.text.length == 0) {
        [[[UIAlertView alloc]init]showAlert:@"请填写宝宝姓名" byTime:2.0];
        return;
    }
    
    NSDictionary* parameters = @{
                                 @"phone": _phoneNum,
                                 @"password": _password,
                                 @"gender": _genderType,
                                 @"birthday": _birthdayString,
                                 @"city":_cityCode,
                                 @"name":_babyName.text,
                                 @"icon": _iconPath,
                                 @"type":_type,
                                 };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[AFAppDotNetAPIClient sharedClient]apiGet:REGISTER_SECOND_STEP Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (result_status == ApiStatusSuccess) {
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                if (((NSMutableArray*)result_data).count!=0) {
                    RegMsgSecond* msgSecond = (RegMsgSecond*)result_data[0];
                    if ([msgSecond.msg isEqualToString:@"Get_Reg_2"]) {
                        NSLog(@"注册成功");
                    }else{
                        [[[UIAlertView alloc]init]showAlert:msgSecond.msg_word byTime:3.0];
                    }
                }
            }
        }else{
            if (result_status != ApiStatusNetworkNotReachable) {
                [[[UIAlertView alloc]init] showWithTitle:@"友情提示" message:@"服务器好像罢工了" cancelButtonTitle:@"重试一下"];
            }
        };
        
    }];

}
@end
