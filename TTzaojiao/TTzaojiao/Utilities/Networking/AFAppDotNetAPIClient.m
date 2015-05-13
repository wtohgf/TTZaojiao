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

#import "AFAppDotNetAPIClient.h"
#import "Constants.h"
#import "NetworkHelper.h"
#import "FileManagerHelper.h"

@implementation AFAppDotNetAPIClient

+ (instancetype)sharedClient {
    static AFAppDotNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];//使用这个将得到的是JSON
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/x-javascript", nil];
        _sharedClient.protalurl = @"";
    });
    
    return _sharedClient;
}

#pragma -mark api

-(void)portal:(void (^)(id result_data, ApiStatus result_status))result {
    
    if ([_protalurl isEqualToString:@""])
    {

            if (![NetworkHelper isNetWorkReachable])
            {
                result(nil,ApiStatusNetworkNotReachable);
            } else {
                self.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];//设置相应内容类型
                self.requestSerializer = [AFHTTPRequestSerializer serializer];
                self.responseSerializer = [AFHTTPResponseSerializer serializer];
                [self GET:PortalURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    id json = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                    if (json == nil || [json isEqualToString:@""] || [json isEqual:[NSNull null]] || ![json isKindOfClass:[NSString class]])
                    {
                        result(nil,ApiStatusFail);
                    }
                    else
                    {
                        _protalurl = json;
                        result(_protalurl,ApiStatusSuccess);
                    }
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    result(error,ApiStatusError);
                }];
            }
    }
    else
    {
        result(_protalurl,ApiStatusSuccess);
    }
}

-(void)uploadImage:(NSDictionary *)parameters Images:(NSArray *)images Result:(void (^)(id result_data, ApiStatus result_status))result Progress:(void (^)(CGFloat progress))progress {
    
        if (![NetworkHelper isNetWorkReachable])
        {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Please check your network connection is correct", @"请检查您的网络连接是否正确") forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
            result(error,ApiStatusNetworkNotReachable);
        } else {
            
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];//使用这个将得到的是JSON
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];

            [manager POST:APIName parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                [images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    UIImage* image = (UIImage*)obj;
                    NSData* data = UIImagePNGRepresentation(image);
                    NSString* file = [NSString stringWithFormat:@"file%ld",idx+1];
                    NSString* fileName = [NSString stringWithFormat:@"temp%ld.png",idx+1];
                    [formData appendPartWithFileData:data name:file fileName:fileName mimeType:@"image/png"];
                }];

            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSError *error = nil;
                id json = nil;
                if ([responseObject isKindOfClass:[NSArray class]] ||
                    [responseObject isKindOfClass:[NSDictionary class]] ||
                    [responseObject isKindOfClass:[NSString class]]) {
                    json = responseObject;
                }
                else {
                    json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                }
                
                if (json==nil)
                {
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                    error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                    result(error,ApiStatusError);
                }
                else if ([json isEqual:[NSNull null]])
                {
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                    error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                    result(error,ApiStatusError);
                }
                else if (![json isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                    error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                    result(error,ApiStatusError);
                }
                else
                {
                    result(nil,ApiStatusSuccess);
                }
                result(responseObject,ApiStatusSuccess);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                result(error,ApiStatusError);
            }];
        }
}


-(void)uploadFile:(NSDictionary *)parameters Files:(NSArray *)files Result:(void (^)(id result_data, ApiStatus result_status))result Progress:(void (^)(CGFloat progress))progress {
    
    if (![NetworkHelper isNetWorkReachable])
    {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Please check your network connection is correct", @"请检查您的网络连接是否正确") forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
        result(error,ApiStatusNetworkNotReachable);
    } else {
        
        AFHTTPRequestOperation *operation = [self POST:APIName parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            [files enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSDictionary *fileDic = (NSDictionary *)obj;
                NSString *defaultPath = [[NSBundle mainBundle] pathForResource:@"nodata" ofType:@"png"];
                NSString *name = [NetworkHelper makeModelValueWithKey:@"filename" Model:fileDic Null:@"nodata"];
                NSString *path = [NetworkHelper makeModelValueWithKey:@"filepath" Model:fileDic Null:defaultPath];
                NSURL *filePathUrl = [NSURL fileURLWithPath:path];
                [formData appendPartWithFileURL:filePathUrl name:name error:nil];
            }];
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSError *error = nil;
            id json = nil;
            if ([responseObject isKindOfClass:[NSArray class]] ||
                [responseObject isKindOfClass:[NSDictionary class]] ||
                [responseObject isKindOfClass:[NSString class]]) {
                json = responseObject;
            }
            else {
                json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            }
            
            if (json==nil)
            {
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                result(error,ApiStatusError);
            }
            else if ([json isEqual:[NSNull null]])
            {
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                result(error,ApiStatusError);
            }
            else if (![json isKindOfClass:[NSDictionary class]])
            {
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                result(error,ApiStatusError);
            }
            else
            {
                result(nil,ApiStatusSuccess);
            }
            result(responseObject,ApiStatusSuccess);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            result(error,ApiStatusError);
            
        }];
        
        [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            progress(((float)totalBytesWritten) / totalBytesExpectedToWrite);
        }];
    }
}


-(void)downloadFile:(NSDictionary *)parameters FileName:(NSString *)filename Result:(void (^)(id result_data, ApiStatus result_status))result Progress:(void (^)(CGFloat progress))progress {

        if (![NetworkHelper isNetWorkReachable])
        {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Please check your network connection is correct", @"请检查您的网络连接是否正确") forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
            result(error,ApiStatusNetworkNotReachable);
        } else {
            
            AFHTTPRequestOperation *operation = [self GET:APIName parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSError *error = nil;
                id json = nil;
                if ([responseObject isKindOfClass:[NSArray class]] ||
                    [responseObject isKindOfClass:[NSDictionary class]] ||
                    [responseObject isKindOfClass:[NSString class]]) {
                    json = responseObject;
                }
                else {
                    json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                }

                if (json==nil)
                {
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                    error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                    result(error,ApiStatusError);
                }
                else if ([json isEqual:[NSNull null]])
                {
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                    error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                    result(error,ApiStatusError);
                }
                else if (![json isKindOfClass:[NSArray class]])
                {
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                    error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                    result(error,ApiStatusError);
                }
                else
                {
                    result(nil,ApiStatusSuccess);
                }
                result(responseObject,ApiStatusSuccess);
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                result(error,ApiStatusError);
                
            }];
            
            // 指定文件保存路径，将文件保存在沙盒中
            [FileManagerHelper CreatFilePath:DownloadPath];
            NSString *path = [NSString stringWithFormat:@"%@/%@/%@",pathDocuments,DownloadPath,filename];
            operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
            
            [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                progress(((float)totalBytesWritten) / totalBytesExpectedToWrite);
            }];
        }
}

-(void)apiPost:(NSString *)function Parameters:(NSDictionary *)parameters Result:(void (^)(id result_data, ApiStatus result_status, NSString *api))result {
    
        if (![NetworkHelper isNetWorkReachable])
        {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Please check your network connection is correct", @"请检查您的网络连接是否正确") forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
            result(error,ApiStatusNetworkNotReachable,function);
        } else {
            
            [self POST:function parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSError *error = nil;
                id json = @[];
                if ([responseObject isKindOfClass:[NSArray class]] ||
                    [responseObject isKindOfClass:[NSDictionary class]] ||
                    [responseObject isKindOfClass:[NSString class]]) {
                    json = responseObject;
                }
                else {
                    json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                }
                
                if (json==nil)
                {
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                    error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                    result(error,ApiStatusError,function);
                }
                else if ([json isEqual:[NSNull null]])
                {
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                    error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                    result(error,ApiStatusError,function);
                }
                else
                {
                    NSMutableArray *modelArr = [NSMutableArray arrayWithCapacity:0];
                    @try {
                        NSArray *Data = json;
                        
                        ApiEnum api = ApiEnumNone;
                        //用function(NSString)参数if判断以确定ApiName枚举
                        if ([function isEqualToString:@"ApiNamexxxx"]) {
                            api = ApiEnumNone;
                        }
                        
                        [Data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                            NSDictionary *modelDic = (NSDictionary *)obj;
                            
                            id modelObject = [JSONHelper jsonToModel:modelDic Api:ApiEnumNone Idx:idx ImageURL:APIImageName];
                            if (modelArr!=nil) {
                                [modelArr addObject:modelObject];
                                *stop = YES;
                            }
                            else {
                                if ([modelObject isKindOfClass:[NSArray class]]) {
                                    [modelArr addObjectsFromArray:modelObject];
                                } else {
                                    [modelArr addObject:modelObject];
                                }
                            }
                        }];
                    }
                    @catch (NSException *exception) {
                        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:exception.description forKey:NSLocalizedDescriptionKey];
                        error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                        result(error,ApiStatusException,function);
                    }
                    @finally {
                        if (modelArr!=nil &&
                            modelArr.count>0) {
                            result(modelArr,ApiStatusSuccess,function);
                        }
                        else {
                            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                            error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                            result(error,ApiStatusError,function);
                        }
                    }
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                result(error,ApiStatusError,function);
                
            }];
        }
}

-(void)apiGet:(NSString *)function Parameters:(NSDictionary *)parameters Result:(void (^)(id result_data, ApiStatus result_status, NSString *api))result {
    

        if (![NetworkHelper isNetWorkReachable])
        {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Please check your network connection is correct", @"请检查您的网络连接是否正确") forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
            result(error,ApiStatusNetworkNotReachable,function);
        } else {
            
            [self GET:function parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

                NSError *error = nil;
                id json = @[];
                if ([responseObject isKindOfClass:[NSArray class]] ||
                    [responseObject isKindOfClass:[NSDictionary class]] ||
                    [responseObject isKindOfClass:[NSString class]]) {
                    json = responseObject;
                }
                else {
                    json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                }
                
                if (json==nil)
                {
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                    error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                    result(error,ApiStatusError,function);
                }
                else if ([json isEqual:[NSNull null]])
                {
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                    error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                    result(error,ApiStatusError,function);
                }
                else
                {
                    NSMutableArray *modelArr = [NSMutableArray arrayWithCapacity:0];
                    @try {
                        NSArray *Data = json;
                        
                        ApiEnum api = ApiEnumNone;
                        
                        //用function(NSString)参数if判断以确定ApiName枚举
                        if ([function rangeOfString:@"Get_Login"].length) {
                            api = ApiEnumGet_Login;
                        }
                        if ([function rangeOfString:@"Get_Reg_1"].length) {
                            api = ApiEnumGet_Reg_1;
                        }
                        if ([function rangeOfString:@"Get_Reg_2"].length) {
                            api = ApiEnumGet_Reg_2;
                        }
                        if ([function rangeOfString:@"Get_List_Active"].length) {
                            api = ApiEnumGet_List_Active;
                        }
                        if ([function rangeOfString:@"Get_List_Blog_Group"].length || [function rangeOfString:@"Get_List_Blog"].length) {
                            api = ApiEnumGet_List_Blog_Group;
                        }
                        if ([function rangeOfString:@"Get_List_Blog_Replay"].length) {
                            api = ApiEnumGet_List_Blog_Replay;
                        }
                        if ([function rangeOfString:@"Get_List_User_Info"].length) {
                            api = ApiEnumGet_List_User_Info;
                        }
                        if ([function rangeOfString:@"Get_List_User_Blog"].length) {
                            api = ApiEnumGet_List_User_Blog;
                        }
                        if ([function rangeOfString:@"Get_List_Alipay_Price"].length) {
                            api = ApiEnumGet_VIP_PRICE;
                        }
                        if ([function rangeOfString:@"Get_Pay_Card"].length) {
                            api = ApiEnumGet_PAY_BY_CARD;
                        }
                        if ([function rangeOfString:@"Get_Test_User_List_Distance"].length) {
                            api = ApiEnumGet_Test_User_List_Distance;
                        }
                        if ([function rangeOfString:@"Get_Me_Class_Info"].length || [function rangeOfString:@"Get_Me_Class_Info_Experience"].length) {
                            api = ApiEnumGet_Me_Class_Info;
                        }
                        if ([function rangeOfString:@"Get_Me_ClassPart_Info"].length) {
                            api = ApiEnumGet_Me_ClassPart_Info;
                        }
                        [Data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                            NSDictionary *modelDic = (NSDictionary *)obj;
                            
                            id modelObject = [JSONHelper jsonToModel:modelDic Api:api Idx:idx ImageURL:APIImageName];
                            if (modelArr!=nil) {
                                [modelArr addObject:modelObject];
//                               *stop = YES;
                            }
                            else {
                                if ([modelObject isKindOfClass:[NSArray class]]) {
                                    [modelArr addObjectsFromArray:modelObject];
                                } else {
                                    [modelArr addObject:modelObject];
                                }
                            }
                        }];
                    }
                    @catch (NSException *exception) {
                        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:exception.description forKey:NSLocalizedDescriptionKey];
                        error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                        result(error,ApiStatusException,function);
                    }
                    @finally {
                        if (modelArr!=nil &&
                            modelArr.count>0) {
                            result(modelArr,ApiStatusSuccess,function);
                        }
                        else {
                            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                            error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                            result(error,ApiStatusError,function);
                        }
                    }
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                result(error,ApiStatusError,function);
                
            }];
            
        }
}

@end
