//
//  TTDongTaiViewController.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/4/21.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTDongTaiViewController.h"
#import "TTDongtaiTableViewCell.h"
#import "TTDongtaiCommentTableViewCell.h"
#import "TTDongtaiPraiseTableViewCell.h"
#import "BlogModel.h"


@interface TTDongTaiViewController (){
    NSMutableArray* _blogs;
    NSUInteger _pageIndexInt;
    NSString* _i_sort;
    NSString* _group;
}
@property (weak, nonatomic) IBOutlet UITableView *dongtaiTable;

@end

@implementation TTDongTaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _i_sort = @"0";
    _group = @"0";
    _pageIndexInt = 0;
    _blogs = [NSMutableArray array];
    [self updateBlog];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _pageIndexInt = 0;
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
        [MBProgressHUD hideHUDForView:_dongtaiTable animated:YES];
        if (result_status == ApiStatusSuccess) {
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                [result_data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([obj isKindOfClass:[BlogModel class]]) {
                        [_blogs addObject:obj];
                    }
                }];

                [_dongtaiTable reloadData];
            }
            
        }else{
            if (result_status != ApiStatusNetworkNotReachable) {
                [[[UIAlertView alloc]init] showWithTitle:@"友情提示" message:@"服务器好像罢工了" cancelButtonTitle:@"重试一下"];
            }
        };
    }];

    _pageIndexInt++;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView* view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.f)];
        view1.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
        
        NSArray* items = @[@"早教自拍", @"课程提问", @"宝宝生活", @"附近宝宝"];
        UISegmentedControl* sortSeg = [[UISegmentedControl alloc]initWithItems:items];
        sortSeg.frame = CGRectMake(40, 4, view1.frame.size.width-80, view1.frame.size.height-8);
        [sortSeg addTarget:self action:@selector(selChanged:) forControlEvents:UIControlEventValueChanged];
        [view1 addSubview:sortSeg];
        return view1;
    }
    return [[UIView alloc]initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 44.f;
    }
    return 0.f;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    UITableViewCell* retruncell = nil;
    BlogModel* blog = _blogs[indexPath.section];
    
    switch (indexPath.row) {
        case 0:
        {
            TTDongtaiTableViewCell* cell = [TTDongtaiTableViewCell dongtaiTableViewCellWithTableView:tableView pics:blog.i_pic];
            cell.blogModel = _blogs[indexPath.section];
            retruncell = cell;
        }
            break;
        case 1:
        {
            TTDongtaiPraiseTableViewCell* cell = [TTDongtaiPraiseTableViewCell dongtaiTableViewCellWithTableView:tableView];
            cell.blogModel = _blogs[indexPath.section];
            retruncell = cell;
        }
            break;
        case 2:
        {
            BlogModel* blog = _blogs[indexPath.section];
            NSArray* replay = blog.replay;
            TTDongtaiCommentTableViewCell* cell = [TTDongtaiCommentTableViewCell dongtaiTableViewCellWithTableView:tableView];
            BlogReplayModel* mode = [BlogReplayModel blogReplayModelWithDict:[replay objectAtIndex:0]];
            cell.blogReplayModel = mode;
            retruncell = cell;
        }
            break;
        case 3:
        {
            BlogModel* blog = _blogs[indexPath.section];
            NSArray* replay = blog.replay;
            TTDongtaiCommentTableViewCell* cell = [TTDongtaiCommentTableViewCell dongtaiTableViewCellWithTableView:tableView];
            BlogReplayModel* mode = [BlogReplayModel blogReplayModelWithDict:[replay objectAtIndex:1]];
            cell.blogReplayModel = mode;
            retruncell = cell;
        }
            break;
        case 4:
        {
            BlogModel* blog = _blogs[indexPath.section];
            NSArray* replay = blog.replay;
            TTDongtaiCommentTableViewCell* cell = [TTDongtaiCommentTableViewCell dongtaiTableViewCellWithTableView:tableView];
            BlogReplayModel* mode = [BlogReplayModel blogReplayModelWithDict:[replay objectAtIndex:2]];
            cell.blogReplayModel = mode;
            retruncell = cell;
        }
            break;
        default:
            break;
    }
    
    return retruncell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BlogModel* model = _blogs[section];
    NSArray* replay =  model.replay;
    if (replay.count>=3) {
        return 5;
    }
    return 2+replay.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _blogs.count;
}

- (void)selChanged:(UISegmentedControl *)sender {
    _i_sort = [NSString stringWithFormat:@"%ld", sender.selectedSegmentIndex];
}

@end
