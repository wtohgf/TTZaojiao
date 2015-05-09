//
//  TTZaojiaoViewController.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/4/21.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTZaojiaoViewController.h"
#import <MJRefresh.h>

@interface TTZaojiaoViewController ()
@property (weak, nonatomic) UITableView* zaoJiaoTableView;
@property (weak, nonatomic) UIView* customHeaderView;
@property (weak, nonatomic) UISegmentedControl* sortSeg;
@property (copy, nonatomic) NSString* i_sort;
@end

@implementation TTZaojiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加导航自定义栏
    [self addNavItems];
    
    //添加TableView
    [self addTableView];
    
    //添加上下拉刷新
    [self setupRefresh];
    
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
    tableView.frame = self.view.frame;
    
    if(([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars
        = NO;
        self.modalPresentationCapturesStatusBarAppearance
        = NO;
    }
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [self.view addSubview:tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id cell = nil;
    if (indexPath.row == 0) {
        TTZaojiaoIntroduceCell* tmpcell = [TTZaojiaoIntroduceCell zaojiaoIntroduceCellWithTableView:tableView];
        tmpcell.logonUser = [TTUserModelTool sharedUserModelTool].logonUser;
        cell = tmpcell;
    }else{
   
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return [TTZaojiaoIntroduceCell cellHeightWithModel:[TTUserModelTool sharedUserModelTool].logonUser];
    }
    return 44.f;
}

-(void)setupRefresh{
    [_zaoJiaoTableView addLegendHeaderWithRefreshingBlock:^{
        [_zaoJiaoTableView.header beginRefreshing];
        [self updateModel];
    }];
    
    [_zaoJiaoTableView  addLegendFooterWithRefreshingBlock:^{
        [_zaoJiaoTableView.footer beginRefreshing];
        [self updateModel];
    }];
}

-(void)updateModel{
    
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
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self tableViewHeader];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.f;
}

@end
