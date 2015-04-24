//
//  TTLaMaViewController.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/4/21.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTLaMaViewController.h"
#import "CityListViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "LamaModel.h"
#import "LamaTotalModel.h"
#import "UserModel.h"
#import "TTBaseViewController.h"
#import "LamaTableViewCell.h"

@interface TTLaMaViewController () <CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UILabel *locationCity;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *models;
@end

@implementation TTLaMaViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //加载网络数据
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[AFAppDotNetAPIClient sharedClient]apiGet:GET_LIST_ACTIVE Parameters:nil Result:^(id result_data, ApiStatus result_status, NSString *api) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (result_status == ApiStatusSuccess) {
            //
            // NSLog(@"%@",result_data);
            
            if ([result_data isKindOfClass:[NSMutableArray class]]) {
                
                //暂时不知道有什么用途
                //              LamaTotalModel *total= [LamaTotalModel LamaTotalModelWithdict:result_data[0]];
                
                //数据模型数组制作
                NSMutableArray * dataArray = result_data;
                NSMutableArray *tempArray = [NSMutableArray array];
                for (int i = 1; i < dataArray.count; i++) {
                    LamaModel *lama = [LamaModel LamaModelWithDict:result_data[i]];
                    [tempArray addObject:lama];
                }
                
                _models = tempArray;
                NSLog(@"count is %zi",_models.count);
                
                //当前用户信息
                //UserModel *user = [TTUserModelTool sharedUserModelTool].logonUser;
                // NSLog(@"%@ %@", user.name, user.icon);
                [_tableView reloadData];
                
            }
            
            
        }else{
            if (result_status != ApiStatusNetworkNotReachable) {
                [[[UIAlertView alloc]init] showWithTitle:@"友情提示" message:@"服务器好像罢工了" cancelButtonTitle:@"重试一下"];
            }
        };
    }];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self startLocation];
    
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 150;
    
    if(([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars
        = NO;
        self.modalPresentationCapturesStatusBarAppearance
        = NO;
    }
    
   

    
}


//懒加载模型
- (NSMutableArray *)models
{
    
    
    return _models;

}


#pragma tableview 数据源以及代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //create cell
    
    LamaTableViewCell *cell = [LamaTableViewCell lamaCellWithTabelView:tableView];

    //data
   LamaModel * model=
    _models[indexPath.row];
    
    //set cell
    cell.lamaModel = model;
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect headerFrame = CGRectMake(0, 0, tableView.frame.size.width, 44.f);
    _headerView.frame = headerFrame;
    return _headerView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.f;
}

- (IBAction)locationAction:(id)sender {
    [self performSegueWithIdentifier:@"cityListSegue" sender:self];
}

//开始定位
-(void)startLocation{
    
    if ([CLLocationManager locationServicesEnabled])
    {
        if (!self.locationManager)
        {
            self.locationManager = [[CLLocationManager alloc] init];
        }
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter=1.0;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [self.locationManager requestAlwaysAuthorization]; // 永久授权
            [self.locationManager requestWhenInUseAuthorization]; //使用中授权
        }
        
        [self.locationManager startUpdatingLocation];//开启位置更新
    }
}

//定位代理经纬度回调
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [_locationManager stopUpdatingLocation];
    
    CLLocation *newLocation = [locations lastObject];
    NSLog(@"%@",[NSString stringWithFormat:@"经度:%3.5f\n纬度:%3.5f",newLocation.coordinate.latitude,newLocation.coordinate.longitude]);
    
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        for (CLPlacemark * placemark in placemarks) {
            
            NSDictionary *test = [placemark addressDictionary];
            
            _locationCity.text = [test objectForKey:@"City"];
    
            //  Country(国家)  State(城市)  SubLocality(区)
            
            NSLog(@"\n国家:%@\n省:%@\n城市:%@\n街道:%@", [test objectForKey:@"Country"],[test objectForKey:@"State"],[test objectForKey:@"City"],[test objectForKey:@"Street"]);
            
        }
    }];
}

@end
