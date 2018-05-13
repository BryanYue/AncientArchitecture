//
//  LoginViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/3/19.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "LoginViewController.h"
#import "MyUITextField.h"
#import "RegisterViewController.h"
#import "LoginResponse.h"

#define loginNotification @"loginstatus"


@interface LoginViewController ()<UITextFieldDelegate>


@end

@implementation LoginViewController
MyUITextField * _loginText;
MyUITextField * _passwdText;
UIButton * btnlogin;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initview];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)initview{
    UIImageView *bg=[UIImageView new];
    bg.frame =CGRectMake(0, 0, kScreen_Width, kScreen_Height);
    [bg setImage:[UIImage imageNamed:@"img_login_bg"] ];
    bg.userInteractionEnabled = YES;
    [bg addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)]];
    
    UIButton *exit =[UIButton buttonWithType:UIButtonTypeCustom];
    [exit setTitle:@"返回" forState:UIControlStateNormal];
    [exit setImage:[UIImage imageNamed:@"nav_icon_back"] forState:UIControlStateNormal];
    [exit setTintColor:[UIColor whiteColor]];
    exit.titleLabel.font =[UIFont boldSystemFontOfSize:15];
    [exit setFrame:CGRectMake(11, statusBar_Height+5, 50, 18)];
    //
    exit.titleEdgeInsets = UIEdgeInsetsMake(0,0,0,-10);
    [exit addTarget:self action:@selector(backButtonPress) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *titleimage =[UIImageView new];
    [titleimage setImage:[UIImage imageNamed:@"img_logo_red"]];
    [titleimage setFrame:CGRectMake(kScreen_Width/2-titleimage.image.size.width/2, kScreen_Height/9*2-titleimage.image.size.height, titleimage.image.size.width, titleimage.image.size.height)];
    
    UILabel *title =[UILabel new];
    [title setText:@"非物质"];
    [title setTextColor:[UIColor_ColorChange colorWithHexString:app_theme]];
    title.font =[UIFont boldSystemFontOfSize:25];
    title.textAlignment=NSTextAlignmentCenter;
    [title setFrame:CGRectMake(0, kScreen_Height/9*2+20, kScreen_Width, 20)];
   
    
    _loginText=[MyUITextField new];
   
    NSAttributedString *attrlogin = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:
                                      @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                        NSFontAttributeName:_loginText.font
                                        }];
    _loginText.attributedPlaceholder = attrlogin;
    _loginText.textColor=[UIColor whiteColor];
    UIImageView *imagelogin=[UIImageView new];
    imagelogin.image =[UIImage imageNamed:@"icon_phone_white"];
    imagelogin.frame=CGRectMake(0, 0, imagelogin.image.size.width, imagelogin.image.size.height);
    _loginText.leftView=imagelogin;
    _loginText.leftViewMode=UITextFieldViewModeAlways;
    _loginText.frame=CGRectMake(40, kScreen_Height/9*3, kScreen_Width/10*8, 40);
    //数字模式键盘
    _loginText.keyboardType=UIKeyboardTypeNumberPad;
   
    UIView *undline1 =[UIView new ];
    undline1.backgroundColor=[UIColor whiteColor];
    undline1.frame=CGRectMake(40, kScreen_Height/9*3+41, kScreen_Width/10*8, 1);
    
   
    _passwdText=[MyUITextField new];

    NSAttributedString *attrpasswd = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:
                                     @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                       NSFontAttributeName:_passwdText.font
                                       }];
    _passwdText.attributedPlaceholder = attrpasswd;
     _passwdText.textColor=[UIColor whiteColor];
    UIImageView *imagepasswd=[UIImageView new];
    imagepasswd.image =[UIImage imageNamed:@"icon_password_white"];
    imagepasswd.frame=CGRectMake(0, 0, imagepasswd.image.size.width, imagepasswd.image.size.height);
    _passwdText.leftView=imagepasswd;
    _passwdText.leftViewMode=UITextFieldViewModeAlways;
    _passwdText.frame=CGRectMake(40, kScreen_Height/9*3+41, kScreen_Width/10*8, 40);
    UIView *undline2 =[UIView new ];
    undline2.backgroundColor=[UIColor whiteColor];
    undline2.frame=CGRectMake(40, kScreen_Height/9*3+82, kScreen_Width/10*8, 1);
    
    
    //创建登录按钮和注册按钮
    btnlogin = [UIButton buttonWithType:UIButtonTypeSystem];
    btnlogin.frame = CGRectMake(40, kScreen_Height/9*5, kScreen_Width/10*8, 40);
    [btnlogin setTitle:@"登录" forState:UIControlStateNormal];
    [btnlogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnlogin.backgroundColor =[UIColor_ColorChange colorWithHexString:app_theme];
//    btnlogin.layer.masksToBounds=YES;
//    btnlogin.layer.cornerRadius = 20;
   
    [btnlogin addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    btnlogin.titleLabel.font = [UIFont boldSystemFontOfSize:15];
  
    
    UIButton * btnregist = [UIButton buttonWithType:UIButtonTypeSystem];
    btnregist.frame = CGRectMake(40, kScreen_Height/9*5+55, kScreen_Width/10*8, 40);
    [btnregist setTitle:@"注册" forState:UIControlStateNormal];
    [btnregist setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
 
    btnregist.backgroundColor =[UIColor clearColor];
//    btnregist.layer.masksToBounds=YES;
//    btnregist.layer.cornerRadius = 20;
    [btnregist.layer setBorderWidth:1.0];
    [btnregist.layer setBorderColor:[UIColor whiteColor].CGColor];
    btnregist.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [btnregist addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    
    
    //微信登陆
    UILabel *wechattitle =[UILabel new ];
    [wechattitle setText:@"微信登录"];
    [wechattitle setTextColor:[UIColor whiteColor]];
    wechattitle.font =[UIFont boldSystemFontOfSize:12];
    wechattitle.textAlignment=NSTextAlignmentCenter;
    [wechattitle setFrame:CGRectMake(kScreen_Width/2-30, kScreen_Height/9*7, 60, 20)];
    
    UIView *undline3 =[UIView new ];
    undline3.backgroundColor=[UIColor whiteColor];
    undline3.frame=CGRectMake(40, kScreen_Height/9*7+10, kScreen_Width/2-70, 1);
    UIView *undline4 =[UIView new ];
    undline4.backgroundColor=[UIColor whiteColor];
    undline4.frame=CGRectMake(kScreen_Width/2+30, kScreen_Height/9*7+10, kScreen_Width/2-70, 1);
    
    
    UIButton *wechatbutton=[UIButton new];
    [wechatbutton setImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
//    [wechatbutton setTitle: @"微信" forState:UIControlStateNormal];
    [wechatbutton setTitleColor:[UIColor_ColorChange whiteColor] forState:UIControlStateNormal];
    wechatbutton.backgroundColor=[UIColor clearColor];
    wechatbutton.frame = CGRectMake(kScreen_Width/2-23, kScreen_Height/9*7+35, 46, 75);
//    [wechatbutton layoutIfNeeded];
//    wechatbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    CGFloat interImageTitleSpacing = 15;
//    // 图片上移，右移
//    wechatbutton.imageEdgeInsets = UIEdgeInsetsMake(0,
//                                              0,
//                                              wechatbutton.titleLabel.frame.size.height + interImageTitleSpacing,
//                                              -(wechatbutton.titleLabel.frame.size.width));
//
//    // 文字下移，左移
//    wechatbutton.titleEdgeInsets = UIEdgeInsetsMake(wechatbutton.imageView.frame.size.height + interImageTitleSpacing,
//                                              -(wechatbutton.imageView.frame.size.width),
//                                              0,
//                                              0);
    
    [self.view addSubview:bg];
    [self.view addSubview:exit];
    [self.view addSubview:titleimage];
    [self.view addSubview:title];
    [self.view addSubview:_loginText];
    [self.view addSubview:_passwdText];
    _loginText.delegate =self;
    _passwdText.delegate =self;
    
    [self.view addSubview:undline1];
    [self.view addSubview:undline2];
    [self.view addSubview:btnlogin];
    [self.view addSubview:btnregist];
    
    [self.view addSubview:wechattitle];
    [self.view addSubview:undline3];
    [self.view addSubview:undline4];
    
    [self.view addSubview:wechatbutton];
}

-(void)backButtonPress{
    [self dismissViewControllerAnimated:YES completion:nil];
}




-(void)login{
    [self hide];
    if (_loginText.text.length==0) {
        [self showAction:@"请输入手机号"];
        return;
    }
    if (_passwdText.text.length==0) {
        [self showAction:@"请输入密码"];
        return;
    }
     btnlogin.userInteractionEnabled = NO;
    
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    [parameterCountry setObject:_loginText.text forKey:@"phone"];
    [parameterCountry setObject:_passwdText.text forKey:@"password"];
    [parameterCountry setObject:@"68:3e:34:95:f9:a3" forKey:@"equipment_mac"];
    [parameterCountry setObject:@"192.168.1.1" forKey:@"equipment_ip"];
    [parameterCountry setObject:@"ios" forKey:@"equipment_name"];
    

    [self GeneralButtonAction];
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_Login withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        btnlogin.userInteractionEnabled = YES;
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                LoginResponse *login = [LoginResponse mj_objectWithKeyValues:response.data];
                NSLog(@"%@",login.token);
                NSLog(@"%@",login.phone);
                NSLog(@"%@",login.memberid);
                
                NSUserDefaults *defaults =DEFAULTS;
                
                if (login.token) {
                    [defaults setObject:login.token forKey:@"token"];
                }
                if (login.phone) {
                    [defaults setObject:login.phone forKey:@"phone"];
                }
                if (login.nickname) {
                    [defaults setObject:login.nickname forKey:@"nickname"];
                }
                if (login.nick) {
                    [defaults setObject:login.nick forKey:@"nick"];
                }
                if (login.is_teacher) {
                    [defaults setObject:login.is_teacher forKey:@"is_teacher"];
                }
                if (login.birthday) {
                    [defaults setObject:login.birthday forKey:@"birthday"];
                }
                if (login.is_teacher) {
                    [defaults setObject:login.is_teacher forKey:@"is_teacher"];
                }
                if (login.headimgurl) {
                    [defaults setObject:login.headimgurl forKey:@"headimgurl"];
                }
                if (login.memberid) {
                    [defaults setObject:login.memberid forKey:@"memberid"];
                }
                if (login.teacher_id) {
                    [defaults setObject:login.teacher_id forKey:@"teacher_id"];
                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:loginNotification object:self userInfo:@{@"isLogin":[NSString stringWithFormat:@"%d", true]}];
                [self dismissViewControllerAnimated:YES completion:nil];
                
                if (self.HUD) {
                    [self.HUD hideAnimated:true];
                }
                
            }else{
                if (self.HUD) {
                    [self.HUD hideAnimated:true];
                }
                [self TextButtonAction:response.msg];
            }
        } else {
            
                if (self.HUD) {
                    [self.HUD hideAnimated:true];
                }
                [self TextButtonAction:error.domain];
            
        }

    }];
    
}

-(void)regist{
    [self presentViewController:[RegisterViewController new] animated:YES completion:nil];
}


-(void)wechatlogin{
    
    
}










-(void)hide{
    if (_loginText) {
        [_loginText resignFirstResponder];
    }
    
    if (_passwdText) {
        [_passwdText resignFirstResponder];
    }
}















@end
