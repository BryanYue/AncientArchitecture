//
//  CourseDetailResponse.h
//  AncientArchitecture
//
//  Created by bryan on 2018/4/10.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseDetailResponse : MJPropertyKey

    @property (nonatomic,copy)NSString   *id;
    @property (nonatomic,copy)NSString   *cid;
    @property (nonatomic,copy)NSString   *model;
    @property (nonatomic,copy)NSString   *title;
    @property (nonatomic,copy)NSString   *shorttitle;
    @property (nonatomic,copy)NSString   *uid;
    @property (nonatomic,copy)NSString   *flag;
    @property (nonatomic,copy)NSString   *view;
    @property (nonatomic,copy)NSString   *comment;
    
    @property (nonatomic,copy)NSString   *good;
    @property (nonatomic,copy)NSString   *bad;
    @property (nonatomic,copy)NSString   *mark;
    @property (nonatomic,copy)NSString   *create_time;
    @property (nonatomic,copy)NSString   *update_time;
    @property (nonatomic,copy)NSString   *sort;
    @property (nonatomic,copy)NSString   *status;
    @property (nonatomic,copy)NSString   *trash;
    @property (nonatomic,copy)NSString   *aid;
    
    @property (nonatomic,copy)NSString   *describe;
    @property (nonatomic,copy)NSString   *keyword;
    @property (nonatomic,copy)NSString   *lable;
    @property (nonatomic,copy)NSString   *is_free;
    @property (nonatomic,copy)NSString   *is_package;
    @property (nonatomic,copy)NSString   *is_live;
    
    @property (nonatomic,copy)NSString   *class_hour;
    @property (nonatomic,copy)NSString   *author_id;
    @property (nonatomic,copy)NSString   *content;
    @property (nonatomic,copy)NSString   *price;
    @property (nonatomic,copy)NSString   *img_url;
    @property (nonatomic,copy)NSString   *start_time;
    @property (nonatomic,copy)NSString   *vedio_id;
    
    @property (nonatomic,copy)NSString   *fit_person;
    @property (nonatomic,copy)NSString   *is_phonto_upload;
    @property (nonatomic,copy)NSString   *on_live;
    @property (nonatomic,copy)NSString   *teacher_id;
    @property (nonatomic,copy)NSString   *teacher_name;
    @property (nonatomic,copy)NSString   *teacher_photo;
    @property (nonatomic,copy)NSString   *phone_img_url;
    @property (nonatomic,copy)NSString   *cate_name;
    
    @property (nonatomic,copy)NSString   *is_follow;
    @property (nonatomic,copy)NSString   *is_buy;
    @property (nonatomic,copy)NSString   *flow_url;
    @property (nonatomic,copy)NSString   *stream_name_url;
    @property (nonatomic,copy)NSString   *push_vedio_url;
    @property (nonatomic,copy)NSString   *video;
    
    @property (nonatomic,copy)NSString   *vod_vedio_url;
    @property (nonatomic,copy)NSString   *m3u8_vod_vedio_url;

    @property (nonatomic,copy)NSString   *order_id;
   @property (nonatomic,copy)NSString   *buy_num;
@end
