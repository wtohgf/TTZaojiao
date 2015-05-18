//
//  LaMaDetailViewController.m
//  TTzaojiao
//
//  Created by dalianembeded on 15/4/28.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "LaMaDetailViewController.h"
#import "LamaTableViewCellModelFrame.h"
#import "LamaTableViewCellNameAndPic.h"
#import "LamaTableViewCellPicList.h"
#import "LamaTableViewCellContent.h"
#import "LamaTableViewCellContact.h"
#import "LamaTableViewCellLabel.h"

#import <UIImageView+WebCache.h>
@interface LaMaDetailViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic)  UITableView *tableView;
@property (nonatomic,strong) LamaTableViewCellModelFrame *modelFrame;
@end
@implementation LaMaDetailViewController
#pragma mark 模型初始化
- (LamaTableViewCellModelFrame *)modelFrame
{
    if (_modelFrame == nil) {
        LamaTableViewCellModelFrame *modelFrame = [[ LamaTableViewCellModelFrame alloc]init];
        _modelFrame = modelFrame;
        modelFrame.NameAndPicCellHeight = 200;
        modelFrame.i_picFrame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
        modelFrame.i_nameFrame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 100);
        modelFrame.i_PicListFrame = CGRectMake(0, 0,  [UIScreen mainScreen].bounds.size.width, 100);
        modelFrame.i_contentFrame = CGRectMake(0, 0,  [UIScreen mainScreen].bounds.size.width, 100);
    }
    return _modelFrame;
}
#pragma mark
-(void)viewDidLoad
{
    [super viewDidLoad];
    UITableView * tableView = [[UITableView alloc]init];
    tableView.frame = self.view.frame;
    _tableView = tableView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    self.title = @"详情";
    
    [self modelFrame];
    // NSString* i_id = _ttid;
    //    NSString* i_id = [NSString stringWithFormat:@"%d",[_ttid intValue] + 1 ];
    NSDictionary* parameters = @{
                                 @"i_id":_ttid
                                 };
    //加载网络数据
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[AFAppDotNetAPIClient sharedClient]apiGet:GET_LIST_ACTIVE_SHOW   Parameters:parameters Result:^(id result_data, ApiStatus result_status, NSString *api) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (result_status == ApiStatusSuccess) {
            //获取纯数据模型
            LaMaDetailModel *model =   [LaMaDetailModel  LaMaDetailModelWithDict:(NSDictionary *)result_data[0]];
            //计算frame
            _modelFrame.model = model;
            
            
            [_tableView reloadData];
            
            
        }else{
            if (result_status != ApiStatusNetworkNotReachable) {
                [[[UIAlertView alloc]init] showWithTitle:@"友情提示" message:@"服务器好像罢工了" cancelButtonTitle:@"重试一下"];
            }
        };
    }];

}

#pragma mark
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma tableview 数据源以及代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_modelFrame == nil) {
        return  1;
    }
    else
    {
        return self.modelFrame.model.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //创建相应cell－－NameAndPic
    if (indexPath.row == 0) {
        LamaTableViewCellNameAndPic *cell = [LamaTableViewCellNameAndPic LamaTableViewCellNameAndPicWithTabelView:_tableView];
        //数据传给cell，由cell处理设置
        cell.modelFrame = _modelFrame;
        return cell;
    }
    //创建相应cell－－活动详情
    else if (indexPath.row == 1)
    {
        LamaTableViewCellLabel *cell = [LamaTableViewCellLabel LamaTableViewCellContactWithTabelView:_tableView];
        cell.label.text = @"活动详情";
        cell.backgroundColor =  [UIColor colorWithRed:(233/255.0) green:(233/255.0) blue:(233/255.0) alpha:(233/255.0)];
        return cell;
        
    }
    //创建相应cell－－联系人
    else if(indexPath.row == (self.modelFrame.model.count - 1))
    {
        
        
        LamaTableViewCellContact *cell = [LamaTableViewCellContact LamaTableViewCellContactWithTabelView:_tableView];
        //数据传给cell，由cell处理设置
        cell.modelFrame = _modelFrame;
        return cell;
        
    }
    //创建相应cell－－商家信息
    else if (indexPath.row == self.modelFrame.model.count - 2)
    {
        LamaTableViewCellLabel *cell = [LamaTableViewCellLabel LamaTableViewCellContactWithTabelView:_tableView ];
        cell.label.text = @"商家信息";
        return cell;
    }
    //创建相应cell－－图片list
    else if (indexPath.row == (self.modelFrame.model.count - 3))
    {
        
        LamaTableViewCellContent *cell = [LamaTableViewCellContent LamaTableViewCellContentWithTabelView:_tableView];
        //数据传给cell，由cell处理设置
        cell.modelFrame = _modelFrame;
        return cell;
        
    }
    
    else
    {
        LamaTableViewCellPicList *cell = [LamaTableViewCellPicList LamaTableViewCellPicListWithTabelView:_tableView];
        NSString *name  = _modelFrame.picListArray[indexPath.row-1];
        NSString *url = [NSString stringWithFormat:@"%@%@",TTBASE_URL,name];
        [cell.picListView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default_pic"]];
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 ) {
        return  self.modelFrame.NameAndPicCellHeight;
    }
    else if(indexPath.row == 1)
    {
        return 30;
    }
    
    else if(indexPath.row == self.modelFrame.model.count - 1)
    {
        return 60+47*2+10;
        
    }
    else if (indexPath.row == self.modelFrame.model.count - 2)
    {
        return 30;
    }
    else if (indexPath.row == self.modelFrame.model.count - 3)
    {
        return self.modelFrame.i_contentFrame.size.height+5;
    }
    else
    {
        return  self.modelFrame.i_PicListFrame.size.height + 5;
    }
    
}
@end
