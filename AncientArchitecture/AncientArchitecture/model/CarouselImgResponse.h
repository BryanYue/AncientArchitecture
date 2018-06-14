//
//  CarouselImgResponse.h
//  AncientArchitecture
//
//  Created by bryan on 2018/5/12.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarouselImgResponse : MJPropertyKey
@property (nonatomic,copy)NSString   *id;
@property (nonatomic,copy)NSString   *title;
@property (nonatomic,copy)NSString   *url;
@property (nonatomic,copy)NSString   *sort;
@property (nonatomic,copy)NSString   *img_url;

@end
