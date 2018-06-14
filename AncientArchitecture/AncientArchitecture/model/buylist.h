//
//  buylist.h
//  AncientArchitecture
//
//  Created by bryan on 2018/5/15.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface buylist : MJPropertyKey
@property (nonatomic,copy)NSString   *id;
@property (nonatomic,copy)NSString   *title;
@property (nonatomic,copy)NSString   *img_url;
@property (nonatomic,copy)NSString   *price;
@property (nonatomic,copy)NSString   *start_time;
@property (nonatomic,copy)NSString   *cid;
@property (nonatomic,copy)NSString   *vedio_id;
@property (nonatomic,copy)NSString   *is_live;
@property (nonatomic,copy)NSString   *order_id;
@end
