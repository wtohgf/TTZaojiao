// AFAppDotNetAPIClient.h
//
// Copyright (c) 2012 Mattt Thompson (http://mattt.me/)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

//注：
//1，所有的返参默认为string类型；其它类型会另行标注；（除了string，还需要使用int类型）
//2，所有的入参，均不限类型；
//3，所有的id参数，按照int传递；
//4，所有的返回值ret，按照int传递；
//5，所有的返参中，涉及数量的，按照int传递

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "JSONHelper.h"
#import "TTWebServerAPI.h"

typedef enum : NSUInteger {
    eJsonDefault = -1000,
    eJsonNil,
    eJsonNull,
    eJsonNotDictionary
} CustomErrorFailed;

typedef enum : NSUInteger {
    ApiStatusSuccess,
    ApiStatusFail,
    ApiStatusError,
    ApiStatusException,
    ApiStatusNetworkNotReachable,
    ApiStatusAppNoUse,
} ApiStatus;

typedef void(^WifiAvaliableBlock)(BOOL wifiAvaliable);

#define JsonErrorDomain @"com.Houses.json"
#define kUserdefaultUserName @"com.Houses.username"
#define kUserdefaultPassword @"com.Houses.password"

#define DownloadPath @"Download"

#define PortalURL @"http://58.215.78.118/1709/ip.txt"
#define APIName UPLOAD_IMAGE
#define APIImageName @"http://x.x.x.x/xxxx/"

//Api Value Key
#define ParametersKeyRet @"ret"
#define ParametersKeyMsg @"msg"
#define ParametersKeyFun @"fun"
#define ParametersKeyVer @"ver"
#define ParametersKeyDat @"dat"

//API Version
#define ApiVersion @"1_0"

//Function name

@interface AFAppDotNetAPIClient :AFHTTPRequestOperationManager
@property (nonatomic, strong) NSString *protalurl;

+ (instancetype)sharedClient;

//获取动态ip（如果需要）
-(void)portal:(void (^)(id result_data, ApiStatus result_status))result;
//上传文件
-(void)uploadFile:(NSDictionary *)parameters //参数
            Files:(NSArray *)files //文件名列表
           Result:(void (^)(id result_data, ApiStatus result_status))result //结果block
         Progress:(void (^)(CGFloat progress))progress; //进度

//上传图片
-(void)uploadImage:(NSDictionary *)parameters //参数
            Images:(NSArray *)images //uimage图片列表
           Result:(void (^)(id result_data, ApiStatus result_status))result //结果block
         Progress:(void (^)(CGFloat progress))progress; //进度

//下载文件
-(void)downloadFile:(NSDictionary *)parameters //参数
           FileName:(NSString *)filename //文件名列表
             Result:(void (^)(id result_data, ApiStatus result_status))result //结果block
           Progress:(void (^)(CGFloat progress))progress; //进度
//POST
-(void)apiPost:(NSString *)function //api名
    Parameters:(NSDictionary *)parameters //参数
        Result:(void (^)(id result_data, ApiStatus result_status, NSString *api))result; //结果block
//GET
-(void)apiGet:(NSString *)function //api名
   Parameters:(NSDictionary *)parameters //参数
       Result:(void (^)(id result_data, ApiStatus result_status, NSString *api))result; //结果block

@end
