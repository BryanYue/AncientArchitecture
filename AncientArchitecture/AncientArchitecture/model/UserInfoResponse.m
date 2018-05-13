//
//  UserInfoResponse.m
//  AncientArchitecture
//
//  Created by Bryan on 2018/3/28.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "UserInfoResponse.h"

@implementation UserInfoResponse

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
