//
//  orderresponse.h
//  AncientArchitecture
//
//  Created by bryan on 2018/5/20.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "MJPropertyKey.h"

@interface orderresponse : MJPropertyKey
@property (nonatomic,strong)NSString   *order_id;
@property (nonatomic,strong)NSString   *amount;
@property (nonatomic,strong)NSString   *attach;
@end
