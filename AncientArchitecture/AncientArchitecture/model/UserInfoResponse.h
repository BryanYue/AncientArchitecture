//
//  UserInfoResponse.h
//  AncientArchitecture
//
//  Created by Bryan on 2018/3/28.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoResponse : MJPropertyKey

@property (nonatomic,copy)NSString   *headimgurl;
@property (nonatomic,copy)NSString   *nick;
@property (nonatomic,copy)NSString   *nickname;
@property (nonatomic,copy)NSString   *sex;
@property (nonatomic,copy)NSString   *descibre;
@property (nonatomic,copy)NSString   *position;
@property (nonatomic,copy)NSString   *push_url;
@property (nonatomic,copy)NSString   *play_url;
@property (nonatomic,copy)NSString   *app_url_name;
@property (nonatomic,copy)NSString   *stream_name;
@end
