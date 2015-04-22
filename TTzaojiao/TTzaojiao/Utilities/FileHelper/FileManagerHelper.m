//
//  FileManagerHelper.m
//  LoveSport
//
//  Created by Liang Zhang on 14/11/28.
//  Copyright (c) 2014年 bangtianxia. All rights reserved.
//

#import "FileManagerHelper.h"
#import "Constants.h"

@implementation FileManagerHelper

+ (NSString*)CreatFilePath:(NSString *)name {
    NSString *imageDir = [NSString stringWithFormat:@"%@/%@", pathDocuments, name];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    if (!(isDir==YES && existed==YES)) {
        [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return imageDir;
}


+ (void)DeleteFilePath:(NSString *)name {
    NSString *imageDir = [NSString stringWithFormat:@"%@/%@", pathDocuments, name];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:imageDir error:nil];
}



//遍历文件夹获得文件夹大小，返回多少M
+ (float ) folderSizeAtPath:(NSString*) folderPath {
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString* fileName;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
        
    }
    
    return folderSize/(1024.0*1024.0);
    
}

//单个文件的大小
+ (float) fileSizeAtPath:(NSString*) filePath {
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){

        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize]/(1024.0*1024);
        
    }
    
    return 0;
}


@end
