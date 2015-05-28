//
//  TTWoGrowTestReportViewController.m
//  TTzaojiao
//
//  Created by hegf on 15-5-16.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoGrowTestReportViewController.h"
#import "TTGrowTemperTestTool.h"
#import "NSString+Extension.h"
#import "TTWoGrowTestReportTigeCellTableViewCell.h"
#import "TTWoGrowTestReportShengaoCellTableViewCell.h"
#import "TTWoGrowTestReportTizhongCellTableViewCell.h"
#import "TTWoGrowTestReportFrame.h"
#import "TTWoGrowTestReportModel.h"
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

@interface TTWoGrowTestReportViewController (){
    NSDictionary* _reportDict;
}

@property (weak, nonatomic) UILabel* mounth;
@property (weak, nonatomic) UILabel* date;
@property (weak, nonatomic) UILabel* result;

@property (weak, nonatomic) UITableView *growReportTableView;
@property (nonatomic,strong) TTWoGrowTestReportFrame *modelFrame;
@end

@implementation TTWoGrowTestReportViewController

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
    
    UITableView* tableView = [[UITableView alloc]init];
    [self.view addSubview:tableView];
    _growReportTableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    CGFloat w=screenWidth;
    CGFloat h=screenHeight-49.f-64.f;
    
    _growReportTableView.frame = CGRectMake(0, 0, w, h);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [TTGrowTemperTestTool getTestReportWithResultID:_resultID Result:^(id testlist) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([testlist isKindOfClass:[NSDictionary class]]) {
            _reportDict = testlist;
            //字典转模型，算好高度，加载
            TTWoGrowTestReportModel *model = [ TTWoGrowTestReportModel WoGrowTestReportModelWithDict: _reportDict];
            TTWoGrowTestReportFrame *modelFrame = [[TTWoGrowTestReportFrame alloc]init];
            
           
            modelFrame.model = model;
            _modelFrame = modelFrame;
            [_growReportTableView reloadData];
        }else{
            if ([testlist isKindOfClass:[NSString class]]) {
                if ([testlist isEqualToString:@"neterror"]) {
                    [MBProgressHUD TTDelayHudWithMassage:@"网络连接错误 请检查网络" View:self.view];
                }else{
                    [MBProgressHUD TTDelayHudWithMassage:@"测试历史获取失败" View:self.view];
                }
            }
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_modelFrame == nil) {
        return 100;
    }
    else if (indexPath.row == 0) {
        
            return _modelFrame.shengaotizhongFrame.size.height+_modelFrame.tigePicHeight+30;
        }
    
    else if (indexPath.row == 1)
    {
        
            return _modelFrame.shengaonianlingFrame.size.height+_modelFrame.nianlingPicHeight+30;
       
    }
    
    else
    {
        return _modelFrame.tizhongnianlingFrame.size.height+_modelFrame.nianlingPicHeight+30;
    }
    
    //[TTUserModelTool sharedUserModelTool].logonUser.gender
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TTWoGrowTestReportTigeCellTableViewCell* cell = [TTWoGrowTestReportTigeCellTableViewCell WoGrowTestReportTigeCellWithTabelView:tableView];
        if (_modelFrame != nil) {
            cell.modelFrame = _modelFrame;
            
        }
        return cell;
   
     }
    else if (indexPath.row == 1) {
        TTWoGrowTestReportShengaoCellTableViewCell* cell = [TTWoGrowTestReportShengaoCellTableViewCell WoGrowTestReportShengaoCellWithTabelView:tableView];
        if (_modelFrame != nil) {
            cell.modelFrame = _modelFrame;
        }
        
        return cell;
    }
    
    else{
        TTWoGrowTestReportTizhongCellTableViewCell* cell = [TTWoGrowTestReportTizhongCellTableViewCell WoGrowTestReportTizhongCellWithTabelView:tableView];
        if (_modelFrame != nil) {
            cell.modelFrame = _modelFrame;
        }
        
        return cell;
    }

}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
       return 140.f;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithRed:239.f/255.f green:239.f/255.f blue:244.f/255.f alpha:1.f];
    
    headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 140.f);
    
    UIView* subHeaderView = [[UIView alloc]init];
    [headerView addSubview:subHeaderView];
    subHeaderView.frame = CGRectMake(0, 20.f, self.view.frame.size.width, 100.f);
    subHeaderView.backgroundColor = [UIColor whiteColor];
 
    UILabel* mountTitle = [[UILabel alloc]init];
    [subHeaderView addSubview:mountTitle];
    mountTitle.text = @"宝宝月龄:";
    mountTitle.font = [UIFont systemFontOfSize:16.f];
    mountTitle.textAlignment = NSTextAlignmentRight;
    mountTitle.frame = CGRectMake(0, 5, self.view.frame.size.width*0.5, 30.f);
    
    UILabel* dateTitle = [[UILabel alloc]init];
    [subHeaderView addSubview:dateTitle];
    dateTitle.text = @"测评日期:";
    dateTitle.font = [UIFont systemFontOfSize:16.f];
    dateTitle.textAlignment = NSTextAlignmentRight;
    dateTitle.frame = CGRectMake(0, mountTitle.bottom, self.view.frame.size.width*0.5, 30.f);
    
    UILabel* resultTitle = [[UILabel alloc]init];
    [subHeaderView addSubview:resultTitle];
    resultTitle.text = @"测评结果:";
    resultTitle.font = [UIFont systemFontOfSize:16.f];
    resultTitle.textAlignment = NSTextAlignmentRight;
    resultTitle.frame = CGRectMake(0, dateTitle.bottom, self.view.frame.size.width*0.5, 30.f);
    
    UILabel* mounth = [[UILabel alloc]init];
    _mounth = mounth;
    [subHeaderView addSubview:mounth];
    mounth.font = [UIFont systemFontOfSize:16.f];
    mounth.textAlignment = NSTextAlignmentLeft;
    mounth.frame = CGRectMake(self.view.frame.size.width*0.5 +10.f, mountTitle.up, self.view.frame.size.width*0.5-10.f, 30.f);
    
    UILabel* date = [[UILabel alloc]init];
    _date = date;
    [subHeaderView addSubview:date];
    date.font = [UIFont systemFontOfSize:16.f];
    date.textAlignment = NSTextAlignmentLeft;
    date.frame = CGRectMake(self.view.frame.size.width*0.5+10.f, dateTitle.up, self.view.frame.size.width*0.5-10.f, 30.f);
    
    UILabel* result = [[UILabel alloc]init];
    _result = result;
    [subHeaderView addSubview:result];
    result.font = [UIFont systemFontOfSize:16.f];
    result.textAlignment = NSTextAlignmentLeft;
    result.frame = CGRectMake(self.view.frame.size.width*0.5+10.f, resultTitle.up, self.view.frame.size.width*0.5-10.f, 30.f);
    [self updateHeader];
    return headerView;
}
/*
 Printing description of testlist:
 {
 Height = 115;
 TestDate = "2015-5-16 17:27:14";
 Weight = 22;
 id = 6272;
 "tige_shengao_content" = "\U60a8\U7684\U5b9d\U5b9d\U8eab\U9ad8\U9ad8\U4e8e\U6b63\U5e38\U8303\U56f4\Uff0c\U73b0\U6709\U8eab\U9ad8\U6c34\U5e73\U6bd4\U5e74\U9f84\U5e73\U5747\U503c\U8fc7\U9ad8\Uff0c\U5728\U540c\U9f84\U4eba\U5f53\U4e2d\U5c5e\U4e8e\U9ad8\U4e2a\U5b50\U3002";
 "tige_sort" = "\U6b63\U5e38";
 "tige_sort_content" = "\U5b9d\U5b9d\U7684\U4f53\U91cd\U4e0e\U73b0\U6709\U8eab\U9ad8\U6c34\U5e73\U76f8\U5f53\Uff0c\U53d1\U80b2\U6b63\U5e38\Uff0c\U98df\U6b32\U6b63\U5e38\Uff0c\U9762\U8272\U7ea2\U6da6\Uff0c\U5bf9\U73af\U5883\U53cd\U5e94\U6b63\U5e38\Uff0c\U6ce8\U610f\U5408\U7406\U81b3\U98df\U3002";
 "tige_sort_content_2" = "";
 "tige_tizhong_content" = "\U60a8\U7684\U5b9d\U5b9d\U4f53\U91cd\U9ad8\U4e8e\U6b63\U5e38\U8303\U56f4\Uff0c\U73b0\U6709\U4f53\U91cd\U6c34\U5e73\U6bd4\U5e74\U9f84\U5e73\U5747\U503c\U8fc7\U9ad8\U3002";
 yueling = 6;
 }
 */
-(void)updateHeader{
    
    [_mounth setText: [NSString stringWithFormat:@"%@个月", [_reportDict objectForKey:@"yueling"]]];
    
    _date.text = [NSString getChnYMDWithString:[_reportDict objectForKey:@"TestDate"]];
    
    _result.text = [_reportDict objectForKey:@"tige_sort"];
       
}

-(void)dealloc{
    _reportDict = nil;
    _modelFrame = nil;
}

@end
