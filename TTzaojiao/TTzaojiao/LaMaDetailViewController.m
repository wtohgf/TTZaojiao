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
#import <UIImageView+WebCache.h>
@interface LaMaDetailViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic)  UITableView *tableView;
@property (nonatomic,strong) LamaTableViewCellModelFrame *modelFrame;
@end
@implementation LaMaDetailViewController

- (LamaTableViewCellModelFrame *)modelFrame
{
    if (_modelFrame == nil) {
        LamaTableViewCellModelFrame *modelFrame = [[ LamaTableViewCellModelFrame alloc]init];
        _modelFrame = modelFrame;
        modelFrame.NameAndPicCellHeight = 200;
        modelFrame.i_picFrame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
        modelFrame.i_nameFrame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 100);
        modelFrame.i_PicListFrame = CGRectMake(0, 0,  [UIScreen mainScreen].bounds.size.width, 100);
       
    }
    return _modelFrame;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    UITableView * tableView = [[UITableView alloc]init];
    tableView.frame = self.view.frame;
    _tableView = tableView;
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;

}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
   
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
    
    else
    {
       
        return  self.modelFrame.i_PicListFrame.size.height;
    }
    
}
@end
