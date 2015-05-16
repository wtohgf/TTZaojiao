//
//  TTGrowTemperTestTool.h
//  TTzaojiao
//
//  Created by hegf on 15-5-16.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFAppDotNetAPIClient.h"
#import "TTUserModelTool.h"
#import "UIAlertView+MoreAttribute.h"

typedef void (^GrownTestListBlock)(id testlist);

@interface TTGrowTemperTestTool : NSObject
+(void)getTestListWithPageindex:(NSString*)pageIndex Result:(GrownTestListBlock)block;
+(void)getTestReportWithResultID:(NSString*)resultId Result:(GrownTestListBlock)block;
@end
