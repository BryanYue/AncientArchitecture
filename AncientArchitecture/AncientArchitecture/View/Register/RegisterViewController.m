//
//  RegisterViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/3/19.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "RegisterViewController.h"
#import "MyUITextField.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
MyUITextField * _phoneText;
MyUITextField * _codeText;
MyUITextField * _passwordText;


UIButton * code;
NSTimer *timer;
int count;
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
    
    
    UILabel *title =[UILabel new];
    [title setText:@"注册新用户"];
    [title setTextColor:[UIColor whiteColor]];
    title.font =[UIFont boldSystemFontOfSize:18];
    title.textAlignment=NSTextAlignmentCenter;
    [title setFrame:CGRectMake(0, kScreen_Height/9, kScreen_Width, 20)];
    
    
    _phoneText=[MyUITextField new];
   
    NSAttributedString *attrphone = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:
                                    @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                      NSFontAttributeName:_phoneText.font
                                      }];
    _phoneText.attributedPlaceholder = attrphone;
    _phoneText.textColor=[UIColor whiteColor];
    
    UIImageView *imagelogin=[UIImageView new];
    imagelogin.image =[UIImage imageNamed:@"icon_phone_white"];
    imagelogin.frame=CGRectMake(0, 0, imagelogin.image.size.width, imagelogin.image.size.height);
    _phoneText.leftView=imagelogin;
    _phoneText.leftViewMode=UITextFieldViewModeAlways;
    _phoneText.frame=CGRectMake(40, kScreen_Height/9*2, kScreen_Width/10*5, 40);
    //数字模式键盘
    _phoneText.keyboardType=UIKeyboardTypeNumberPad;
    
    UIView *undline1 =[UIView new ];
    undline1.backgroundColor=[UIColor whiteColor];
    undline1.frame=CGRectMake(40, kScreen_Height/9*2+40, kScreen_Width/10*8, 1);
    
    
    _passwordText=[MyUITextField new];
    
    NSAttributedString *attrpassword = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:
                                     @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                       NSFontAttributeName:_passwordText.font
                                       }];
    _passwordText.attributedPlaceholder = attrpassword;
    _passwordText.textColor=[UIColor whiteColor];
    
    
    UIImageView *imagecode=[UIImageView new];
    imagecode.image =[UIImage imageNamed:@"icon_password_white"];
    imagecode.frame=CGRectMake(0, 0, imagecode.image.size.width, imagecode.image.size.height);
    _passwordText.leftView=imagecode;
    _passwordText.leftViewMode=UITextFieldViewModeAlways;
    _passwordText.frame=CGRectMake(40, kScreen_Height/9*2+41, kScreen_Width/10*8, 40);
    _passwordText.keyboardType=UIKeyboardTypeNumberPad;
    
    UIView *undline2 =[UIView new ];
    undline2.backgroundColor=[UIColor whiteColor];
    undline2.frame=CGRectMake(40, kScreen_Height/9*2+81, kScreen_Width/10*8, 1);
    
    
    _codeText=[MyUITextField new];
   
    NSAttributedString *attrcode = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:
                                     @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                       NSFontAttributeName:_codeText.font
                                       }];
    _codeText.attributedPlaceholder = attrcode;
    _codeText.textColor=[UIColor whiteColor];
    
    UIImageView *imagepasswd=[UIImageView new];
    imagepasswd.image =[UIImage imageNamed:@"icon_password_white"];
    imagepasswd.frame=CGRectMake(0, 0, imagepasswd.image.size.width, imagepasswd.image.size.height);
    _codeText.leftView=imagepasswd;
    _codeText.leftViewMode=UITextFieldViewModeAlways;
    _codeText.frame=CGRectMake(40, kScreen_Height/9*2+82, kScreen_Width/10*8, 40);
    _codeText.keyboardType=UIKeyboardTypeNumberPad;
    
    UIView *undline3 =[UIView new ];
    undline3.backgroundColor=[UIColor whiteColor];
    undline3.frame=CGRectMake(40, kScreen_Height/9*2+122, kScreen_Width/10*8, 1);
    
    
    
    UIButton * btnregister = [UIButton buttonWithType:UIButtonTypeSystem];
    btnregister.frame = CGRectMake(40, kScreen_Height/9*5, kScreen_Width/10*8, 40);
    [btnregister setTitle:@"注册" forState:UIControlStateNormal];
     [btnregister setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnregister.backgroundColor =[UIColor clearColor];
    //    btnregist.layer.masksToBounds=YES;
    //    btnregist.layer.cornerRadius = 20;
    [btnregister.layer setBorderWidth:1.0];
    [btnregister.layer setBorderColor:[UIColor whiteColor].CGColor];
    [btnregister addTarget:self action:@selector(toregister) forControlEvents:UIControlEventTouchUpInside];
    btnregister.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    
    
    code = [UIButton buttonWithType:UIButtonTypeSystem];
    code.frame = CGRectMake(240, kScreen_Height/9*2, statusBar_Height+101, 30);
    [code setTitle:@"获取验证码" forState:UIControlStateNormal];
    [code setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    code.backgroundColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.1];
    code.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    code.layer.masksToBounds=YES;
    code.layer.cornerRadius = 16;
    [code addTarget:self action:@selector(code) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *login =[UILabel new];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"已有账号 去登录"];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 4)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor_ColorChange colorWithHexString:app_theme] range:NSMakeRange(5, 3)];
    login.attributedText=string;
    login.font =[UIFont boldSystemFontOfSize:18];
    login.textAlignment=NSTextAlignmentCenter;
    [login setFrame:CGRectMake(0, kScreen_Height/9*5+60, kScreen_Width, 20)];
    login.userInteractionEnabled = YES;
    [login addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backButtonPress)]];
   
    
    
    [self.view addSubview:bg];
    [self.view addSubview:exit];
    [self.view addSubview:title];
    [self.view addSubview:_phoneText];
    [self.view addSubview:_codeText];
    [self.view addSubview:_passwordText];
    [self.view addSubview:undline1];
    [self.view addSubview:undline2];
    [self.view addSubview:undline3];
    [self.view addSubview:btnregister];
    
    [self.view addSubview:code];
    [self.view addSubview:login];
}





-(void)backButtonPress{
    [self dismissViewControllerAnimated:YES completion:nil];
}





-(void)toregister{
    [self hide];
    if (_phoneText.text.length==0) {
        [self showAction:@"请输入手机号"];
        return;
    }
    if (_passwordText.text.length==0) {
        [self showAction:@"请输入密码"];
        return;
    }
    if (_codeText.text.length==0) {
        [self showAction:@"请输入验证码"];
        return;
    }
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
     [parameterCountry setObject:_phoneText.text forKey:@"phone"];
     [parameterCountry setObject:_passwordText.text forKey:@"password"];
     [parameterCountry setObject:_codeText.text forKey:@"code"];
    [self GeneralButtonAction];
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_Register withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                
                if (self.HUD) {
                    [self.HUD hideAnimated:true];
                }
                [self TextButtonAction:response.msg];
                [self dismissViewControllerAnimated:YES completion:nil];
                
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

-(void)code{
    [self hide];
    if (_phoneText.text.length==0) {
        [self showAction:@"请输入手机号"];
        return;
    }
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    [parameterCountry setObject:_phoneText.text forKey:@"phone"];
    [parameterCountry setObject:@"R" forKey:@"type"];
    
    
    [self GeneralButtonAction];
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_SendSms withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                
                if (self.HUD) {
                    [self.HUD hideAnimated:true];
                }
                [self TextButtonAction:response.msg];
                count = 60;
                timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
                
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



//定时操作，更新UI
- (void)handleTimer {
    if (count == 0) {
        code.userInteractionEnabled = YES;
        [code setTitle:[NSString stringWithFormat:@"发送验证码"] forState:UIControlStateNormal];
        count = 60;
        [timer invalidate];
    } else {
        code.userInteractionEnabled = NO;
        [code setTitle:[NSString stringWithFormat:@"%d秒后重新获取",count] forState:UIControlStateNormal];
    }
    count--;
}


-(void)hide{
    if (_phoneText) {
        [_phoneText resignFirstResponder];
    }
    
    if (_codeText) {
        [_codeText resignFirstResponder];
    }
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [timer invalidate];
    
}


@end
