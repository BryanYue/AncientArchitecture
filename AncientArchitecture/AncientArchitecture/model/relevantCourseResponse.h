//
//  relevantCourseResponse.h
//  AncientArchitecture
//
//  Created by bryan on 2018/5/20.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface relevantCourseResponse : MJPropertyKey
@property (nonatomic,strong)NSString   *id;
@property (nonatomic,strong)NSString   *cid;
@property (nonatomic,strong)NSString   *title;
@property (nonatomic,strong)NSString   *describe;
@property (nonatomic,strong)NSString   *start_time;
@property (nonatomic,strong)NSString   *on_live;
@property (nonatomic,strong)NSString   *vedio_id;

@end
