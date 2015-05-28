//
//  TTWoVipPriceViewController.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/5/6.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoVipPriceViewController.h"
#import <RDVTabBarController.h>
#import "AFAppDotNetAPIClient.h"
#import "AlipayRequestConfig+TTAlipay.h"
#import "UIAlertView+MoreAttribute.h"
#import "MBProgressHUD+TTHud.h"

@interface TTWoVipPriceViewController ()
@property (strong, nonatomic) NSMutableArray *list;
@end

@implementation TTWoVipPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[AFAppDotNetAPIClient sharedClient] apiGet:VIP_PRICE Parameters:nil Result:^(id result_data, ApiStatus result_status, NSString *api) {
        if (result_status == ApiStatusSuccess) {
            NSMutableArray *list = [NSMutableArray arrayWithArray:result_data];
            [list removeObjectAtIndex:0];
            self.list = list;
            [self.tableView reloadData];
        }
        else {
            [MBProgressHUD TTDelayHudWithMassage:@"网络连接有问题 请检查网络" View:self.view];
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma table view

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _list.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VipPriceCell"];
    WoVipModel *model = (WoVipModel *)[_list objectAtIndex:indexPath.section];
    cell.textLabel.text = [NSString stringWithFormat:@"%@个月VIP早教服务",model.i_month];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元",model.i_price];
    return cell;
}
/*
 TTzaojiao[4099:1839278] result = {
 memo = "";
 result = "partner=\"2088711821877024\"&seller_id=\"273730638@qq.com\"&out_trade_no=\"-1478319783-40659-3\"&subject=\"\U5929\U5929\U65e9\U6559VIP\U670d\U52a1\"&body=\"3\U4e2a\U6708VIP\U670d\U52a1\"&total_fee=\"81\"&notify_url=\"http://www.ttzaojiao.com/AppCode/Alipay/notify_url.aspx\"&service=\"mobile.securitypay.pay\"&payment_type=\"1\"&_input_charset=\"UTF-8\"&it_b_pay=\"30m\"&success=\"true\"&sign_type=\"RSA\"&sign=\"kv1nNV0jxdxwSPmmEG217cuDUhLL3OUAdNXGMIalbNCBhGNKZRJYFeTXWXOp9C+7UlVvjZp3x5hsibyJzhS+ouXabmncGeftrbUmZyOnNE8+HFWJcMbxD2m+gVNngr9NWT6D7snNSjNYlR59z1v610fRHo4ZWI/iezaAoqwYJcs=\"";
 resultStatus = 9000;
 }
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    WoVipModel *model = (WoVipModel *)[_list objectAtIndex:indexPath.section];
    NSString* productName = @"天天早教VIP服务";
    NSString* productDescription = [NSString stringWithFormat:@"%@个月VIP服务",model.i_month];
  
    
    [AlipayRequestConfig payWithProductName:productName productDescription:productDescription amount:model.i_price ttid:model.ttid];
    
    double delayInSeconds = 1.5;
    self.tableView.userInteractionEnabled = NO;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.tableView.userInteractionEnabled = YES;
    });
}

-(void)dealloc{
    _list = nil;
}

@end
