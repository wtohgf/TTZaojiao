//
//  TTWoChengZhangViewController.m
//  TTzaojiao
//
//  Created by hegf on 15-5-16.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoChengZhangViewController.h"
#import "TTWoChengzhangHistoryCell.h"
#import "TTGrowTemperTestTool.h"
#import <MJRefresh.h>

@interface TTWoChengZhangViewController (){
    NSString* _pageIndex;
    NSMutableArray* _testHistoryList;
}
@property (weak, nonatomic) IBOutlet UITableView *chengzhangTableView;

@end

@implementation TTWoChengZhangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars
        = NO;
        self.modalPresentationCapturesStatusBarAppearance
        = NO;
    }
    
    _chengzhangTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [self setupRefresh];
}

-(void)setupRefresh{
    [_chengzhangTableView addLegendHeaderWithRefreshingBlock:^{
        [_chengzhangTableView.header beginRefreshing];
        _pageIndex = @"1";
        [self updateTestList];
    }];
    
    [_chengzhangTableView  addLegendFooterWithRefreshingBlock:^{
        [_chengzhangTableView.footer beginRefreshing];
        NSUInteger index = [_pageIndex integerValue]+1;
        _pageIndex = [NSString stringWithFormat:@"%ld", index];
        [self updateTestList];
    }];
}

-(void)updateTestList{
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [TTGrowTemperTestTool getTestListWithPageindex:_pageIndex Result:^(id testlist) {
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        [_chengzhangTableView.header endRefreshing];
        [_chengzhangTableView.footer endRefreshing];
        if ([testlist isKindOfClass:[NSMutableArray class]]) {
            if ([_pageIndex isEqualToString:@"1"]) {
                _testHistoryList = [testlist mutableCopy];
            }else{
                [_testHistoryList addObjectsFromArray:testlist];
            }
            [_chengzhangTableView reloadData];
        }else{
            if ([testlist isKindOfClass:[NSString class]]) {
                if ([testlist isEqualToString:@"neterror"]) {
                    [MBProgressHUD TTDelayHudWithMassage:@"网络连接错误 请检查网络" View:self.navigationController.view];
                }else{
                    [MBProgressHUD TTDelayHudWithMassage:@"测试历史获取失败" View:self.navigationController.view];
                }
            }
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _pageIndex = @"1";
    [self updateTestList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTWoChengzhangHistoryCell* cell = [TTWoChengzhangHistoryCell woChengzangHistoryCellWithTableView:tableView];
    cell.growTestDict = _testHistoryList[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _testHistoryList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithRed:239.f/255.f green:239.f/255.f blue:244.f/255.f alpha:1.f];
    
    headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 100.f);
    
    [headerView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(startChengZhangtest)]];
    
    UIView* subHeaderView = [[UIView alloc]init];
    [headerView addSubview:subHeaderView];
    subHeaderView.frame = CGRectMake(0, 17.f, self.view.frame.size.width, 66.f);
    subHeaderView.backgroundColor = [UIColor whiteColor];
    UIImageView* imageView = [[UIImageView alloc]init];
    [subHeaderView addSubview:imageView];
    [imageView setImage:[UIImage imageNamed:@"clock"]];
    imageView.frame = CGRectMake(33.f, 8.f, 50.f, 50.f);
    
    UIImageView* rightView = [[UIImageView alloc]init];
    [subHeaderView addSubview:rightView];
    
    [rightView setImage:[UIImage imageNamed:@"more_city"]];
    rightView.frame = CGRectMake(self.view.frame.size.width-17.f, 25.f, 9.f, 16.f);
    
    UILabel* label = [[UILabel alloc]init];
    [subHeaderView addSubview:label];
    
    label.text = @"立即开始测评";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16.f];
    label.textColor = [UIColor darkGrayColor];
    label.frame = CGRectMake(imageView.right, 17.f, self.view.frame.size.width - imageView.right - 17.f, 32.f);
    
    return headerView;
}

-(void)startChengZhangtest{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66.f;
}

@end
