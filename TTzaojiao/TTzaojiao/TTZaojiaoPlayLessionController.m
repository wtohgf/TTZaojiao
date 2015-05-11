//
//  TTZaojiaoPlayLessionController.m
//  TTzaojiao
//
//  Created by hegf on 15-5-11.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTZaojiaoPlayLessionController.h"
#import "TTDynamicReleaseViewController.h"

@interface TTZaojiaoPlayLessionController ()
@property (weak, nonatomic) UITableView* zaoJiaoPlayTableView;
@end

@implementation TTZaojiaoPlayLessionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加导航自定义栏
    [self addNavItems];
    
    //添加TableView
    [self addTableView];
}

- (void)addNavItems{
    self.title = @"早教课堂";
    
    UIBarButtonItem* itemright = [UIBarButtonItem barButtonItemWithImage:@"icon_add_dynamic_state" target:self action:@selector(dynamic_state:)];
    self.navigationItem.rightBarButtonItem = itemright;
    
}

-(void)dynamic_state:(UIBarButtonItem*)item{
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"DongTaiStoryboard" bundle:nil];
    TTDynamicReleaseViewController* rv = [storyBoard instantiateViewControllerWithIdentifier:@"DynamicReleaseViewController"];
    
    [self.navigationController pushViewController:rv animated:YES];
}

-(void)addTableView{
    UITableView * tableView = [[UITableView alloc]init];
    _zaoJiaoPlayTableView = tableView;
    
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
        if (_lession != nil) {
            TTPlayLessionHeaderCell* tmpcell = [TTPlayLessionHeaderCell playLessionHeaderCellWithTableView:tableView];
            tmpcell.lession = _lession;
//            tmpcell.lession = _lession;
//            tmpcell.rightPushBtn.hidden = YES;
//            tmpcell.lessionIntroduce.hidden = YES;
//            tmpcell.playLessionBtn.hidden = NO;
            cell = tmpcell;
        }else{
            UITableViewCell* tmpcell = [[UITableViewCell alloc]initWithFrame:CGRectZero];
            cell = tmpcell;
        }
    }else{

    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [TTPlayLessionHeaderCell cellHeight];
    }else{
        return 0;
    };
}
@end
