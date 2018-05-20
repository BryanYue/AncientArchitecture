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
@property (nonatomic,strong)  Pay       *datas;
@property (nonatomic,strong) NSString   *ordersn;
@property (nonatomic,strong) NSString   *message;
@end
