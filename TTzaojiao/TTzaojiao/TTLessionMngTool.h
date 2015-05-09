//
//  TTLessionMngTool.h
//  TTzaojiao
//
//  Created by hegf on 15-5-9.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFAppDotNetAPIClient.h"
#import "TTUserModelTool.h"
#import "UIAlertView+MoreAttribute.h"

typedef void (^LessionIDBlock)(NSString* lessionID);
typedef void (^WeekLessionBlock)(NSMutableArray* lessions);

@interface TTLessionMngTool : NSObject

+(void)getLessionID:(LessionIDBlock)block;
+(void)getWeekLessions:(NSString*)lessionID Result:(WeekLessionBlock)block;

@end
