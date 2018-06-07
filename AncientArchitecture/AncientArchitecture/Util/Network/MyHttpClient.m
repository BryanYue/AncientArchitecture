//
//  MyHttpClientViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/3/24.
//  Copyright © 2018年 通感科技. All rights reserved.
//
#define kNetworkMethodName @[@"Get",@"Post",@"Put",@"Delete"]
#import "MyHttpClient.h"
#import <Foundation/Foundation.h>
#import "BaseResponse.h"


@interface MyHttpClient ()

@end

@implementation MyHttpClient
static MyHttpClient *_sharedClient = nil;
static dispatch_once_t onceToken;

+ (instancetype)sharedJsonClient{
    dispatch_once(&onceToken, ^{
    
        _sharedClient = [[MyHttpClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.feiwuzhi.com"]];
    });
    return _sharedClient;
}


- (id)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
        self.securityPolicy.allowInvalidCertificates = NO;
    }
    return self;
}

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary *)params
                 withMethodType:(NetWorkMethod)method
                       andBlock:(void (^)(id, NSError *))block{
    [self requestJsonDataWithPath:aPath withParams:params withMethodType:method autoShowError:YES andBlock:block];
}

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary *)params
                 withMethodType:(NetWorkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id, NSError *))block{
    if (!aPath ||aPath.length <=0) {
        return ;
    }
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];;
    NSString   *Token = [defaults objectForKey:@"token"];
    
    if (Token!=nil) {
         [self.requestSerializer setValue:Token forHTTPHeaderField:@"authorization"];
    }
    
   
    
   
    //    NSLog(@"\n==========request==========\n%@",self.requestSerializer.HTTPRequestHeaders);//输出请求的头
    NSLog(@"\n==========request==========\n%@",aPath);//输出请求的地址
    
    //请求地址转码(地址里面带有中文的转成URL会为空,所以要先转码)
    switch (method) {
        case Get:{
            NSMutableString *localPath = [aPath mutableCopy];
            if (params) {
                [localPath appendString:params.description];
            }
            [self GET:aPath parameters:[self formalParams:params] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSString  *result =[self convertToJsonData:responseObject];
                NSLog(@"POST请求到的数据===>%@\n%@",result,[self formalParams:params]);//输出json样式
                //                NSLog(@"\n==========response==========\n%@\n%@\n%@",aPath, responseObject,[[[responseObject objectForKey:@"body"] objectForKey:@"error"] stringByRemovingPercentEncoding]);
                BaseResponse *response = [BaseResponse mj_objectWithKeyValues:responseObject];
                block(response, nil);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                NSLog(@"%@",error);
                block(nil,error);
            }];
            break;
        }
        case Post:{
            [self POST:aPath parameters:[self formalParams:params] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSString  *result =[self convertToJsonData:responseObject];
                NSLog(@"POST请求到的数据===>%@\n%@",result,[self formalParams:params]);//输出json样式
                //                NSLog(@"\n==========response==========\n%@\n%@\n%@",aPath, responseObject, [self formalParams:params]);//输出字典样式
                BaseResponse *response = [BaseResponse mj_objectWithKeyValues:responseObject];
                block(response, nil);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                NSLog(@"POST失败原因===>%@",error);
                block(nil,error);
            }];
            break;}
        case Put:
            [self PUT:aPath parameters:[self formalParams:params] success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
            break;
        case Delete:
            [self DELETE:aPath parameters:[self formalParams:params] success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
            break;
        default:
            break;
    }
}

-(NSDictionary*)formalParams:(NSDictionary*)dic{
    
    //用户token取值
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString   *Token = [defaults objectForKey:@"token"];
    
    
    NSMutableDictionary *new_dict = nil;
    if(nil == dic){
        new_dict = [[NSMutableDictionary alloc]init];
    }else{
        new_dict = [NSMutableDictionary dictionaryWithDictionary:dic];
    }
    if (Token !=nil) {
        [new_dict setValue:Token forKey:@"authorization"];
    }
   [new_dict setValue:@"1" forKey:@"is_phone"];
    return new_dict;
    
}

// 字典转json字符串方法
-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}



@end
