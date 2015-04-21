//
//  FileManagerHelper.h
//  LoveSport
//
//  Created by Liang Zhang on 14/11/28.
//  Copyright (c) 2014年 bangtianxia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManagerHelper : NSObject

+ (NSString*)CreatFilePath:(NSString *)name;
+ (void)DeleteFilePath:(NSString *)name;
//遍历文件夹获得文件夹大小，返回多少M
+ (float ) folderSizeAtPath:(NSString*) folderPath;
//单个文件的大小，返回多少M
+ (float) fileSizeAtPath:(NSString*) filePath;

@end
