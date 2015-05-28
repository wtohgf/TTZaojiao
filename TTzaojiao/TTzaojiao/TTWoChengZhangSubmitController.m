//
//  TTWoChengZhangSubmitController.m
//  TTzaojiao
//
//  Created by hegf on 15-5-17.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoChengZhangSubmitController.h"
#import "TTWoGrowTestStartCell.h"
#import "TTWoGrowTestWeightCell.h"
#import "TTWoGrowTestHeightCell.h"
#import "TTGrowTemperTestTool.h"
#import "TTWoGrowTestReportViewController.h"
#import "TTWoGrowTestIntroduceCell.h"

@interface TTWoChengZhangSubmitController (){
    NSString* _weihgt;
    NSString* _height;
    NSArray* _growTestIntroList;
}
@property (weak, nonatomic) IBOutlet UITableView *chengZhangSubmintTableView;

@end

@implementation TTWoChengZhangSubmitController

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
    
    _chengZhangSubmintTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString* path = [[NSBundle mainBundle]pathForResource:@"GrowTestTitleContent.plist" ofType:nil];
    _growTestIntroList = [NSArray arrayWithContentsOfFile:path];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [super viewWillDisappear:animated];
    _growTestIntroList = nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString* ID = @"HEIGHTCELL";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
        return cell;
    }else if(indexPath.row == 1)
    {
        static NSString* ID = @"WEIGHTCELL";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
        return cell;
        
    }else if(indexPath.row == 2){
        static NSString* ID = @"STARTTESTCELL";
        TTWoGrowTestStartCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
        __weak id weakSelf = self;
        cell.block = ^(){
            [weakSelf startGrowTest];
        };
        return cell;
    }else{
        TTWoGrowTestIntroduceCell* cell = [TTWoGrowTestIntroduceCell woGrowTestIntroduceCellWithTableView:tableView];
        cell.titleContent = _growTestIntroList[indexPath.row-3];
        return cell;
   }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 44.f;
    }else if(indexPath.row == 1)
    {
        return 44.f;
        
    }else if(indexPath.row == 2){
        return 66.f;
    }else{
        return [TTWoGrowTestIntroduceCell cellHeightWith:_growTestIntroList[indexPath.row-3]];
    }
}

- (void)startGrowTest{
    
    TTWoGrowTestHeightCell* heightCell = (TTWoGrowTestHeightCell*)[_chengZhangSubmintTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    TTWoGrowTestWeightCell* weightCell = (TTWoGrowTestWeightCell*)[_chengZhangSubmintTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    [heightCell.hegiht resignFirstResponder];
    [weightCell.weight resignFirstResponder];
    
    _height =  heightCell.hegiht.text;
    if (_height.length == 0) {
        [MBProgressHUD TTDelayHudWithMassage:@"请输入身高" View:self.view];
        return;
    }
    if ([_height integerValue] < 50 || [_height integerValue]>120) {
        [MBProgressHUD TTDelayHudWithMassage:@"请输入50至120厘米之间的身高" View:self.view];
        return;
    }
    
    _weihgt =  weightCell.weight.text;
    if (_weihgt.length == 0) {
        [MBProgressHUD TTDelayHudWithMassage:@"请输入体重" View:self.view];
        return;
    }
    if ([_weihgt integerValue] < 3 || [_weihgt integerValue]>22) {
        [MBProgressHUD TTDelayHudWithMassage:@"请输入3～22千克之间的体重" View:self.view];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [TTGrowTemperTestTool submitGrowTestWithWeight:_weihgt Height:_height  Result:^(id testlist) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([testlist isKindOfClass:[NSDictionary class]]) {
            NSString* resultID = [testlist objectForKey:@"msg_word"];
            [TTUIChangeTool sharedTTUIChangeTool].isneedUpdateUI = YES;
            [self performSegueWithIdentifier:@"SUBMITTOGROWREPORT" sender:resultID];
        }else{
            if ([testlist isKindOfClass:[NSString class]]) {
                if ([testlist isEqualToString:@"neterror"]) {
                    [MBProgressHUD TTDelayHudWithMassage:@"网络连接错误 请检查网络" View:self.view];
                }else if([testlist isEqualToString:@"error"]){
                    [MBProgressHUD TTDelayHudWithMassage:@"测评失败" View:self.view];
                }else{
                    [MBProgressHUD TTDelayHudWithMassage:testlist View:self.view];
                }
            }
        }
    }];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[TTWoGrowTestReportViewController class]]) {
        TTWoGrowTestReportViewController* vc = segue.destinationViewController;
        vc.resultID = sender;
    }
}

-(void)dealloc{
    
}
@end
