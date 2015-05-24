//
//  TTWoFansViewController.m
//  TTzaojiao
//
//  Created by hegf on 15-5-15.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoFansViewController.h"
#import <MJRefresh.h>
#import "TTUserDongtaiViewController.h"

@interface TTWoFansViewController ()
@property (strong, nonatomic) NSMutableArray* friendList;
@property (weak, nonatomic) UITableView* wofriendTableView;
@end

@implementation TTWoFansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加TableView
    [self addTableView];
    
    //集成上下拉刷新
    [self setupRefresh];
    
    NSMutableArray* friendList = [NSMutableArray array];
    _friendList = friendList;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addTableView{
    UITableView * tableView = [[UITableView alloc]init];
    _wofriendTableView = tableView;
    
    CGFloat w=self.view.frame.size.width;
    CGFloat h=self.view.frame.size.height - self.tabBarController.tabBar.height - self.navigationController.navigationBar.height - [UIApplication sharedApplication].statusBarFrame.size.height;
    tableView.frame = CGRectMake(0, 0, w, h);
    
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    UIView* footView = [[UIView alloc]initWithFrame:CGRectZero];
    tableView.tableFooterView = footView;
    
    [self.view addSubview:tableView];
    
    if(([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars
        = NO;
        self.modalPresentationCapturesStatusBarAppearance
        = NO;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTNearBybabyTableViewCell* cell = [TTNearBybabyTableViewCell nearBybabyCellWithTableView:tableView];
    if (_friendList!=nil&&_friendList.count>0) {
        cell.nearByBaby = _friendList[indexPath.row];
    }
    cell.babyInfoView.distance.hidden = YES;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _friendList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenWidth*TTHeaderWithRatio+2*TTBlogTableBorder;
}

-(void)setupRefresh{
    [_wofriendTableView addLegendHeaderWithRefreshingBlock:^{
        [_wofriendTableView.header beginRefreshing];
        [self updateFriend];
    }];
    
    [_wofriendTableView  addLegendFooterWithRefreshingBlock:^{
        [_wofriendTableView.footer beginRefreshing];
        [self updateFriend];
    }];
}

-(void)updateFriend{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [TTUserModelTool getWoFanListResult:^(id friendList) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [_wofriendTableView.header endRefreshing];
        [_wofriendTableView.footer endRefreshing];
        if ([friendList isKindOfClass:[NSMutableArray class]]) {
            _friendList = friendList;
            [_wofriendTableView reloadData];
        }else if([friendList isKindOfClass:[NSString class]]){
            if ([friendList isEqualToString:@"neterror"]) {
                [MBProgressHUD TTDelayHudWithMassage:@"网络连接 错误，请检查网络" View:self.view];
            }else{
                [MBProgressHUD TTDelayHudWithMassage:@"粉丝信息获取失败" View:self.view];
            }
        }
    }];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    [self updateFriend];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_friendList!= nil&&_friendList.count>0) {
        UIStoryboard *storyBoardDongTai=[UIStoryboard storyboardWithName:@"DongTaiStoryboard" bundle:nil];
        TTUserDongtaiViewController *userViewController = (TTUserDongtaiViewController *)[storyBoardDongTai instantiateViewControllerWithIdentifier:@"UserUIM"];
        NearByBabyModel* baby = _friendList[indexPath.row];
        [userViewController setI_uid:baby.uid];
        [self.navigationController pushViewController:userViewController animated:YES];
    }
}

@end
