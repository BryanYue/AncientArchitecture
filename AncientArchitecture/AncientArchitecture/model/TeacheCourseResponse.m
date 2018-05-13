//
//  TeacheCourseResponse.m
//  AncientArchitecture
//
//  Created by Bryan on 2018/4/2.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "TeacheCourseResponse.h"

@implementation TeacheCourseResponse

-(instancetype)initWithDict:(NSDictionary*)dict{
    self=[super  init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


+(instancetype)modelWithDict:(NSDictionary*)dict{
    return [[self alloc] initWithDict:dict];
}


@end
