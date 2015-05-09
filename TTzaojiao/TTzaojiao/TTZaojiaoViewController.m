//
//  TTZaojiaoViewController.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/4/21.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTZaojiaoViewController.h"
#import <MJRefresh.h>

#define kSectionMargin 8.f

@interface TTZaojiaoViewController ()
@property (weak, nonatomic) UITableView* zaoJiaoTableView;
@property (weak, nonatomic) UIView* customHeaderView;
@property (weak, nonatomic) UISegmentedControl* sortSeg;
@property (copy, nonatomic) NSString* i_sort;
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
    UIStoryboard *storyBoardDongTai=[UIStoryboard storyboardWithName:@"WoStoryboard" bundle:nil];
    TTWoVipViewController *vipPayController = (TTWoVipViewController *)[storyBoardDongTai instantiateViewControllerWithIdentifier:@"VIPPAY"];
    [self.navigationController pushViewController:vipPayController animated:YES];
}

-(void)addTableView{
    UITableView * tableView = [[UITableView alloc]init];
    _zaoJiaoTableView = tableView;
    
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

-(UIView*)tableViewHeader{
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
    sortSeg.selectedSegmentIndex = 0;
    [view addSubview:sortSeg];
    
    return view;
    
}

- (void)selChanged:(UISegmentedControl *)sender {
    
    _i_sort = [NSString stringWithFormat:@"%ld", sender.selectedSegmentIndex + 1];
    
    [self getLessionID];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [self tableViewHeader];
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
        if (lessionID != nil) {
            [self getWeekLession:(lessionID)];
        }else{
            [MBProgressHUD TTDelayHudWithMassage:@"账号信息不正确\n请重新登录" View:self.navigationController.view];
        }
    }];
}

-(void)getWeekLession:(NSString*)lessionID{

    [MBProgressHUD showHUDAddedTo:self.navigationController.view  animated:YES];

    [TTLessionMngTool getWeekLessions:lessionID Result:^(NSMutableArray *lessions) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        if (lessions != nil) {
            _lessList = lessions;
            [_zaoJiaoTableView reloadData];
        }else{
            [MBProgressHUD TTDelayHudWithMassage:@"获取课程失败" View:self.navigationController.view];
        }
    }];

}

@end
