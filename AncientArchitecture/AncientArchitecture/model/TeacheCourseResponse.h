//
//  TeacheCourseResponse.h
//  AncientArchitecture
//
//  Created by Bryan on 2018/4/2.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeacheCourseResponse : MJPropertyKey


    @property (nonatomic,strong)NSString   *id;
    @property (nonatomic,strong)NSString   *title;
    @property (nonatomic,strong)NSString   *img_url;
    @property (nonatomic,strong)NSString   *price;
    @property (nonatomic,strong)NSString   *start_time;
    @property (nonatomic,strong)NSString   *cid;
    @property (nonatomic,strong)NSString   *vedio_id;
    @property (nonatomic,strong)NSString   *is_live;
    @property (nonatomic,strong)NSString   *page_num;


@end
