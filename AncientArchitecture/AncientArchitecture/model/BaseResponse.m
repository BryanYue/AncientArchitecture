//
//  BaseResponse.m
//  AncientArchitecture
//
//  Created by bryan on 2018/3/25.
//  Copyright © 2018年 通感科技. All rights reserved.
//




@implementation BaseResponse


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

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ %p> {status:%ld,data:%@,info:%@}",self.class,self,self.code,self.data,self.msg];
    
}


@end
