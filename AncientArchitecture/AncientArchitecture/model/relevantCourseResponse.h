//
//  relevantCourseResponse.h
//  AncientArchitecture
//
//  Created by bryan on 2018/5/20.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface relevantCourseResponse : MJPropertyKey
@property (nonatomic,copy)NSString   *id;
@property (nonatomic,copy)NSString   *cid;
@property (nonatomic,copy)NSString   *title;
@property (nonatomic,copy)NSString   *describe;
@property (nonatomic,copy)NSString   *start_time;
@property (nonatomic,copy)NSString   *on_live;
@property (nonatomic,copy)NSString   *vedio_id;

@end
