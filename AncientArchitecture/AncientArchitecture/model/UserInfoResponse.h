//
//  UserInfoResponse.h
//  AncientArchitecture
//
//  Created by Bryan on 2018/3/28.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoResponse : MJPropertyKey

@property (nonatomic,strong)NSString   *headimgurl;
@property (nonatomic,strong)NSString   *nick;
@property (nonatomic,strong)NSString   *nickname;
@property (nonatomic,strong)NSString   *sex;
@property (nonatomic,strong)NSString   *descibre;
@property (nonatomic,strong)NSString   *position;
@property (nonatomic,strong)NSString   *push_url;
@property (nonatomic,strong)NSString   *play_url;
@property (nonatomic,strong)NSString   *app_url_name;
@property (nonatomic,strong)NSString   *stream_name;
@end
