//
//  Category.h
//  AncientArchitecture
//
//  Created by bryan on 2018/4/2.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CategoryResponse : MJPropertyKey

    @property (nonatomic,strong)NSString   *id;
    @property (nonatomic,strong)NSString   *pid;
    @property (nonatomic,strong)NSString   *category_name;
    @property (nonatomic,strong)NSString   *price;
    @property (nonatomic,strong)NSString   *discount;
    @property (nonatomic,strong)NSString   *describe;
    @property (nonatomic,strong)NSString   *content;
    @property (nonatomic,strong)NSString   *sort;
    @property (nonatomic,strong)NSString   *is_over;
    
    @property (nonatomic,strong)NSString   *start_time;
    @property (nonatomic,strong)NSString   *end_time;
    @property (nonatomic,strong)NSString   *course_num;
    @property (nonatomic,strong)NSString   *course_time;
    
    @property (nonatomic,strong)NSString   *visit_num;
    @property (nonatomic,strong)NSString   *author_id;
    @property (nonatomic,strong)NSString   *img_url;
    @property (nonatomic,strong)NSString   *big_img_url;
    @property (nonatomic,strong)id   subcat;
@end
