//
//  TTWoIconModiyViewController.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/5/8.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoIconModiyViewController.h"
#import <RDVTabBarController.h>
#import "JSImagePickerViewController.h"
#import "UIImage+MoreAttribute.h"
#import "UIImageView+MoreAttribute.h"

@interface TTWoIconModiyViewController () <JSImagePickerViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *myIconButton;
@property (strong, nonatomic) IBOutlet UIButton *modIconButton;
@property (copy, nonatomic) NSString* iconPath;
@property (strong, nonatomic) IBOutlet UIImageView* iconImageView;
@end

@implementation TTWoIconModiyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _modIconButton.layer.borderWidth = 1;
    _modIconButton.layer.borderColor = (__bridge CGColorRef)([UIColor colorWithRed:0.710 green:0.251 blue:0.357 alpha:1.000]);
    _modIconButton.layer.cornerRadius = 20.f;
}

-(void)viewWillAppear:(BOOL)animated {
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    NSString *iconPath = [[[TTUserModelTool sharedUserModelTool] logonUser] icon];
    [_iconImageView setImageIcon:iconPath];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)iconAction:(UIButton *)sender {
    JSImagePickerViewController *imagePicker = [[JSImagePickerViewController alloc] init];
    imagePicker.delegate = self;
    [imagePicker showImagePickerInController:self animated:YES];
}

- (IBAction)modifyAction:(UIButton *)sender {
    [[AFAppDotNetAPIClient sharedClient] apiGet:UPDATE_ICON
                                     Parameters:@{@"i_uid":[[[TTUserModelTool sharedUserModelTool] logonUser] ttid],
                                                  @"i_psd":[[TTUserModelTool sharedUserModelTool] password],
                                                  @"icon":_iconPath}
                                         Result:^(id result_data, ApiStatus result_status, NSString *api) {
                                             if (result_status == ApiStatusSuccess) {
                                                 [[[TTUserModelTool sharedUserModelTool] logonUser] setIcon:_iconPath];
                                                 [MBProgressHUD TTDelayHudWithMassage: @"更新成功！" View:self.navigationController.view];
                                             }
                                             else {
                                                 [[[UIAlertView alloc] init] showWithTitle:@"友情提示" message:@"服务器好像罢工了" cancelButtonTitle:@"重试一下"];
                                             }
                                         }];
}

-(void)imagePickerDidSelectImage:(UIImage *)image{
    
    [_iconImageView setImage:image];
    
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

@end
