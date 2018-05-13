//
//  LoginResponse.h
//  AncientArchitecture
//
//  Created by Bryan on 2018/3/26.
//  Copyright © 2018年 通感科技. All rights reserved.
//



@interface LoginResponse : MJPropertyKey

@property (nonatomic,strong)NSString   *token;
@property (nonatomic,strong)NSString   *phone;
@property (nonatomic,strong)NSString   *nickname;
@property (nonatomic,strong)NSString   *nick;
@property (nonatomic,strong)NSString   *is_teacher;
@property (nonatomic,strong)NSString   *birthday;
@property (nonatomic,strong)NSString   *headimgurl;
@property (nonatomic,strong)NSString   *memberid;
@property (nonatomic,strong)NSString   *teacher_id;


@end
