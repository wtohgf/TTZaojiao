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
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getLessionID];
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
        [[TTUIChangeTool sharedTTUIChangeTool]backToLogReg];
    }else{
        UIStoryboard *storyBoardDongTai=[UIStoryboard storyboardWithName:@"WoStoryboard" bundle:nil];
        TTWoVipViewController *vipPayController = (TTWoVipViewController *)[storyBoardDongTai instantiateViewControllerWithIdentifier:@"VIPPAY"];
        [self.navigationController pushViewController:vipPayController animated:YES];
    }
}

-(void)addTableView{
    UITableView * tableView = [[UITableView alloc]init];
    _zaoJiaoTableView = tableView;
    
    CGFloat w=self.view.frame.size.width;
    CGFloat h=self.view.frame.size.height - self.tabBarController.tabBar.height - self.navigationController.navigationBar.height - [UIApplication sharedApplication].statusBarFrame.size.height;
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
        tmpcell.lession = _lessList[indexPath.section-1];
//        tmpcell.rightPushBtn.hidden = NO;
//        tmpcell.playLessionBtn.hidden = YES;
//        tmpcell.lessionIntroduce.hidden = NO;
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
    [TTLessionMngTool getLessionID:^(NSString *lessionID) {
        _lessionID = lessionID;
        //上周课程
        if (_sortSeg.selectedSegmentIndex == 0) {
            NSInteger tmdID = [_lessionID integerValue];
            tmdID = tmdID-1;
            if (tmdID < 0) {
                [MBProgressHUD TTDelayHudWithMassage:@"没有上周课程了" View:self.navigationController.view];
                return;
            }else{
                _lessionID = [NSString stringWithFormat:@"%ld", tmdID];
            }
        //下周课程
        }else if(_sortSeg.selectedSegmentIndex == 2)
        {
            NSInteger tmdID = [_lessionID integerValue];
            tmdID = tmdID + 1;
            if (tmdID > 100) {
                [MBProgressHUD TTDelayHudWithMassage:@"没有下周课程了" View:self.navigationController.view];
                return;
            }
            _lessionID = [NSString stringWithFormat:@"%ld", tmdID];
        }
        
        if (lessionID != nil) {
            [self getWeekLession:(_lessionID)];
        }else{
            [MBProgressHUD TTDelayHudWithMassage:@"账号信息不正确\n请重新登录" View:self.navigationController.view];
        }
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 0) {
        [self performSegueWithIdentifier:@"toPlayLession" sender:_lessList[indexPath.section-1]];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    TTZaojiaoPlayLessionController* desvc = segue.destinationViewController;
    
    desvc.lession = sender;
}

-(void)getWeekLession:(NSString*)lessionID{

    [MBProgressHUD showHUDAddedTo:self.navigationController.view  animated:YES];

    [TTLessionMngTool getWeekLessions:lessionID Result:^(NSMutableArray *lessions) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        if (lessions != nil) {
            _lessList = lessions;
            [_zaoJiaoTableView reloadData];
        }else{
            if (_sortSeg.selectedSegmentIndex == 0) {
                [MBProgressHUD TTDelayHudWithMassage:@"没有上周课程了" View:self.navigationController.view];
            }else            if (_sortSeg.selectedSegmentIndex == 2) {
                [MBProgressHUD TTDelayHudWithMassage:@"没有下周课程了" View:self.navigationController.view];
            }
        }
    }];

}


@end
