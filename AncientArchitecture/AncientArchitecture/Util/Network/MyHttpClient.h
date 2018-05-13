//
//  MyHttpClientViewController.h
//  AncientArchitecture
//
//  Created by bryan on 2018/3/24.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef NS_ENUM(NSInteger, NetWorkMethod){
    Get = 0,
    Post,
    Put,
    Delete,
};
@interface MyHttpClient : AFHTTPSessionManager


+ (instancetype)sharedJsonClient;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary *)params
                 withMethodType:(NetWorkMethod)method
                       andBlock:(void(^)(id data, NSError *error))block;
- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary *)params
                 withMethodType:(NetWorkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void(^)(id data, NSError *error))block;







@end
