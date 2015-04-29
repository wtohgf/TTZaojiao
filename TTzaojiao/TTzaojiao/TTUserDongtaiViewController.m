//
//  TTUserDongtaiViewController.m
//  TTzaojiao
//
//  Created by hegf on 15-4-27.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTUserDongtaiViewController.h"
#import <RDVTabBarController.h>
#import "UIImageView+MoreAttribute.h"
#import <MJRefresh.h>

@interface TTUserDongtaiViewController ()
{
    NSMutableArray* _blogList;
    NSString* _pageIndex;
    BOOL _isGetMoreList;
}

@property (strong, nonatomic) DynamicUserModel* curUser;
@property (weak, nonatomic) MBTwitterScroll* userDynamicScroll;
@end

@implementation TTUserDongtaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人动态";
    // Do any additional setup after loading the view.

    if(([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars
        = NO;
        self.modalPresentationCapturesStatusBarAppearance
        = NO;
    }
    
    _blogList = [NSMutableArray array];
//    [self setupRefresh];
    
    _isGetMoreList = NO;
    _pageIndex = @"1";
    [self updateDynamicBlog];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    //取得用户模型
    if (_i_uid.length != 0) {
        [self getUserinfo:_i_uid];
    }
    
}

-(void)setupRefresh{

    [_userDynamicScroll.tableView addLegendHeaderWithRefreshingBlock:^{
        [self.userDynamicScroll.tableView.header beginRefreshing];
        _isGetMoreList = NO;
        _pageIndex = @"1";
        [self updateDynamicBlog];
    }];
    
    [_userDynamicScroll.tableView  addLegendFooterWithRefreshingBlock:^{
        [self.userDynamicScroll.tableView.footer beginRefreshing];
        _isGetMoreList = YES;
        NSUInteger idx = [_pageIndex integerValue]+1;
        _pageIndex = [NSString stringWithFormat:@"%ld", idx];
        [self updateDynamicBlog];
    }];
}


-(void)updateDynamicBlog{
    NSDictionary* parameters = @{
                                 @"i_uid": _i_uid,
                                 @"p_1": _pageIndex,
                                 @"p_2": @"15"
                                 };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[AFAppDotNetAPIClient sharedClient]apiGet:USER_BLOG Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        [_userDynamicScroll.tableView.header endRefreshing];
//        [_userDynamicScroll.tableView.footer endRefreshing];
//        
        if (result_status == ApiStatusSuccess) {
            if (!_isGetMoreList) {
                [_blogList removeAllObjects];
            }
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                if (((NSMutableArray*)result_data).count!=0) {
                    NSMutableArray* list = (NSMutableArray*)result_data;
                    [list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        if ([obj isKindOfClass:[BlogModel class]]) {
                            [_blogList addObject:obj];
                            [_userDynamicScroll.tableView reloadData];
                        }
                    }];
                }
            }
        }else{
            if (result_status != ApiStatusNetworkNotReachable) {
                [[[UIAlertView alloc]init] showWithTitle:@"友情提示" message:@"服务器好像罢工了" cancelButtonTitle:@"重试一下"];
            }
        };
        
    }];
}

-(void)getUserinfo:(NSString*)i_uid{
    
    NSDictionary* parameters = @{
                                 @"i_uid": i_uid,
                                 };
    [[AFAppDotNetAPIClient sharedClient]apiGet:USER_INFO Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        if (result_status == ApiStatusSuccess) {
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                NSMutableArray *modes = result_data;
                if (modes.count == 2) {
                    DynamicUserModel* ret = result_data[0];
                    if ([ret.msg isEqualToString:@"Get_List_User_Info"]) {
                        DynamicUserModel* dyuser = result_data[1];
                        _curUser = dyuser;
                        [self loadUserInfo];
                            
                        }
                        
                    }
            }else{
                if (result_status != ApiStatusNetworkNotReachable) {
                    [[[UIAlertView alloc]init] showWithTitle:@"友情提示" message:@"服务器好像罢工了" cancelButtonTitle:@"重试一下"];
                }
            }
        }
    }];

}

//加载用户数据
-(void)loadUserInfo{
    [self addUserTwitterScroll];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO];
}

-(void)addUserTwitterScroll{
    
    MBTwitterScroll* scroll = [[MBTwitterScroll alloc]initTableViewWithBackgound:[UIImage imageNamed:@"baby_icon1"] avatarImage:[UIImage imageNamed:@"baby_icon1"]  titleString:_curUser.name subtitleString:_curUser.birthday buttonTitle:nil];

    _userDynamicScroll = scroll;
    if (_curUser.icon.length != 0) {
        [scroll.avatarImage setImageIcon:_curUser.icon];
    }
    
    scroll.tableView.delegate = self;
    scroll.tableView.dataSource = self;
    
    [self.view addSubview:scroll];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* ID = @"saveEditCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @"TEST";
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIButton* btn = [[UIButton alloc]init];
        [btn setTitle:@"动态" forState:UIControlStateNormal];
        btn.userInteractionEnabled = NO;
        [btn setBackgroundColor:[UIColor colorWithRed:247.f/255.f green:215.f/255.f blue:226.f/255.f alpha:1.f]];
        //btn.frame = CGRectMake(0, 0, self.view.frame.size.width, 10);
        return btn;
    }else{
        return [[UIView alloc]initWithFrame:CGRectZero];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 44.f;
    }else{
        return 0.f;
    }
}

@end
