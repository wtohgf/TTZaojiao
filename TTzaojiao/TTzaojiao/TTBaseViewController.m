//
//  TTBaseViewController.m
//  TTzaojiao
//
//  Created by hegf on 15-4-17.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTBaseViewController.h"
#import "TTWoNavigtaionViewController.h"
#import "TTUserModelTool.h"
#import "TTUserDongtaiViewController.h"
#import "UIImageView+MoreAttribute.h"

@interface TTBaseViewController ()
@end

@implementation TTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    if ([self.navigationController isKindOfClass:[TTWoNavigtaionViewController class]]) {
        UIBarButtonItem* barItem;
        if ([TTUserModelTool sharedUserModelTool].logonUser.icon.length == 0) {
            UIImageView *imageView = [[UIImageView alloc]init];
            [imageView setImage:[UIImage imageNamed:@"baby_icon1"]];
            _rightItemIcon = imageView;
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightButtonItem:)];
            
            [imageView addGestureRecognizer:tap];
            imageView.frame = CGRectMake(0, 0, 30, 30);
            barItem = [[UIBarButtonItem alloc]initWithCustomView:imageView];

        }else{
            
            UIImageView *imageView = [[UIImageView alloc]init];
            [imageView setImageIcon:[TTUserModelTool sharedUserModelTool].logonUser.icon];
            _rightItemIcon = imageView;
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightButtonItem:)];
            
            [imageView addGestureRecognizer:tap];
            imageView.frame = CGRectMake(0, 0, 30, 30);
           barItem = [[UIBarButtonItem alloc]initWithCustomView:imageView];
        
        }
        
        self.navigationItem.rightBarButtonItem = barItem;
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([TTUserModelTool sharedUserModelTool].logonUser.icon.length == 0) {
        [_rightItemIcon setImage:[UIImage imageNamed:@"baby_icon1"]];
    }else{
        [_rightItemIcon setImageIcon:[TTUserModelTool sharedUserModelTool].logonUser.icon];
    }

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:NO];
}

- (void)rightButtonItem:(id)sender {
    UIStoryboard *storyBoardDongTai=[UIStoryboard storyboardWithName:@"DongTaiStoryboard" bundle:nil];
    TTUserDongtaiViewController *userViewController = (TTUserDongtaiViewController *)[storyBoardDongTai instantiateViewControllerWithIdentifier:@"UserUIM"];
    [userViewController setI_uid:[[[TTUserModelTool sharedUserModelTool] logonUser] ttid]];
    [self.navigationController pushViewController:userViewController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
