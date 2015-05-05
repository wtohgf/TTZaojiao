//
//  TTDynamicReleaseViewController.m
//  TTzaojiao
//
//  Created by hegf on 15-5-4.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTDynamicReleaseViewController.h"
#import <RDVTabBarController.h>
#import "UIImage+MoreAttribute.h"
#import "WUDemoKeyboardBuilder.h"

@interface TTDynamicReleaseViewController()
{
    CGFloat _backBottonBarY;
    NSString* _picsPath;
    NSMutableArray* _images;
}
@end
@implementation TTDynamicReleaseViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"发布动态";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
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
    _images = [NSMutableArray array];
    _picsPath = @"";
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

-(void)imagePickerDidSelectImage:(UIImage *)image{
    image = [image scaleToSize:image size:CGSizeMake(100, 100)];
    [_images addObject:image];
    [_publichPicsView addPicImage:image];
}

-(void)cancel:(UIBarButtonItem*)item{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 发布动态
-(void)release:(UIBarButtonItem*)item{

    if (_textView.text.length == 0) {
        [[UIAlertView alloc]showAlert:@"评论内容不能为空" byTime:2.f];
        return;
    }
    
    [[TTCityMngTool sharedCityMngTool] startLocation:^(CLLocation *location) {
            _location = location;
        if(_images.count != 0){
            [self uploadPics];
        }else{
            [self publichState];
        }
    }];

}

-(void)uploadPics{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[AFAppDotNetAPIClient sharedClient]uploadImage:nil Images:_images Result:^(id result_data, ApiStatus result_status) {
        if ([result_data isKindOfClass:[NSMutableArray class]]) {
            NSMutableArray* list = (NSMutableArray*)result_data;
            if (list.count!=0) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                [list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    NSDictionary* dict = (NSDictionary*)obj;
                    NSString* msgkey = [NSString stringWithFormat:@"msg_%01ld", idx+1];
                    NSString* msgwordkey = [NSString stringWithFormat:@"msg_word_%01ld", idx+1];
                    if ([dict[msgkey] isEqualToString:@"Up_Ok"]) {
                        NSString* filePath = dict[msgwordkey];
                        _picsPath = [_picsPath stringByAppendingString:filePath];
                        _picsPath = [_picsPath stringByAppendingString:@"|"];
                    }else{
                        *stop = YES;
                    }
                }];
                [self publichState];
            }
        }
    } Progress:^(CGFloat progress) {
        _picsPath = @"";
        [[[UIAlertView alloc]init]showAlert:@"图片上传失败" byTime:3.0];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

-(void)publichState{
    /*
     latitude = MySPManager.getValue(PublishStateActivity.this,
     MySPManager.LATITUDE);
					longitude = MySPManager.getValue(PublishStateActivity.this,
     MySPManager.LONGITUDE);
					Date birDate = new SimpleDateFormat("yyyy-M-d")
     .parse(birthday);
					Date currentDate = new Date();
					long age = (currentDate.getTime() - birDate.getTime())
     / 1000 / 60 / 60 / 24 / 30;
					result = WebServer.requestByGet(WebServer.PUBLISH_STATE
     + "&i_uid=" + uid + "&i_psd=" + secondPassword
     + "&i_content=" + content + "&i_pic=" + picPath
     + "&i_x=" + latitude + "&i_y=" + longitude
     + "&i_sort=" + sort + "&i_type="
     + LessonNewFragment.activeID + "&i_month=" + age
     + "&i_item=" + group);
     */
    UserModel* user = [TTUserModelTool sharedUserModelTool].logonUser;
    NSString* lat = [NSString stringWithFormat:@"%.2f", _location.coordinate.latitude];
    NSString* lon = [NSString stringWithFormat:@"%.2f", _location.coordinate.longitude];
   
    NSDictionary* parameters = @{
                                 @"i_uid": user.ttid,
                                 @"i_psd": [TTUserModelTool sharedUserModelTool].password,
                                 @"i_content":[_textView.textStorage getPlainString],
                                 @"i_pic": _picsPath,
                                 @"i_x":lat,
                                 @"i_y":lon,
                                 @"i_sort":@"1",
                                 @"i_type":@"1",
                                 @"i_month":@"6",
                                 @"i_item":@"1",
                                 };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[AFAppDotNetAPIClient sharedClient]apiGet:PUBLISH_STATE Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (result_status == ApiStatusSuccess) {
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                if (((NSMutableArray*)result_data).count!=0) {
                    
                }
            }
        }else{
            if (result_status != ApiStatusNetworkNotReachable) {
                [[[UIAlertView alloc]init] showWithTitle:@"友情提示" message:@"服务器好像罢工了" cancelButtonTitle:@"重试一下"];
            }
        };
        
    }];
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
    if (self.textView.isFirstResponder) {
        if (self.textView.emoticonsKeyboard) [self.textView switchToDefaultKeyboard];
        else [self.textView switchToEmoticonsKeyboard:[WUDemoKeyboardBuilder sharedEmoticonsKeyboard]];
    }else{
        [self.textView switchToEmoticonsKeyboard:[WUDemoKeyboardBuilder sharedEmoticonsKeyboard]];
        [self.textView becomeFirstResponder];
    }
}

-(void)publichViewdidSelPic:(TTPublichView *)view{
    
    JSImagePickerViewController *imagePicker = [[JSImagePickerViewController alloc] init];
    imagePicker.delegate = self;
    [imagePicker showImagePickerInController:self animated:YES];
    
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
