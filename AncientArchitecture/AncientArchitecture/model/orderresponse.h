//
//  orderresponse.h
//  AncientArchitecture
//
//  Created by bryan on 2018/5/20.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "MJPropertyKey.h"

@interface orderresponse : MJPropertyKey
@property (nonatomic,copy)NSString   *order_id;
@property (nonatomic,copy)NSString   *amount;
@property (nonatomic,copy)NSString   *attach;
@end
