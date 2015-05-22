//
//  TTWoIconModiyViewController.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/5/8.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoIconModiyViewController.h"
#import <RDVTabBarController.h>
#import "UIImage+MoreAttribute.h"
#import "UIImageView+MoreAttribute.h"
#import "TTPhotoChoiceAlerTool.h"

@interface TTWoIconModiyViewController () <TTPhotoChoiceAlerToolDelegate>
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
//    JSImagePickerViewController *imagePicker = [[JSImagePickerViewController alloc] init];
//    imagePicker.delegate = self;
//    [imagePicker showImagePickerInController:self animated:YES];
    [[TTPhotoChoiceAlerTool sharedPhotoChoiceAlerTool]photoPickerShowinView:self picCount:1];
    [TTPhotoChoiceAlerTool sharedPhotoChoiceAlerTool].delegate = self;
}


- (IBAction)modifyAction:(UIButton *)sender {
    if (_iconPath.length == 0) {
        [MBProgressHUD TTDelayHudWithMassage:@"请更新头像" View:self.navigationController.view];
        return;
    }
    [[AFAppDotNetAPIClient sharedClient] apiGet:UPDATE_ICON
                                     Parameters:@{@"i_uid":[[[TTUserModelTool sharedUserModelTool] logonUser] ttid],
                                                  @"i_psd":[[TTUserModelTool sharedUserModelTool] password],
                                                  @"icon":_iconPath}
                                         Result:^(id result_data, ApiStatus result_status, NSString *api) {
                                             if (result_status == ApiStatusSuccess) {
                                                 [[[TTUserModelTool sharedUserModelTool] logonUser] setIcon:_iconPath];
                                                 [_iconImageView setImageIcon:_iconPath];
                                                 UIImageView* rightIconView =(UIImageView*)self.navigationItem.rightBarButtonItem.customView;
                                                 [rightIconView setImageIcon:_iconPath];
                                                 [MBProgressHUD TTDelayHudWithMassage: @"更新成功！" View:self.navigationController.view];
                                             }
                                             else {
            [MBProgressHUD TTDelayHudWithMassage:@"网络连接有问题 请检查网络" View:self.navigationController.view];
                                             }
                                         }];
}


-(void)didSelectedPhotos:(NSArray *)photos{
    if (photos != nil && photos.count > 0) {
        UIImage * image = [photos firstObject];
        image = [image scaleToSize:image size:CGSizeMake(100, 100)];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_iconImageView setImage:image];
        });
        
        NSMutableArray* images = [NSMutableArray array];
            [images addObject:image];
            [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            [[AFAppDotNetAPIClient sharedClient]uploadImage:nil Images:images Result:^(id result_data, ApiStatus result_status) {
                [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
                if (result_status == ApiStatusSuccess) {
                    if ([result_data isKindOfClass:[NSMutableArray class]]) {
                        if (((NSMutableArray*)result_data).count!=0) {
                            NSDictionary* dict = (NSDictionary*)result_data[0];
                            if ([dict[@"msg_1"] isEqualToString:@"Up_Ok"]) {
                                NSString* filePath = dict[@"msg_word_1"];
                                _iconPath = filePath;
                            }else{
                                _iconPath = @"";
                            }
                        }
                    }
                }else{
                    [MBProgressHUD TTDelayHudWithMassage:@"网络连接错误 请检查网络" View:self.navigationController.view];
                }

            } Progress:^(CGFloat progress) {
            }];
    }
}

@end
