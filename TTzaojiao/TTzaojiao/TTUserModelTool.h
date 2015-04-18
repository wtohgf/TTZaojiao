//
//  TTUserModelTool.h
//  TTzaojiao
//
//  Created by hegf on 15-4-18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface TTUserModelTool : NSObject
+(instancetype)sharedUserModelTool;

@property (strong, nonatomic) UserModel* logonUser;
@end
