//
//  TTZaojiaoViewController.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/4/21.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTZaojiaoViewController.h"
#import "TTZaojiaoPlayLessionController.h"

#define kSectionMargin 8.f

@interface TTZaojiaoViewController ()
@property (weak, nonatomic) UITableView* zaoJiaoTableView;
@property (strong, nonatomic) UIView* customHeaderView;
@property (weak, nonatomic) UISegmentedControl* sortSeg;
@property (copy, nonatomic) NSString* lessionID;
@property (strong, nonatomic) NSMutableArray* lessList;
@end

@implementation TTZaojiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加导航自定义栏
    [self addNavItems];
    
    //添加TableView
    [self addTableView];
    
    //设定headerView
    [self setTableViewHeader];
    
    [self getLessionID];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    __weak TTZaojiaoViewController* weakself = self;
    _leftView.logonUser = [TTUserModelTool sharedUserModelTool].logonUser;
    
    if ([[TTUserModelTool sharedUserModelTool].logonUser.ttid isEqualToString:@"1977"]) {
        weakself.rightView.vip.hidden = YES;
    }else{
        [TTUserModelTool getUserInfo:[TTUserModelTool sharedUserModelTool].logonUser.ttid Result:^(DynamicUserModel *user) {
            
            NSComparisonResult result = [NSString compareDateNow:user.vip_time];
            if (NSOrderedDescending == result) {
                weakself.rightView.vip.hidden = NO;
            }else{
                weakself.rightView.vip.hidden = YES;
            }
            
        }];
    }
}

-(void)addNavItems{
    self.title = @"";
    
    TTZaojiaoHeaderLeftItem* leftView = [[TTZaojiaoHeaderLeftItem alloc]init];
    _leftView = leftView;
    leftView.logonUser = [TTUserModelTool sharedUserModelTool].logonUser;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    
    TTZaojiaoHeaderRightItem* rightView = [TTZaojiaoHeaderRightItem zaojiaoHeaderRightItemWithTarget:self Action:@selector(vipPay:)];
    
    _rightView = rightView;
    rightView.logonUser = [TTUserModelTool sharedUserModelTool].logonUser;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
}

-(void)vipPay:(TTZaojiaoHeaderRightItem*)sender{
    
    if ( [[TTUserModelTool sharedUserModelTool].logonUser.ttid isEqualToString:@"1977"]) {
        [[TTUIChangeTool sharedTTUIChangeTool]backToLogReg:self];
    }else{
        UIStoryboard *storyBoardDongTai=[UIStoryboard storyboardWithName:@"WoStoryboard" bundle:nil];
        TTWoVipViewController *vipPayController = (TTWoVipViewController *)[storyBoardDongTai instantiateViewControllerWithIdentifier:@"VIPPAY"];
        [self.navigationController pushViewController:vipPayController animated:YES];
        
    }
}

-(void)addTableView{
    UITableView * tableView = [[UITableView alloc]init];
    _zaoJiaoTableView = tableView;
    if(([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars
        = NO;
        self.modalPresentationCapturesStatusBarAppearance
        = NO;
    }
    
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    CGFloat h=[UIScreen mainScreen].bounds.size.height - 64.f - 49.f;
    
    tableView.frame = CGRectMake(0, 0, w, h);
  
    tableView.dataSource = self;
    tableView.delegate = self;
    
    UIView* footView = [[UIView alloc]initWithFrame:CGRectZero];
    tableView.tableFooterView = footView;

    [self.view addSubview:tableView];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id cell = nil;
    if (indexPath.section == 0) {
        TTZaojiaoIntroduceCell* tmpcell = [TTZaojiaoIntroduceCell zaojiaoIntroduceCellWithTableView:tableView];
        tmpcell.logonUser = [TTUserModelTool sharedUserModelTool].logonUser;
        cell = tmpcell;
    }else{
        TTZaojiaoLessionCell* tmpcell = [TTZaojiaoLessionCell zaojiaoLessionCellWithTableView:tableView];
        if (_lessList.count > 0) {
            tmpcell.lession = _lessList[indexPath.section-1];
        }
        cell = tmpcell;
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _lessList.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [TTZaojiaoIntroduceCell cellHeightWithModel:[TTUserModelTool sharedUserModelTool].logonUser];
    }else{
        return [TTZaojiaoLessionCell cellHeight];
    };
}

-(void)setTableViewHeader{
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.f)];
   
    view.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    
    NSArray* items = @[@"上周课程", @"本周课程", @"下周课程"];
    
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
    //本周课程
    sortSeg.selectedSegmentIndex = 1;
    [view addSubview:sortSeg];
    
    _customHeaderView = view;
    
}

- (void)selChanged:(UISegmentedControl *)sender {
    
    [self getLessionID];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return _customHeaderView;
    }else{
        UIView* view = [[UIView alloc]initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, kSectionMargin)];
        view.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
        return view;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 44.f;
    }else{
        return kSectionMargin;
    }
}

-(void)getLessionID{
    __weak TTZaojiaoViewController* weakself = self;
    [TTLessionMngTool getLessionID:^(id lessionID) {
        if ([lessionID isEqualToString:@"error"]) {
            [MBProgressHUD TTDelayHudWithMassage:@"账号信息不正确\n请重新登录" View:weakself.view];
            return;
        }
        
        if ([lessionID isEqualToString:@"neterror"]) {
            [MBProgressHUD TTDelayHudWithMassage:@"网络连接错误 请检查网络" View:weakself.view];
            return;
        }
        
        weakself.lessionID = lessionID;
        //上周课程
        if (weakself.sortSeg.selectedSegmentIndex == 0) {
            NSInteger tmdID = [weakself.lessionID integerValue];
            tmdID = tmdID-1;
            if (tmdID < 0) {
                [MBProgressHUD TTDelayHudWithMassage:@"没有上周课程了" View:weakself.view];
                return;
            }else{
                weakself.lessionID = [NSString stringWithFormat:@"%ld", tmdID];
            }
        //下周课程
        }else if(weakself.sortSeg.selectedSegmentIndex == 2)
        {
            NSInteger tmdID = [weakself.lessionID integerValue];
            tmdID = tmdID + 1;
            if (tmdID > 100) {
                [MBProgressHUD TTDelayHudWithMassage:@"没有下周课程了" View:weakself.view];
                return;
            }
            weakself.lessionID = [NSString stringWithFormat:@"%ld", tmdID];
        }
        
        if (lessionID != nil) {
            [weakself getWeekLession:(weakself.lessionID)];
        }
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 0) {
        if (_lessList == nil ||_lessList.count == 0|| _lessList[indexPath.section-1] == nil) {
            return;
        }
        [self performSegueWithIdentifier:@"toPlayLession" sender:_lessList[indexPath.section-1]];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    TTZaojiaoPlayLessionController* desvc = segue.destinationViewController;
    
    desvc.lession = sender;
}

-(void)getWeekLession:(NSString*)lessionID{
    __weak TTZaojiaoViewController* weakself = self;
    [MBProgressHUD showHUDAddedTo:self.view  animated:YES];

    [TTLessionMngTool getWeekLessions:lessionID Result:^(id lessions) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        if ([lessions isKindOfClass:[NSMutableArray class]]) {
            weakself.lessList = lessions;
            [weakself.zaoJiaoTableView reloadData];
        }else{
            if (weakself.sortSeg.selectedSegmentIndex == 0) {
                [MBProgressHUD TTDelayHudWithMassage:@"没有上周课程了" View:weakself.view];
            }else
                if (weakself.sortSeg.selectedSegmentIndex == 2) {
                [MBProgressHUD TTDelayHudWithMassage:@"没有下周课程了" View:weakself.view];
            }
        }
    }];

}
-(void)dealloc{
    _lessList = nil;
    [_customHeaderView removeFromSuperview];
    _customHeaderView = nil;
}


@end
