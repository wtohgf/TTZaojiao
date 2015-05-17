//
//  TTWoTempTestSubmitController.m
//  TTzaojiao
//
//  Created by hegf on 15-5-17.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoTempTestSubmitController.h"
#import "TTWoTempTestAnswerCell.h"
#import "TTWoGrowTestIntroduceCell.h"

@interface TTWoTempTestSubmitController ()
@property (weak, nonatomic) IBOutlet UITableView *tempTestTableView;

@end

#define kTemperTestIntroduceTitle @"气质情绪测评"
#define kTemperTestIntroduceContent @"    宝宝的气质类型是无所谓好或坏的，只要实施科学的教育，每一种气质类型的孩子都能成才。对幼儿的教育必须考虑到每个幼儿的气质特点，只有在了解儿童心里发展的年龄特征基础上，全面充分地了解每个孩子的气质特征，才能找到适合自己孩子的有针对性的教育方法，也才能培养出社会所需要的人才。总而言之，做到因气质类型不同而施教，会使孩子更健康快乐地成长。"

@implementation TTWoTempTestSubmitController

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
    
    _tempTestTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, self.view.width, 30.f);
    headerView.backgroundColor =  [UIColor colorWithRed:247.f/255.f green:215.f/255.f blue:226.f/255.f alpha:1.f];
    
    UILabel* title = [[UILabel alloc]init];
    [headerView addSubview:title];
    title.font = [UIFont systemFontOfSize:14.f];
    title.text = kTemperTestIntroduceTitle;
    title.textColor = [UIColor colorWithRed:174.f/255.f green:68.f/255.f blue:77.f/255.f alpha:1.f];
    
    title.frame = CGRectMake(0, 0, self.view.width*0.5, 30.f);
    title.textAlignment = NSTextAlignmentCenter;
    
    UIButton* button = [[UIButton alloc]init];
    [headerView addSubview:button];
    [button setImage:[UIImage imageNamed:@"point"] forState:UIControlStateNormal];
    [button setTitle:@"活动性" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:174.f/255.f green:68.f/255.f blue:77.f/255.f alpha:1.f] forState:UIControlStateNormal];
    button.frame = CGRectMake(self.view.width*0.5, 0, self.view.width*0.5, 30.f);
    button.titleLabel.font = [UIFont systemFontOfSize:14.f];
    button.backgroundColor =  [UIColor colorWithRed:247.f/255.f green:215.f/255.f blue:226.f/255.f alpha:1.f];
    button.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* tmpcell;
    if (indexPath.row == 0) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"shuomingCell"];
        tmpcell = cell;
    }
    if (indexPath.row == 1) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"questionCell"];
        tmpcell = cell;
    }
    
    if (indexPath.row == 2) {
        TTWoTempTestAnswerCell* cell = [tableView dequeueReusableCellWithIdentifier:@"anwserCell"];
        tmpcell = cell;
    }
    
    if (indexPath.row == 3) {
        TTWoGrowTestIntroduceCell* cell = [TTWoGrowTestIntroduceCell woGrowTestIntroduceCellWithTableView:tableView];
        NSDictionary* dict = @{
                               @"title":kTemperTestIntroduceTitle,
                               @"content":kTemperTestIntroduceContent
                               };
        cell.titleContent = dict;
        tmpcell = cell;
    }
    return tmpcell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 25.f;
    }
    if (indexPath.row == 1) {
        return 140.f;
    }
    if (indexPath.row == 2) {
        return 178.f;
    }
    if (indexPath.row == 3) {
        NSDictionary* dict = @{
                               @"title":kTemperTestIntroduceTitle,
                               @"content":kTemperTestIntroduceContent
                               };
        [TTWoGrowTestIntroduceCell cellHeightWith:dict];
    }
    return 0.f;
}
@end
