//
//  TTZaojiaoPlayLessionController.m
//  TTzaojiao
//
//  Created by hegf on 15-5-11.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTZaojiaoPlayLessionController.h"
#import "TTDynamicReleaseViewController.h"

#define kSectionMargin 8.f

@interface TTZaojiaoPlayLessionController ()
@property (weak, nonatomic) UITableView* zaoJiaoPlayTableView;
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
    
//    UIBarButtonItem* itemright = [UIBarButtonItem barButtonItemWithImage:@"icon_add_dynamic_state" target:self action:@selector(dynamic_state:)];
//    self.navigationItem.rightBarButtonItem = itemright;
    
}

//-(void)dynamic_state:(UIBarButtonItem*)item{
//    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"DongTaiStoryboard" bundle:nil];
//    TTDynamicReleaseViewController* rv = [storyBoard instantiateViewControllerWithIdentifier:@"DynamicReleaseViewController"];
//    
//    [self.navigationController pushViewController:rv animated:YES];
//}

-(void)addTableView{
    UITableView * tableView = [[UITableView alloc]init];
    _zaoJiaoPlayTableView = tableView;
    
    CGFloat w=self.view.frame.size.width;
    CGFloat h=self.view.frame.size.height - self.tabBarController.tabBar.height - self.navigationController.navigationBar.height - [UIApplication sharedApplication].statusBarFrame.size.height;
    tableView.frame = CGRectMake(0, 0, w, h);
    
    //    if(([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
    //        self.edgesForExtendedLayout = UIRectEdgeNone;
    //        self.extendedLayoutIncludesOpaqueBars
    //        = NO;
    //        self.modalPresentationCapturesStatusBarAppearance
    //        = NO;
    //    }
    
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
//            tmpcell.lession = _lession;
//            tmpcell.rightPushBtn.hidden = YES;
//            tmpcell.lessionIntroduce.hidden = YES;
//            tmpcell.playLessionBtn.hidden = NO;
            tmpcell.delegate = self;
            cell = tmpcell;
        }else{
            UITableViewCell* tmpcell = [[UITableViewCell alloc]initWithFrame:CGRectZero];
            cell = tmpcell;
        }
    }else{
        TTPlayLessionIntroduceCell* tmpcell = [TTPlayLessionIntroduceCell playLessionIntroduceCellWithTableView:tableView];
        tmpcell.detailLession = _detailLession;
        cell = tmpcell;
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

}

-(void)getDetailLessionInfo{
    [MBProgressHUD showHUDAddedTo:self.navigationController.view  animated:YES];

    [TTLessionMngTool getDetailLessionInfo:_lession.active_id Result:^(DetailLessionModel *detailLession) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        _detailLession = detailLession;
        if (detailLession!= nil) {
            [_zaoJiaoPlayTableView reloadData];
        }else{
            [MBProgressHUD TTDelayHudWithMassage:@"获取课程详细信息失败" View:self.navigationController.view];
        }
    }];
}
#pragma mark 理解上课
-(void)didPlayLession{
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view  animated:YES];
    
    [TTLessionMngTool getLessionVideoPath:_lession.active_id Result:^(NSString *videoPath) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        if (videoPath != nil) {
            
            NSString* fullPath = [NSString stringWithFormat:@"%@%@", TTBASE_URL, videoPath];
            
            AppMvPlayViewController* moviePlayer =[[AppMvPlayViewController alloc]init];
            
            moviePlayer.playurl = fullPath;
            [self presentViewController:moviePlayer animated:YES completion:nil];
  
        }else{
            [MBProgressHUD TTDelayHudWithMassage:@"课程视频获取失败" View:self.navigationController.view];
        }
    }];
    

}


@end
