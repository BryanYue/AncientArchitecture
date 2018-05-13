//
//  LoginResponse.m
//  AncientArchitecture
//
//  Created by Bryan on 2018/3/26.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "LoginResponse.h"

@implementation LoginResponse

- (instancetype)initWithDict:(NSDictionary*)dict
{
    self=[super  init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype)registWithDict:(NSDictionary*)dict
{
    return [[self alloc] initWithDict:dict] ;
}

@end
