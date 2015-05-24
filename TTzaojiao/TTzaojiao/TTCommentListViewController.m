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
    
    UITableView* tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 20.f -64.f -30.f)];
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
    //[UIApplication sharedApplication].statusBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除观察者
    //[UIApplication sharedApplication].statusBarHidden = NO;
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
      [[AFAppDotNetAPIClient sharedClient]apiGet:COMMENT_LIST Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {

        [_commentListTableView.header endRefreshing];
        [_commentListTableView.footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (result_status == ApiStatusSuccess) {
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                if (((NSMutableArray*)result_data).count!=0) {
                    NSMutableArray* list = (NSMutableArray*)result_data;
                    if([[list firstObject]isKindOfClass:[NSDictionary class]]){
                        NSDictionary* dict = [list firstObject];
                        if([[dict objectForKey:@"msg"]isEqualToString:@"Get_List_Blog_Replay"])
                        {
                            [list removeObjectAtIndex:0];
                            if(_isGetMoreList){
                               [_blogReplayList addObjectsFromArray:list];
                                _isGetMoreList = NO;
                            }else{
                                _blogReplayList = list;
                            }
                        }
                    }
                    if ([TTUIChangeTool sharedTTUIChangeTool].shouldBeUpdateCellIndexPath == YES) {
                        [TTUIChangeTool sharedTTUIChangeTool].needUpdateBlogList = _blogReplayList;
                    }
                    [_commentListTableView reloadData];
                }
            }
        }else{
            [MBProgressHUD TTDelayHudWithMassage:@"网络连接错误 请检查网络" View:self.view];
        };
        
    }];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCommentListCell* cell = [TTCommentListCell commentListCellWithTableView:tableView];
    TTCommentFrame* commentFrame = [[TTCommentFrame alloc]init];
    commentFrame.comment =  [BlogReplayModel blogReplayModelWithDict:_blogReplayList[indexPath.row]];
    cell.commentFrame = commentFrame;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _blogReplayList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCommentFrame* commentFrame = [[TTCommentFrame alloc]init];
    commentFrame.comment = [BlogReplayModel blogReplayModelWithDict:_blogReplayList[indexPath.row]];
    return commentFrame.commentHeight;
}

#pragma mark 添加低栏
-(void)addBottomBar{
    TTCommentRelaseView* commentView = [[TTCommentRelaseView alloc]init];
    _replayView = commentView;
   
    _replayView.delegate = self;
    CGFloat h = kBottomBarHeight;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat y = [UIScreen mainScreen].bounds.size.height -64.f - h;
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
    if (![[TTUserModelTool sharedUserModelTool].logonUser.ttid isEqualToString:@"1977"]) {
        if (_replayView.commentTextField.text.length != 0) {
            [[TTCityMngTool sharedCityMngTool] startLocation:^(CLLocation *location, NSError *error) {
                _location = location;
                [self replayComment];
            }];
            
        }else{
            [MBProgressHUD TTDelayHudWithMassage:@"评论不能为空" View:self.view];
        }
    }    else{
        UIAlertView* alertView =  [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册登录后可以给好友发消息哦" delegate:self cancelButtonTitle:@"以后吧" otherButtonTitles:@"登录注册",nil];
        [alertView show];
    }
}

-(void)replayComment{
    
    [TTUIChangeTool sharedTTUIChangeTool].shouldBeUpdateCellIndexPath = YES;

    UserModel* user = [TTUserModelTool sharedUserModelTool].logonUser;
    NSString* lat = @"0";
    NSString* lon = @"0";
    if (_location != nil) {
        lat = [NSString stringWithFormat:@"%.2f", _location.coordinate.latitude];
        lon = [NSString stringWithFormat:@"%.2f", _location.coordinate.longitude];
    }
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
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (result_status == ApiStatusSuccess) {
            [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(updateInfo) userInfo:nil repeats:NO];
        }else{
            [MBProgressHUD TTDelayHudWithMassage:@"网络连接错误 请检查网络" View:self.view];
        };
        
    }];
    [_replayView.commentTextField resignFirstResponder];
    
}

-(void)updateInfo{
    _isGetMoreList = NO;
    _pageIndex = @"1";
    [self updateCommentlist];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
        {
            [self.rdv_tabBarController.navigationController popViewControllerAnimated:YES];
        }
            break;
        default:
            break;
    }
}


@end
