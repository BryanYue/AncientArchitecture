//
//  BaseResponse.h
//  AncientArchitecture
//
//  Created by bryan on 2018/3/25.
//  Copyright © 2018年 通感科技. All rights reserved.
//


@interface BaseResponse : MJPropertyKey


@property (nonatomic,assign)NSInteger     code;
@property (nonatomic,strong)NSString *msg;
@property (nonatomic,strong)id        data;
@property (nonatomic,assign)NSInteger       page_num;



@end
