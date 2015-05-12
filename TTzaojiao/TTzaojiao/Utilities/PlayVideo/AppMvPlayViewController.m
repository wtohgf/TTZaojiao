//
//  AppMvPlayViewController.m
//  APPMV
//
//  Created by mac on 15-3-4.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "AppMvPlayViewController.h"

@interface AppMvPlayViewController()

@property (strong, nonatomic) MPMoviePlayerViewController* moviePlayViewController;
@end

@implementation AppMvPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self startPlayViedo];
}

- (void)startPlayViedo{
    
    NSURL* playURL = [NSURL URLWithString:_playurl];
    if (_moviePlayViewController == nil) {
        MPMoviePlayerViewController*moviePlayViewController=
        [[MPMoviePlayerViewController alloc]initWithContentURL:playURL];
        _moviePlayViewController = moviePlayViewController;
    }else{
        [_moviePlayViewController.moviePlayer setContentURL:playURL];
    }

    [self.view addSubview:_moviePlayViewController.view];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didDoneClicked:) name:MPMoviePlayerPlaybackDidFinishNotification object:_moviePlayViewController.moviePlayer];
    
    [self presentMoviePlayerViewControllerAnimated:_moviePlayViewController];

}

- (void) stopPlayingVideo {
    
    if (_moviePlayViewController != nil){
        
        [[NSNotificationCenter defaultCenter]
         removeObserver:self
         name:MPMoviePlayerPlaybackDidFinishNotification
         object:_moviePlayViewController.moviePlayer];
        
        [_moviePlayViewController.moviePlayer stop];
        
        [_moviePlayViewController.view removeFromSuperview];
    }
    
}

- (void)didDoneClicked:(NSNotification*)notify{
    [self stopPlayingVideo];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self stopPlayingVideo];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
