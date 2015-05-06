//
//  AlipayRequestConfig+TTAlipay.h
//  TTzaojiao
//
//  Created by Liang Zhang on 15/5/6.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "AlipayRequestConfig.h"

@interface AlipayRequestConfig (TTAlipay)

/**
 *  配置请求信息，仅有变化且必要的参数
 *
 *  @param productName        商品名称
 *  @param productDescription 商品详情
 *  @param amount             总金额
 */
+(NSString *)payWithProductName:(NSString *)productName productDescription:(NSString *)productDescription amount:(NSString *)amount;

@end
