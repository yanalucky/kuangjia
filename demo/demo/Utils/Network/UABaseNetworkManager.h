//
//  UABaseNetworkManager.h
//  demo
//
//  Created by perfayMini on 2018/11/23.
//  Copyright © 2018 huawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>


NS_ASSUME_NONNULL_BEGIN

@interface UABaseNetworkManager : AFHTTPSessionManager
+ (id)shareInstance;

@end

NS_ASSUME_NONNULL_END
