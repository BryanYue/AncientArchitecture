//
//  TeacherResponse.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/13.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "TeacherResponse.h"

@implementation TeacherResponse
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
