//
//  ViewController.m
//  TTzaojiao
//
//  Created by hegf on 15-4-15.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "ViewController.h"
#import "AlipayHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pay:(id)sender {
    static int product_id = 0;
    product_id++;
    [AlipayRequestConfig alipayWithPartner:kPartnerID
                                    seller:kSellerAccount
                                   tradeNO:[AlipayToolKit genTradeNoWithTime]
                               productName:[NSString stringWithFormat:@"邮票%d",product_id]
                        productDescription:@"全真邮票"
                                    amount:@"0.8"
                                 notifyURL:kNotifyURL
                                    itBPay:@"30m"];
}

@end
