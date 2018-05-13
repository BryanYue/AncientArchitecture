//
//  CourseDetailResponse.h
//  AncientArchitecture
//
//  Created by bryan on 2018/4/10.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseDetailResponse : MJPropertyKey

    @property (nonatomic,strong)NSString   *id;
    @property (nonatomic,strong)NSString   *cid;
    @property (nonatomic,strong)NSString   *model;
    @property (nonatomic,strong)NSString   *title;
    @property (nonatomic,strong)NSString   *shorttitle;
    @property (nonatomic,strong)NSString   *uid;
    @property (nonatomic,strong)NSString   *flag;
    @property (nonatomic,strong)NSString   *view;
    @property (nonatomic,strong)NSString   *comment;
    
    @property (nonatomic,strong)NSString   *good;
    @property (nonatomic,strong)NSString   *bad;
    @property (nonatomic,strong)NSString   *mark;
    @property (nonatomic,strong)NSString   *create_time;
    @property (nonatomic,strong)NSString   *update_time;
    @property (nonatomic,strong)NSString   *sort;
    @property (nonatomic,strong)NSString   *status;
    @property (nonatomic,strong)NSString   *trash;
    @property (nonatomic,strong)NSString   *aid;
    
    @property (nonatomic,strong)NSString   *describe;
    @property (nonatomic,strong)NSString   *keyword;
    @property (nonatomic,strong)NSString   *lable;
    @property (nonatomic,strong)NSString   *is_free;
    @property (nonatomic,strong)NSString   *is_package;
    @property (nonatomic,strong)NSString   *is_live;
    
    @property (nonatomic,strong)NSString   *class_hour;
    @property (nonatomic,strong)NSString   *author_id;
    @property (nonatomic,strong)NSString   *content;
    @property (nonatomic,strong)NSString   *price;
    @property (nonatomic,strong)NSString   *img_url;
    @property (nonatomic,strong)NSString   *start_time;
    @property (nonatomic,strong)NSString   *vedio_id;
    
    @property (nonatomic,strong)NSString   *fit_person;
    @property (nonatomic,strong)NSString   *is_phonto_upload;
    @property (nonatomic,strong)NSString   *on_live;
    @property (nonatomic,strong)NSString   *teacher_id;
    @property (nonatomic,strong)NSString   *teacher_name;
    @property (nonatomic,strong)NSString   *teacher_photo;
    @property (nonatomic,strong)NSString   *phone_img_url;
    @property (nonatomic,strong)NSString   *cate_name;
    
    @property (nonatomic,strong)NSString   *is_follow;
    @property (nonatomic,strong)NSString   *is_buy;
    @property (nonatomic,strong)NSString   *flow_url;
    @property (nonatomic,strong)NSString   *stream_name_url;
    @property (nonatomic,strong)NSString   *push_vedio_url;
    @property (nonatomic,strong)NSString   *video;
    
    @property (nonatomic,strong)NSString   *vod_vedio_url;
    @property (nonatomic,strong)NSString   *m3u8_vod_vedio_url;


@end
