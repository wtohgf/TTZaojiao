//
//  TTCommentListViewController.m
//  TTzaojiao
//
//  Created by hegf on 15-4-29.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTCommentListViewController.h"
#import "BlogReplayModel.h"
@interface TTCommentListViewController()
{
    NSMutableArray* _blogReplayList;
    NSString* _pageIndex;
    BOOL _isGetMoreList;
    CGFloat _backBottonBarY;
}
@end
@implementation TTCommentListViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"评论列表";
    
    UITableView* tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:tableView];
    
    _commentListTableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    _commentListTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [self setupRefresh];
    
    _blogReplayList = [NSMutableArray array];
    
    if(([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars
        = NO;
        self.modalPresentationCapturesStatusBarAppearance
        = NO;
    }
    
    _isGetMoreList = NO;
    _pageIndex = @"1";
    [self updateCommentlist];
    
    [self addBottomBar];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
    [self addKeyNotification];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除观察者
}

-(void)setupRefresh{
    [_commentListTableView addLegendHeaderWithRefreshingBlock:^{
        [_commentListTableView.header beginRefreshing];
        _isGetMoreList = NO;
        _pageIndex = @"1";
        [self updateCommentlist];
    }];
    
    [_commentListTableView  addLegendFooterWithRefreshingBlock:^{
        [_commentListTableView.footer beginRefreshing];
        _isGetMoreList = YES;
        NSUInteger idx = [_pageIndex integerValue]+1;
        _pageIndex = [NSString stringWithFormat:@"%ld", idx];
        [self updateCommentlist];
    }];
}

-(void)updateCommentlist{
    NSDictionary* parameters = @{
                                 @"i_id": _blog_id,
                                 @"p_1": _pageIndex,
                                 @"p_2": @"15"
                                 };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[AFAppDotNetAPIClient sharedClient]apiGet:COMMENT_LIST Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [_commentListTableView.header endRefreshing];
        [_commentListTableView.footer endRefreshing];
        
        if (result_status == ApiStatusSuccess) {
            if (!_isGetMoreList) {
                [_blogReplayList removeAllObjects];
            }
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                if (((NSMutableArray*)result_data).count!=0) {
                    NSMutableArray* list = (NSMutableArray*)result_data;
                    [list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        if ([obj isKindOfClass:[BlogReplayModel class]]) {
                            [_blogReplayList addObject:obj];
                            [_commentListTableView reloadData];
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCommentListCell* cell = [TTCommentListCell commentListCellWithTableView:tableView];
    TTCommentFrame* commentFrame = [[TTCommentFrame alloc]init];
    commentFrame.comment = _blogReplayList[indexPath.row];
    cell.commentFrame = commentFrame;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _blogReplayList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCommentFrame* commentFrame = [[TTCommentFrame alloc]init];
    commentFrame.comment = _blogReplayList[indexPath.row];
    return commentFrame.commentHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.f;
}


#pragma mark 添加低栏
-(void)addBottomBar{
    TTCommentRelaseView* commentView = [[TTCommentRelaseView alloc]init];
    _replayView = commentView;
   
    _replayView.delegate = self;
    CGFloat h = [UIScreen mainScreen].bounds.size.height*44.f/600.f;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat y = [UIScreen mainScreen].bounds.size.height - h - self.navigationController.navigationBar.height - [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat x = 0;
    commentView.frame = CGRectMake(x, y, w, h);
    _backBottonBarY = y;
    
    [self.view addSubview:commentView];
    [self.view bringSubviewToFront:commentView];
    
}


#pragma mark 注册键盘通知
-(void)addKeyNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboadWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}


//键盘出现时候调用的事件
-(void) keyboadWillShow:(NSNotification *)note{
    [self.view bringSubviewToFront:_replayView];
    
    NSDictionary *info = [note userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//键盘的frame
    CGFloat offY = (self.view.frame.size.height-keyboardSize.height)-_replayView.frame.size.height;//屏幕总高度-键盘高度-bottomBar高度
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame =  _replayView.frame;
        frame.origin.y =  offY;//UITextField位置的y坐标移动到offY
        _replayView.frame = frame;
    }];
    
}
//键盘消失时候调用的事件
-(void)keyboardWillHide:(NSNotification *)note{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame =  _replayView.frame;
        frame.origin.y =  _backBottonBarY;
        _replayView.frame = frame;
    }];
}

//点击背景键盘消失
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_replayView.commentTextField resignFirstResponder];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_replayView.commentTextField resignFirstResponder];
}

//键盘点击return自动消失
-(void)commentRelaseView:(TTCommentRelaseView *)view didEndEdit:(NSString *)commentContent{
    [view.commentTextField resignFirstResponder];
}

-(void)didReplayButtonClick{
    if (_replayView.commentTextField.text.length != 0) {
        [[TTCityMngTool sharedCityMngTool] startLocation:^(CLLocation *location) {
            _location = location;
            [self replayComment];
        }];
        
    }
}

-(void)replayComment{
    UserModel* user = [TTUserModelTool sharedUserModelTool].logonUser;
    NSString* lat = [NSString stringWithFormat:@"%.2f", _location.coordinate.latitude];
    NSString* lon = [NSString stringWithFormat:@"%.2f", _location.coordinate.longitude];
    
    NSDictionary* parameters = @{
                                 @"i_uid": user.ttid,
                                 @"i_psd": [TTUserModelTool sharedUserModelTool].password,
                                 @"i_id": _blog_id,
                                 @"i_content":_replayView.commentTextField.text,
                                 @"i_x":lat,
                                 @"i_y":lon
                                 };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[AFAppDotNetAPIClient sharedClient]apiGet:COMMENT Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (result_status == ApiStatusSuccess) {
            _isGetMoreList = NO;
            _pageIndex = @"1";
            [self updateCommentlist];
        }else{
            if (result_status != ApiStatusNetworkNotReachable) {
                [[[UIAlertView alloc]init] showWithTitle:@"友情提示" message:@"服务器好像罢工了" cancelButtonTitle:@"重试一下"];
            }
        };
        
    }];
    [_replayView.commentTextField resignFirstResponder];
}

@end
