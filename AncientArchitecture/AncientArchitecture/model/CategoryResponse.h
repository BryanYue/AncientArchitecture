//
//  Category.h
//  AncientArchitecture
//
//  Created by bryan on 2018/4/2.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CategoryResponse : MJPropertyKey

    @property (nonatomic,copy)NSString   *id;
    @property (nonatomic,copy)NSString   *pid;
    @property (nonatomic,copy)NSString   *category_name;
    @property (nonatomic,copy)NSString   *price;
    @property (nonatomic,copy)NSString   *discount;
    @property (nonatomic,copy)NSString   *describe;
    @property (nonatomic,copy)NSString   *content;
    @property (nonatomic,copy)NSString   *sort;
    @property (nonatomic,copy)NSString   *is_over;
    
    @property (nonatomic,copy)NSString   *start_time;
    @property (nonatomic,copy)NSString   *end_time;
    @property (nonatomic,copy)NSString   *course_num;
    @property (nonatomic,copy)NSString   *course_time;
    
    @property (nonatomic,copy)NSString   *visit_num;
    @property (nonatomic,copy)NSString   *author_id;
    @property (nonatomic,copy)NSString   *img_url;
    @property (nonatomic,copy)NSString   *big_img_url;
    @property (nonatomic,copy)id   subcat;
@end
