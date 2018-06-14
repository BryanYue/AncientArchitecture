//
//  weChatPay.h
//  AncientArchitecture
//
//  Created by bryan on 2018/5/20.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "MJPropertyKey.h"
#import "Pay.h"
@interface weChatPay : MJPropertyKey
@property (nonatomic,copy)  Pay       *datas;
@property (nonatomic,copy) NSString   *ordersn;
@property (nonatomic,copy) NSString   *message;
@end
