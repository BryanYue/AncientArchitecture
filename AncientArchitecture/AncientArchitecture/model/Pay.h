//
//  Pay.h
//  AncientArchitecture
//
//  Created by bryan on 2018/5/20.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "MJPropertyKey.h"

@interface Pay : MJPropertyKey
@property (nonatomic,copy)NSString   *appid;
@property (nonatomic,copy)NSString   *noncestr;
@property (nonatomic,copy)NSString   *package;
@property (nonatomic,copy)NSString   *prepayid;
@property (nonatomic,copy)NSString   *partnerid;
@property (nonatomic,copy)NSString   *timestamp;
@property (nonatomic,copy)NSString   *sign;

@end
