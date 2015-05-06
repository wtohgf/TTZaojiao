//
//  AlipayRequestConfig+TTAlipay.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/5/6.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "AlipayRequestConfig+TTAlipay.h"

@implementation AlipayRequestConfig (TTAlipay)

+(void)payWithProductName:(NSString *)productName productDescription:(NSString *)productDescription amount:(NSString *)amount {
    [AlipayRequestConfig alipayWithPartner:kPartnerID
                                    seller:kSellerAccount
                                   tradeNO:[AlipayToolKit genTradeNoWithTime]
                               productName:productName
                        productDescription:productDescription
                                    amount:amount
                                 notifyURL:kNotifyURL
                                    itBPay:@"30m"];
}

@end
