//
//  TTDongTaiViewController.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/4/21.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTDongTaiViewController.h"
#import "BlogModel.h"
#import "TTBlogFrame.h"
#import "TTDyanmicUserStautsCell.h"
#import "TTCommentListViewController.h"
#import "TTUserDongtaiViewController.h"

@interface TTDongTaiViewController (){
    NSMutableArray* _blogs;
    NSUInteger _pageIndexInt;
    NSString* _i_sort;
    NSString* _group;
    UIView* _customHeaderView;
    UISegmentedControl* _sortSeg;
    BOOL _isGetMoreBlog;
}
@property (weak, nonatomic) IBOutlet UITableView *dongtaiTable;

@end

@implementation TTDongTaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadHeaderView];
    
    [self setupRefresh];
    
    if(([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars
        = NO;
        self.modalPresentationCapturesStatusBarAppearance
        = NO;
    }
}

-(void)setupRefresh{
    _isGetMoreBlog = NO;
    [_dongtaiTable addLegendHeaderWithRefreshingBlock:^{
        [_dongtaiTable.header beginRefreshing];
        [self updateBlog];
    }];

    [_dongtaiTable addLegendFooterWithRefreshingBlock:^{
        [_dongtaiTable.footer beginRefreshing];
        _pageIndexInt++;
        _isGetMoreBlog = YES;
        [self updateBlog];
    }];
    
}

-(void)loadHeaderView{
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.f)];
    _customHeaderView = view;
    view.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    
    NSArray* items = @[@"早教自拍", @"课程提问", @"宝宝生活", @"附近宝宝"];
    
    UISegmentedControl* sortSeg = [[UISegmentedControl alloc]initWithItems:items];
    sortSeg.frame = CGRectMake(40, 4, view.frame.size.width-80, view.frame.size.height-8);
    [sortSeg addTarget:self action:@selector(selChanged:) forControlEvents:UIControlEventValueChanged];
    sortSeg.tintColor = [UIColor colorWithHue:216.0/255.0 saturation:117.0/255.0 brightness:152.0/255.0 alpha:1.0];
    NSDictionary* textAttr1 = @{
                                NSForegroundColorAttributeName:[UIColor colorWithRed:255.0/255.0 green:168.0/255.0 blue:188.0/255.0 alpha:1.0f]
                                };
    [sortSeg setTitleTextAttributes:textAttr1 forState:UIControlStateNormal];
    NSDictionary* textAttr2 = @{
                                NSForegroundColorAttributeName:[UIColor whiteColor]
                                };
    [sortSeg setTitleTextAttributes:textAttr2 forState:UIControlStateSelected];
    _sortSeg = sortSeg;
    sortSeg.selectedSegmentIndex = 0;
    [view addSubview:sortSeg];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _pageIndexInt = 1;
    _i_sort = @"1";
    _group = @"1";
    _sortSeg.selectedSegmentIndex = 0;
    [self updateBlog];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}

-(void)updateBlog{
   
    NSString* pageIndex = [NSString stringWithFormat:@"%ld", _pageIndexInt];
    NSString* i_uid = [TTUserModelTool sharedUserModelTool].logonUser.ttid;
    NSDictionary* parameters = @{
                                 @"i_uid": i_uid,
                                 @"p_1": pageIndex,
                                 @"p_2": @"15",
                                 @"i_sort": _i_sort,
                                 @"i_group": _group
                                 };
    [MBProgressHUD showHUDAddedTo:_dongtaiTable animated:YES];
    [[AFAppDotNetAPIClient sharedClient]apiGet:GET_LIST_BLOG_GROUP Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        [MBProgressHUD hideAllHUDsForView:_dongtaiTable animated:YES];
        if (_blogs == nil) {
            _blogs = [NSMutableArray array];
        }
        if (result_status == ApiStatusSuccess) {
            if (_isGetMoreBlog) {
                [_dongtaiTable.footer endRefreshing];
                _isGetMoreBlog = NO;
            }else{
                [_dongtaiTable.header endRefreshing];
                [_blogs removeAllObjects];
            }
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                [result_data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([obj isKindOfClass:[BlogModel class]]) {
                        [_blogs addObject:obj];
                    }
                }];

                [_dongtaiTable reloadData];
            }
            
        }else{
            if (_isGetMoreBlog) {
                [_dongtaiTable.footer endRefreshing];
                _isGetMoreBlog = NO;
            }else{
                [_dongtaiTable.header endRefreshing];
            }
            if (result_status != ApiStatusNetworkNotReachable) {
                [[[UIAlertView alloc]init] showWithTitle:@"友情提示" message:@"服务器好像罢工了" cancelButtonTitle:@"重试一下"];
            }
        };
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return _customHeaderView;
    }else
    return [[UIView alloc]initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 44.f;
    }
    return 1.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    TTDyanmicUserStautsCell* cell = [TTDyanmicUserStautsCell dyanmicUserStautsCellWithTableView:tableView];
    TTBlogFrame* frame = [[TTBlogFrame alloc]init];
    frame.blog = _blogs[indexPath.row];
    cell.blogFrame = frame;
    //评论列表View的代理 响应查看全部按钮代理方法
    cell.commentsView.delegate = self;
    cell.topView.delegate = self;
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _blogs.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTBlogFrame* frame = [[TTBlogFrame alloc]init];
    frame.blog = _blogs[indexPath.row];
    return frame.cellHeight;
}


- (void)selChanged:(UISegmentedControl *)sender {
    _pageIndexInt = 0;
    _i_sort = [NSString stringWithFormat:@"%ld", sender.selectedSegmentIndex + 1];
    [self updateBlog];
}

#pragma mark 查看回复全部列表
-(void)dynamicCommentsView:(TTDynamicCommentsView *)dynamicCommentsView didShowCommentList:(NSString *)blog_id{
    [self performSegueWithIdentifier:@"toCommentList" sender:blog_id];
}
#pragma mark 头像点击代理
-(void)dynamicUserStatusTopView:(TTDynamicUserStatusTopView *)view didIconTaped:(NSString *)uid{
    [self performSegueWithIdentifier:@"toUserDynamic" sender:uid];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[TTCommentListViewController class]]) {
        TTCommentListViewController* dvc = (TTCommentListViewController*)segue.destinationViewController;
        dvc.blog_id = sender;
    }
    if ([segue.destinationViewController isKindOfClass:[TTUserDongtaiViewController class]]) {
        
        TTUserDongtaiViewController* uvc = (TTUserDongtaiViewController*)segue.destinationViewController;
        uvc.i_uid = sender;
    }
}

@end
