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
    if (_sort == nil) {
        _sort = @"1";
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

}

-(void)addPublichPicsView{
    TTPublichPicsView* publichPicsView = [[TTPublichPicsView alloc]init];
    publichPicsView.frame = CGRectMake(0, _textView.bottom, self.view.width, kBoder*2+(kScreenWidth*kPicWRatio+kMargin)*3);
    [self.view addSubview:publichPicsView];
    _publichPicsView = publichPicsView;
    
}

-(void)imagePickerDidSelectImage:(UIImage *)image{
    CGSize size;
    if (image.size.width >= image.size.height) {
        size = (CGSize){100.f*image.size.width/image.size.height, 100.f};
    }else{
        size = (CGSize){100.f, 100.f*image.size.height/image.size.width};
    }
    
    image = [image scaleToSize:image size:size];
    
    CGFloat step = 0.25;
    CGFloat orignal = 1.0;
    NSData* imageData = UIImageJPEGRepresentation(image, orignal);
    while (imageData.length > 1024*528) {
        orignal = orignal - step;
        imageData = UIImageJPEGRepresentation(image, orignal);
    }
    
    image = [UIImage imageWithData:imageData];
    [_images addObject:image];
    [_publichPicsView addPicImage:image];
}

-(void)cancel:(UIBarButtonItem*)item{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 发布动态
-(void)release:(UIBarButtonItem*)item{

    if (_textView.text.length == 0) {
        [MBProgressHUD TTDelayHudWithMassage:@"评论内容不能为空" View:self.navigationController.view];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [[TTCityMngTool sharedCityMngTool] startLocation:^(CLLocation *location, NSError *error) {
        if (location != nil) {
            _location = location;
        }else{
            _location = nil;
        }
        if(_images.count != 0){
            [self uploadPics];
        }else{
            [self publichState];
        }
    } View:self.navigationController.view];

}

-(void)uploadPics{
    
    [[AFAppDotNetAPIClient sharedClient]uploadImage:nil Images:_images Result:^(id result_data, ApiStatus result_status) {
        if ([result_data isKindOfClass:[NSMutableArray class]]) {
            NSMutableArray* list = (NSMutableArray*)result_data;
            if (list.count!=0) {
                
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
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        [MBProgressHUD TTDelayHudWithMassage:@"图片上传失败" View:self.navigationController.view];
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
    
    NSString* lat = @"0";
    NSString* lon = @"0";
    if (_location != nil) {
        lat = [NSString stringWithFormat:@"%.2f", _location.coordinate.latitude];
        lon = [NSString stringWithFormat:@"%.2f", _location.coordinate.longitude];
    }

    NSDictionary* parameters = @{
                                 @"i_uid": user.ttid,
                                 @"i_psd": [TTUserModelTool sharedUserModelTool].password,
                                 @"i_content":[_textView.textStorage getPlainString],
                                 @"i_pic": _picsPath,
                                 @"i_x":lat,
                                 @"i_y":lon,
                                 @"i_sort":_sort,
                                 @"i_type":((_activeID == nil)?@"1":_activeID),
                                 @"i_month":[TTUserModelTool sharedUserModelTool].mouth,
                                 @"i_item":[TTUserModelTool sharedUserModelTool].group,
                                 };
    
    [[AFAppDotNetAPIClient sharedClient]apiGet:PUBLISH_STATE Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        
        if (result_status == ApiStatusSuccess) {
            [MBProgressHUD TTDelayHudWithMassage:@"发布成功" View:self.navigationController.view];
            [TTUIChangeTool sharedTTUIChangeTool].isneedUpdateUI = YES;
            [TTUIChangeTool sharedTTUIChangeTool].sort = _sort;
            [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(cancel:) userInfo:nil repeats:NO];
            
        }else{
            [MBProgressHUD TTDelayHudWithMassage:@"网络连接错误，请检查网络" View:self.navigationController.view];
        };
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    [self addKeyNotification];
    [_textView becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除观察者
}

-(void)publichViewdidPublicTo:(TTPublichView *)view{
    UIAlertController* ac = [UIAlertController alertControllerWithTitle:@"请选择发布到:" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    ac.view.backgroundColor = [UIColor whiteColor];
    
    UIAlertAction* action1 = [UIAlertAction actionWithTitle:@"早教自拍" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        _sort = @"1";
    }];
    [ac addAction:action1];
    UIAlertAction* action2 = [UIAlertAction actionWithTitle:@"课程提问" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        ;
         _sort = @"2";
    }];
    [ac addAction:action2];
    UIAlertAction* action3 = [UIAlertAction actionWithTitle:@"宝宝生活" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        ;
        _sort = @"3";
    }];
    [ac addAction:action3];
    [self presentViewController:ac animated:YES completion:nil];
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
