//
//  aboutus.m
//  AncientArchitecture
//
//  Created by bryan on 2018/6/16.
//  Copyright © 2018年 通感科技. All rights reserved.
///Users/bryan/WorkPlace/AGoodStart/AncientArchitecture/AncientArchitecture.xcodeproj

#import "aboutus.h"

@implementation aboutus
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
