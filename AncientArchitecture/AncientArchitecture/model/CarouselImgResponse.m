//
//  CarouselImgResponse.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/12.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "CarouselImgResponse.h"

@implementation CarouselImgResponse

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