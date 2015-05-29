//
//  TTYuyingViewController.m
//  TTzaojiao
//
//  Created by hegf on 15-5-29.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTYuyingViewController.h"
#import <MJRefresh.h>
#import "UIView+NKMoreAttribute.h"
#import "UIImage+MoreAttribute.h"
#import "TTBlogFrame.h"
#import "TTYuyingTableViewCell.h"
#import "TSLocateView.h"

#define headerHeight 36.f

@interface TTYuyingViewController ()
@property (weak, nonatomic) UITableView* yuyingTableView;
@property (strong, nonatomic) UIView* headerView;
@property (copy, nonatomic) NSString* pageIndex;
@property (copy, nonatomic) NSString* cityCode;
@property (weak, nonatomic) UIButton* cityButton;
@property (strong, nonatomic) NSMutableArray* yuyingList;
@property (weak, nonatomic) UIButton* backsel;
@end


@implementation TTYuyingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTableView];
    
    [self addHeadrView];
    
    [self setupRefresh];
    
    _pageIndex = @"1";
    [self updateYuYingList];
}

-(void)addHeadrView{
    UIView* view = [[UIView alloc]init];
    _headerView = view;
    view.backgroundColor = [UIColor grayColor];
    
    view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30.f);
    
    CGFloat margin = 0.5f;
    
    UIButton* button1 = [[UIButton alloc]init];
    [button1 setTitle:@"综合排序" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor purpleColor] forState:UIControlStateSelected];
    button1.backgroundColor = TTBlogBackgroundColor;
    button1.titleLabel.font = TTBlogMaintitleFont;
    [button1 setTitleColor:[UIColor colorWithRed:47.f/255.f green:120.f/255.f blue:232.f/255.f alpha:1.f] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
    [view addSubview:button1];
    button1.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width - 2*margin)/3 , headerHeight);
    [button1 addTarget:self action:@selector(sortChange:) forControlEvents:UIControlEventTouchUpInside];
    UIButton* button2 = [[UIButton alloc]init];
    button2.titleLabel.font = TTBlogMaintitleFont;
    [button2 setTitleColor:[UIColor purpleColor] forState:UIControlStateSelected];
    [button2 setTitle:@"离我最近" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(sortChange:) forControlEvents:UIControlEventTouchUpInside];
    
    button2.backgroundColor = TTBlogBackgroundColor;
    [button2 setTitleColor:[UIColor colorWithRed:47.f/255.f green:120.f/255.f blue:232.f/255.f alpha:1.f] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
    
    [view addSubview:button2];
    button2.frame = CGRectMake(button1.right+margin, 0, ([UIScreen mainScreen].bounds.size.width - 2*margin)/3 , headerHeight);
    
    UIButton* button3 = [[UIButton alloc]init];
    button3.titleLabel.font = TTBlogMaintitleFont;
    [button3 setTitle:@"大连" forState:UIControlStateNormal];
    [button3 setImage:[UIImage imageWithName:@"locate.png"] forState:UIControlStateNormal];
    button3.backgroundColor = TTBlogBackgroundColor;
    [button3 setTitleColor:[UIColor colorWithRed:47.f/255.f green:120.f/255.f blue:232.f/255.f alpha:1.f] forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
    [view addSubview:button3];
    button3.frame = CGRectMake(button2.right+margin, 0, ([UIScreen mainScreen].bounds.size.width - 2*margin)/3 , headerHeight);
    [button3 addTarget:self action:@selector(changLocation:) forControlEvents:UIControlEventTouchUpInside];
    
    _cityButton = button3;
    
}

-(void)sortChange:(UIButton*)sender{
    _backsel.selected = NO;
    sender.selected = !sender.selected;
    _backsel = sender;
    
    //重新加载网络数据
    _pageIndex = @"1";
    [self loadData];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_headerView != nil) {
        return _headerView;
    }else{
        return [[UIView alloc]initWithFrame:CGRectZero];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_headerView != nil) {
        return headerHeight;
    }else{
        return 0.f;
    }
}

-(void)addTableView{
    UITableView * tableView = [[UITableView alloc]init];
    _yuyingTableView = tableView;
    
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    CGFloat h=[UIScreen mainScreen].bounds.size.height - 64.f - 49.f;    tableView.frame = CGRectMake(0, 0, w, h);
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    UIView* footView = [[UIView alloc]initWithFrame:CGRectZero];
    tableView.tableFooterView = footView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    if(([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars
        = NO;
        self.modalPresentationCapturesStatusBarAppearance
        = NO;
    }
    
}

-(void)setupRefresh{
    __weak TTYuyingViewController* weakself = self;
    
    [_yuyingTableView addLegendHeaderWithRefreshingBlock:^{
        [weakself.yuyingTableView.header beginRefreshing];
        weakself.pageIndex = @"1";
        [weakself updateYuYingList];
    }];
    
    [_yuyingTableView  addLegendFooterWithRefreshingBlock:^{
        [weakself.yuyingTableView.footer beginRefreshing];
        NSUInteger index = [weakself.pageIndex integerValue]+1;
        weakself.pageIndex = [NSString stringWithFormat:@"%ld", index];
        [weakself updateYuYingList];
    }];
}

-(void)updateYuYingList{
    //定位获得城市码
    __weak TTYuyingViewController* weakself = self;
    [[TTCityMngTool sharedCityMngTool] startLocation:^(CLLocation *location, NSError *error) {
        //NSLog(@"latitude is %f",location.coordinate.latitude);
        if(location!=nil){
            [[TTCityMngTool sharedCityMngTool] getReverseGeocode:location Result:^(NSString *cityCode, NSError *error) {
                weakself.cityCode = cityCode;
                //加载异步网络数据
                [weakself loadData];
            }];
        }else{
            [MBProgressHUD TTDelayHudWithMassage:@"定位失败了" View:weakself.view];
            [weakself loadData];
        }
    }];
    

}

-(void)loadData{
    
    if (_cityCode == nil || [_cityCode isEqualToString:@""]) {
        _cityCode = @"210200";
    }
    
    [_cityButton setTitle:[[TTCityMngTool sharedCityMngTool]codetoCity:_cityCode] forState:UIControlStateNormal];
    //&i_uid=1977&i_psd=3e9fe397381d3e595979a716ebf32c21&p_1=1&p_2=10&i_city=210200
    NSDictionary* parameters = @{
                                 @"i_uid": @"1977",
                                 @"i_psd": @"3e9fe397381d3e595979a716ebf32c21",
                                 @"p_1": _pageIndex,
                                 @"p_1": @"10",
                                 @"i_city":_cityCode
                                     };
    
    [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    [[AFAppDotNetAPIClient sharedClient]apiGet:GET_LIST_Teacher_Index Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
 
        [_yuyingTableView.header endRefreshing];
        [_yuyingTableView.footer endRefreshing];

        if (result_status == ApiStatusSuccess) {
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                NSMutableArray* list = result_data;
                if (list!= nil && list.count > 0) {
                    YuyingModel* mode = [list firstObject];
                    if ([mode.msg isEqualToString:@"Get_List_Teacher_Index"]) {
                        [list removeObjectAtIndex:0];
                        if ([_pageIndex integerValue] > 1) {
                            [_yuyingList addObjectsFromArray:list];
                        }else{
                            _yuyingList = list;
                        }
                        [_yuyingTableView reloadData];
                    }else{
                        [MBProgressHUD TTDelayHudWithMassage:@"育婴信息获取失败" View:self.view];
                    }
                }
            }else{
                [MBProgressHUD TTDelayHudWithMassage:@"育婴信息获取失败" View:self.view];
            }
            
        }else{
            if (result_status != ApiStatusNetworkNotReachable) {
                [MBProgressHUD TTDelayHudWithMassage:@"网络连接错误 请检查网络" View:self.view];
            }
        };
        
    }];
    
    [_yuyingTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_yuyingList != nil && _yuyingList.count>0) {
        TTYuyingTableViewCell* cell = [TTYuyingTableViewCell yuyingTableViewCellWithTableView:tableView];
        cell.yuyingModel = _yuyingList[indexPath.row];
        return cell;
    }else{
        return [[UITableViewCell alloc]initWithFrame:CGRectZero];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_yuyingList != nil && _yuyingList.count>0) {
        return [TTYuyingTableViewCell cellHeight];
    }else{
        return 0.f;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_yuyingList != nil && _yuyingList.count>0) {
        return _yuyingList.count;
    }else{
        return 0;
    }
}

#pragma mark 更改位置
- (void)changLocation:(UIButton *)sender {
    //[_babyName resignFirstResponder];
    [[self rdv_tabBarController]setTabBarHidden:YES];
    TSLocateView *locateView = [TSLocateView sharedcityPicker:@"请选择城市" delegate:self];
    [locateView showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([actionSheet isKindOfClass:[TSLocateView class]]) {
        TSLocateView *locateView = (TSLocateView *)actionSheet;
        TSLocation *location = locateView.locate;
        
        //You can uses location to your application.
        if(buttonIndex == 0) {
            _cityCode = @"210200";
        }else {
            NSString* cityName = [NSString stringWithFormat:@"%@市", location.city];
           [_cityButton setTitle:cityName forState:UIControlStateNormal];
            _cityCode = [[TTCityMngTool sharedCityMngTool]citytoCode:cityName];
        }
        [[self rdv_tabBarController]setTabBarHidden:NO];
        //重新加载网络数据
        _pageIndex = @"1";
        [self loadData];
    }
}

-(void)dealloc{
    [_headerView removeFromSuperview];
    _headerView = nil;
    _yuyingList = nil;
}

@end
