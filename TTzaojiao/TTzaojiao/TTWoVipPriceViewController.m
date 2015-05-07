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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 1:
        {
            NSString *tradeNo = [AlipayRequestConfig payWithProductName:@"课程名1" productDescription:@"早教课程VIP服务" amount:@"81"];
            NSLog(@"tradeNo : %@",tradeNo);
        }
            break;
        case 2:
        {
            NSString *tradeNo = [AlipayRequestConfig payWithProductName:@"课程名2" productDescription:@"早教课程VIP服务" amount:@"158"];
            NSLog(@"tradeNo : %@",tradeNo);
        }
            break;
            
        default:
        {
            NSString *tradeNo = [AlipayRequestConfig payWithProductName:@"课程名3" productDescription:@"早教课程VIP服务" amount:@"288"];
            NSLog(@"tradeNo : %@",tradeNo);
        }
            break;
    }
    
    double delayInSeconds = 1.5;
    self.tableView.userInteractionEnabled = NO;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.tableView.userInteractionEnabled = YES;
    });
}

@end
