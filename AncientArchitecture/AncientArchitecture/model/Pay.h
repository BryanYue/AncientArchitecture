//
//  Pay.h
//  AncientArchitecture
//
//  Created by bryan on 2018/5/20.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "MJPropertyKey.h"

@interface Pay : MJPropertyKey
@property (nonatomic,strong)NSString   *appid;
@property (nonatomic,strong)NSString   *noncestr;
@property (nonatomic,strong)NSString   *package;
@property (nonatomic,strong)NSString   *prepayid;
@property (nonatomic,strong)NSString   *partnerid;
@property (nonatomic,strong)NSString   *timestamp;
@property (nonatomic,strong)NSString   *sign;

@end
