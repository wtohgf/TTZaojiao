//
//  TTZaojiaoPlayLessionController.m
//  TTzaojiao
//
//  Created by hegf on 15-5-11.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTZaojiaoPlayLessionController.h"
#import "TTDynamicReleaseViewController.h"
#import <MediaPlayer/MediaPlayer.h>

#define kSectionMargin 8.f

@interface TTZaojiaoPlayLessionController ()<UIAlertViewDelegate>
@property (weak, nonatomic) UITableView* zaoJiaoPlayTableView;
@property (copy, nonatomic) NSString* fullPath;
@end

@implementation TTZaojiaoPlayLessionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加导航自定义栏
    [self addNavItems];
    
    //添加TableView
    [self addTableView];
    
    //获取课程详细信息
    [self getDetailLessionInfo];
}


- (void)addNavItems{
    self.title = @"早教课堂";
}

-(void)addTableView{
    UITableView * tableView = [[UITableView alloc]init];
    _zaoJiaoPlayTableView = tableView;
    
    if(([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars
        = NO;
        self.modalPresentationCapturesStatusBarAppearance
        = NO;
    }
    
    CGFloat w=self.view.frame.size.width;
    CGFloat h=self.view.frame.size.height - self.tabBarController.tabBar.height - self.navigationController.navigationBar.height - [UIApplication sharedApplication].statusBarFrame.size.height;
    
    if(([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        tableView.frame = CGRectMake(0, 0, w, h-49.f);
    }else{
        tableView.frame = CGRectMake(0, 64.f, w, h-49.f);
    }
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    
    UIView* footView = [[UIView alloc]init];
    footView.frame = CGRectMake(0, 0, ScreenWidth, 44.f);
    footView.layer.cornerRadius = 8.f;
    
    UIButton* discussBtn = [[UIButton alloc]init];
    discussBtn.backgroundColor = [UIColor colorWithRed:39.f/255.f green:184.f/255.f blue:79.f/255.f alpha:1.f];

    discussBtn.frame = CGRectMake(TTBlogTableBorder, 0, ScreenWidth-2*TTBlogTableBorder, 44.f);
    
    [discussBtn setTitle:@"课堂互动" forState:UIControlStateNormal];
    [discussBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    discussBtn.layer.cornerRadius = 8.f;
    discussBtn.titleLabel.textColor = [UIColor whiteColor];
    [discussBtn addTarget:self action:@selector(lessionDiscuss:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:discussBtn];
    tableView.tableFooterView = footView;
    
    [self.view addSubview:tableView];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id cell = nil;
    if (indexPath.section == 0) {
        if (_lession != nil) {
            TTPlayLessionHeaderCell* tmpcell = [TTPlayLessionHeaderCell playLessionHeaderCellWithTableView:tableView];
            tmpcell.lession = _lession;
            tmpcell.delegate = self;
            cell = tmpcell;
        }else{
            UITableViewCell* tmpcell = [[UITableViewCell alloc]initWithFrame:CGRectZero];
            cell = tmpcell;
        }
    }else{
        if (_detailLession != nil) {
            TTPlayLessionIntroduceCell* tmpcell = [TTPlayLessionIntroduceCell playLessionIntroduceCellWithTableView:tableView];
            tmpcell.detailLession = _detailLession;
            cell = tmpcell;
        }else{
            UITableViewCell* tmpcell = [[UITableViewCell alloc]initWithFrame:CGRectZero];
            cell = tmpcell;
        }

    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [TTPlayLessionHeaderCell cellHeight];
    }else{
        return [TTPlayLessionIntroduceCell cellHeightWithModel:_detailLession];
    };
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
        UIView* view = [[UIView alloc]initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, kSectionMargin)];
        view.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
        return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return kSectionMargin;
}

-(void)lessionDiscuss:(UIButton*)sender{
    UIStoryboard *storyBoardDongTai=[UIStoryboard storyboardWithName:@"DongTaiStoryboard" bundle:nil];
    TTDongTaiViewController *dongTaiController = (TTDongTaiViewController *)[storyBoardDongTai instantiateViewControllerWithIdentifier:@"TTDongTaiViewController"];
    dongTaiController.lession = _lession;
    [self.navigationController pushViewController:dongTaiController animated:YES];
}

-(void)getDetailLessionInfo{
    [MBProgressHUD showHUDAddedTo:self.view  animated:YES];

    [TTLessionMngTool getDetailLessionInfo:_lession.active_id Result:^(DetailLessionModel *detailLession) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        _detailLession = detailLession;
        if ([detailLession isKindOfClass:[DetailLessionModel class]]) {
            [_zaoJiaoPlayTableView reloadData];
        }else{
            if ([detailLession isEqual:@"neterror"]) {
                [MBProgressHUD TTDelayHudWithMassage:@"网络连接错误 请检查网络" View:self.view];
            }else{
                [MBProgressHUD TTDelayHudWithMassage:@"获取课程详细信息失败" View:self.view];
            }
        }
    }];
}
#pragma mark 立即上课
-(void)didPlayLession{
    if ([AFNetworkReachabilityManager sharedManager].reachable) {
        [self playLessionVideo];
    }else{
        [MBProgressHUD TTDelayHudWithMassage:@"网络链接错误 请检查网络" View:self.view];
    }
}

-(void)playLessionVideo{
    [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    
    [TTLessionMngTool getLessionVideoPath:_lession.active_id Result:^(NSString *videoPath) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (videoPath != nil) {
            if ([videoPath isEqualToString:@"neterror"]) {
                [MBProgressHUD TTDelayHudWithMassage:@"网络链接错误 请检查网络" View:self.view];
                return;
            }
            NSString* fullPath = [NSString stringWithFormat:@"%@%@", TTBASE_URL, videoPath];
            _fullPath = fullPath;
            if ([AFNetworkReachabilityManager sharedManager].reachableViaWiFi) {
                MPMoviePlayerViewController* movieViewPlayer = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:_fullPath]];
                [self presentMoviePlayerViewControllerAnimated:movieViewPlayer];
            }else if( [AFNetworkReachabilityManager sharedManager].reachableViaWWAN){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前WIFI未连接 会耗费流量" delegate:self cancelButtonTitle:@"不看了" otherButtonTitles:@"继续看", nil];
                alert.delegate = self;
                alert.tag = 111;
                [alert show];
            }else{
                [MBProgressHUD TTDelayHudWithMassage:@"网络链接错误 请检查网络" View:self.view];
            }
        }else{
            if ([[TTUserModelTool sharedUserModelTool].logonUser.ttid isEqualToString:@"1977"]) {
                UIAlertView* alertView =  [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册登录后体验课程" delegate:self cancelButtonTitle:@"以后吧" otherButtonTitles:@"登录注册",nil];
                [alertView show];
            }else{
                UIAlertView* alertView =  [[UIAlertView alloc]initWithTitle:@"提示" message:@"只有VIP会员才能上此课程" delegate:self cancelButtonTitle:@"不上了" otherButtonTitles:@"立即充值",nil];
                [alertView show];
            }
        }
    }];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
        {
            //继续观看视频
            if (alertView.tag == 111) {
                MPMoviePlayerViewController* movieViewPlayer = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:_fullPath]];
                [self presentMoviePlayerViewControllerAnimated:movieViewPlayer];
            }else{
                
                if ([[TTUserModelTool sharedUserModelTool].logonUser.ttid isEqualToString:@"1977"]) {
                    [[TTUIChangeTool sharedTTUIChangeTool]backToLogReg:self];
                }else{
                    UIStoryboard *storyBoardDongTai=[UIStoryboard storyboardWithName:@"WoStoryboard" bundle:nil];
                    TTWoVipViewController *vipPayController = (TTWoVipViewController *)[storyBoardDongTai instantiateViewControllerWithIdentifier:@"VIPPAY"];
                    [self.navigationController pushViewController:vipPayController animated:YES];
                }
            }
        }
            break;
        default:
            break;
    }
}


@end
