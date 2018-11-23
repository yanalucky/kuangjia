//
//  UABaseNetworkManager.m
//  demo
//
//  Created by perfayMini on 2018/11/23.
//  Copyright © 2018 huawei. All rights reserved.
//

#import "UABaseNetworkManager.h"
#import <AFNetworking.h>


static const NSTimeInterval outTime = 15;
static UABaseNetworkManager *networkManager;


@implementation UABaseNetworkManager


+ (id)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkManager = [[UABaseNetworkManager alloc]initWithBaseURL:[[self alloc] getBaseUrl]];
    });
    networkManager.requestSerializer.timeoutInterval = outTime;
    return networkManager;
}



+(NSString *)requestGetURL:(NSString *)url params:(NSDictionary *)params
{
    NSString * urlParamString = @"";//拼接的get参数
    for (NSString * key in [params allKeys]) {
        NSString *value = [NSString stringWithFormat:@"%@", params[key]];
        NSString * keyStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)value, NULL, (CFStringRef)@"!*’();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
        NSString * string = [NSString stringWithFormat:@"&%@=%@",key,keyStr];
        urlParamString = [urlParamString stringByAppendingString:string];
    }
    NSString * tURL =[NSString stringWithFormat:@"%@?%@",url,urlParamString];
    tURL = [tURL stringByReplacingOccurrencesOfString:@"?&" withString:@"?"];
    
    return tURL;
}
- (NSURL *)getBaseUrl{
    return [NSURL URLWithString:@""];
}

- (AFSecurityPolicy *)customSecurityPolicy {
    //先导入证书，找到证书的路径
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"doubotv" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    //AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    NSSet *set = [[NSSet alloc] initWithObjects:certData, nil];
    securityPolicy.pinnedCertificates = set;
    return securityPolicy;
}
- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        AFHTTPResponseSerializer * responseSerialize = [AFHTTPResponseSerializer serializer];
        responseSerialize.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",@"*/*", nil];
        self.responseSerializer =responseSerialize;
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

#pragma action

- (void)requestPOST:(NSString *)URLString
         parameters:(id)parameters
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure{
    [self POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString * responseString =[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                    options:NSJSONReadingMutableContainers
                                                               error:nil];
            // 根据数据来处理
//        int code = [responseDic[@"code"] intValue];
//        if (code == RequestSuc) {
            success(responseString);
//        }else{
//            NSError *error = [NSError errorWithDomain:task.currentRequest.URL.description code:code userInfo:@{NSLocalizedDescriptionKey:responseDic[@"msg"]}];
//            [self failWithError:error];
//            failure(error);
//        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [self failWithError:error];
        failure(error);
    }];
}
- (void)requestGET:(NSString *)URLString
        parameters:(id)parameters
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSError *error))failure
{
    [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString * responseString =[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:nil];
        //根据数据来处理                                                            error:nil];

//        int code = [responseDic[@"code"] intValue];
//        if (code == RequestSuc) {
            success(responseString);
//        }else{
//            NSError *error = [NSError errorWithDomain:task.currentRequest.URL.description code:code userInfo:@{NSLocalizedDescriptionKey:responseDic[@"msg"]}];
//            [self failWithError:error];
//            failure(error);
//
//        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [self failWithError:error];
        failure(error);
    }];
    
}
- (void)requestUploadFile:(NSString *)URLString
                  FileUrl:(NSURL *)fileUrl
                 FileName:(NSString *)fileName
               parameters:(id)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure
{
    [self POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileURL:fileUrl name:fileName error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString * responseString =[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:nil];
//        int code = [responseDic[@"code"] intValue];
//        if (code == RequestSuc) {
            success(responseString);
//        }else{
//            NSError *error = [NSError errorWithDomain:task.currentRequest.URL.description code:code userInfo:@{NSLocalizedDescriptionKey:responseDic[@"msg"]}];
//            failure(error);
//            [self failWithError:error];
//        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        [self failWithError:error];
    }];
}
- (void)failWithError:(NSError *)error{
    NSInteger  code = error.code;
    switch (code) {
        case -1009:
            break;
        case 1:
            break;
        default:
            break;
    }
}
@end
