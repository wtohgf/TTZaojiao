//
//  Constants.h
//  TTzaojiao
//
//  Created by Liang Zhang on 15/4/16.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#ifndef TTzaojiao_Constants_h
#define TTzaojiao_Constants_h

// 当前应用软件版本  比如：1.0.1
#define appCurVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//手机别名： 用户定义的名称
#define userPhoneName [[UIDevice currentDevice] name]

//设备名称
#define deviceName [[UIDevice currentDevice] systemName]

//手机系统版本
#define phoneVersion [[UIDevice currentDevice] systemVersion]

//手机型号
#define phoneModel [[UIDevice currentDevice] model]

//地方型号  （国际化区域名称）
#define localPhoneModel [[UIDevice currentDevice] localizedModel]

// 当前应用名称
#define appCurName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

// 当前应用版本号码   int类型
#define appCurVersionNum [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]


//File Path
#define pathDocuments [NSHomeDirectory()stringByAppendingPathComponent:@"Documents"]

#endif
