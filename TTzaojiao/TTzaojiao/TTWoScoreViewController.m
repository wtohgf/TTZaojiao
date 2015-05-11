//
//  TTWoScoreViewController.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/5/8.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoScoreViewController.h"
#import <RDVTabBarController.h>

@interface TTWoScoreViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *mWebView;

@end

@implementation TTWoScoreViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"jfsm" ofType:@"pdf"];
    NSURL *url = [NSURL URLWithString:path];
    [_mWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}


@end
