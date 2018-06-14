//
//  LoginResponse.h
//  AncientArchitecture
//
//  Created by Bryan on 2018/3/26.
//  Copyright © 2018年 通感科技. All rights reserved.
//



@interface LoginResponse : MJPropertyKey

@property (nonatomic,copy)NSString   *token;
@property (nonatomic,copy)NSString   *phone;
@property (nonatomic,copy)NSString   *nickname;
@property (nonatomic,copy)NSString   *nick;
@property (nonatomic,copy)NSString   *is_teacher;
@property (nonatomic,copy)NSString   *birthday;
@property (nonatomic,copy)NSString   *headimgurl;
@property (nonatomic,copy)NSString   *memberid;
@property (nonatomic,copy)NSString   *teacher_id;


@end
