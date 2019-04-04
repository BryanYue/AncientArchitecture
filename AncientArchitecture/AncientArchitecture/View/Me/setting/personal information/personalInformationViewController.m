//
//  personalInformationViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/3/24.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "personalInformationViewController.h"
#import <TZImagePickerController.h>
#import "UserInfoResponse.h"
#import "UIImage+extension.h"
#import "RadioButton.h"
#import "EditDescibreViewController.h"
#import "EditnameViewController.h"
#import "EditnickViewController.h"

#define loginNotification @"loginstatus"
#define editdescibreNotification @"editdescibre"

@interface personalInformationViewController ()
@property (retain,nonatomic)UIImageView  *headimage;
@property (retain,nonatomic)UILabel      *lablenick;
@property (retain,nonatomic)UILabel      *lablenickname;
@property (retain,nonatomic)UILabel      *lablenickposition;
@property (retain,nonatomic)UILabel      *lablenickdescibre;

@property (retain,nonatomic)UIImageView      *image;
@property (retain,nonatomic)RadioButton      *radioButton;
@property (retain,nonatomic)NSMutableArray     *buttons;
@end

@implementation personalInformationViewController
int tab;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initview];
    [self initdata];
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

-(void)initview
{
    [self initbaseView];
    self.view.backgroundColor=[UIColor whiteColor];
    [self addBackButton];
    [self.topTitleLabel setText:@"个人资料"];
    
    UIView *headline=[UIView new];
    headline.frame=CGRectMake(0,self.topView.frame.size.height,kScreen_Width,6);
    headline.backgroundColor =[UIColor_ColorChange colorWithHexString:@"f3f3f3"];
    [self.view addSubview:headline];
    
    NSArray<NSString *> *titletext=@[@"头像",@"姓名",@"昵称",@"性别",@"个人简介"];
    
    
    float y;
    float height;
    for (int i=0; i<titletext.count; i++) {
        switch (i) {
            case 0:
                y=self.topView.frame.size.height+6;
                height=86;
                break;
                
            default:
                y=self.topView.frame.size.height+46*(i+1);
                 height=46;
                break;
        }
        
        UIView *view=[UIView new];
        view.backgroundColor=[UIColor clearColor];
        view.frame=CGRectMake(0, y, kScreen_Width,height );
        
        UILabel *lable=[UILabel new];
        [lable setText:titletext[i]];
        lable.frame=CGRectMake(10, 0, 80,view.frame.size.height-1 );
        lable.textAlignment=NSTextAlignmentCenter;
        lable.textColor=[UIColor blackColor];
        lable.font = [UIFont systemFontOfSize:18];
        UIView *line=[UIView new];
        line.backgroundColor=[UIColor_ColorChange colorWithHexString:@"f3f3f3"];
        line.frame=CGRectMake(0, lable.frame.size.height, kScreen_Width,1 );
        [view addSubview:lable];
        [view addSubview:line];
        
        
        switch (i) {
            case 0:
                _headimage=[UIImageView new];
                _headimage.frame=CGRectMake(kScreen_Width-10-86, 0, lable.frame.size.height,lable.frame.size.height );
                [view addSubview:_headimage];
                break;
            case 1:
                _lablenick=[UILabel new];
                _lablenick.textAlignment=NSTextAlignmentRight;
                _lablenick.textColor=[UIColor_ColorChange colorWithHexString:@"666666"];
                _lablenick.frame=CGRectMake(kScreen_Width-10-kScreen_Width/2, 0, kScreen_Width/2,view.frame.size.height-1 );
                [view addSubview:_lablenick];
                [_lablenick setText:@"点击修改姓名"];
                break;
            case 2:
                _lablenickname=[UILabel new];
                _lablenickname.textAlignment=NSTextAlignmentRight;
                _lablenickname.textColor=[UIColor_ColorChange colorWithHexString:@"666666"];
                _lablenickname.frame=CGRectMake(kScreen_Width-10-kScreen_Width/2, 0, kScreen_Width/2,view.frame.size.height-1 );
                [view addSubview:_lablenickname];
                [_lablenickname setText:@"点击修改昵称"];
                break;
            case 3:
                _buttons = [NSMutableArray arrayWithCapacity:2];
                CGRect btnRect = CGRectMake(kScreen_Width-10-98, 0, 46, 46);
                for (NSString* optionTitle in @[@"男", @"女"]) {
                    RadioButton* btn = [[RadioButton alloc] initWithFrame:btnRect];
                    [btn addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
                    btnRect.origin.x += 46;
                    [btn setTitle:optionTitle forState:UIControlStateNormal];
                    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                    btn.titleLabel.font = [UIFont systemFontOfSize:17];
                    [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
                    [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
                    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
                    [view addSubview:btn];
                    [_buttons addObject:btn];
                }
                
                
                
                
                
                break;
            case 4:
                _image=[[UIImageView alloc] init];
                [_image setImage:[UIImage imageNamed:@"箭头"]];
                _image.frame=CGRectMake(kScreen_Width-10-_image.image.size.width, (46-_image.image.size.height)/2, _image.image.size.width,_image.image.size.height );
                [view addSubview:_image];
                
                _lablenickdescibre=[[UILabel alloc]init];
                _lablenickdescibre.textAlignment=NSTextAlignmentRight;
                _lablenickdescibre.textColor=[UIColor_ColorChange colorWithHexString:@"666666"];
                _lablenickdescibre.frame=CGRectMake(kScreen_Width-15-kScreen_Width/2, 0, kScreen_Width/2-_image.image.size.width,view.frame.size.height-1 );
                [view addSubview:_lablenickdescibre];
                [_lablenickdescibre setText:@"点击修改简介"];
                break;
       ;
            default:
                break;
        }
     
       
        view.userInteractionEnabled = YES;
        [view setTag:i];
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(to:)]];
        [self.view addSubview:view];
    }
}

-(void) onRadioButtonValueChanged:(RadioButton*)sender
{
    // Lets handle ValueChanged event only for selected button, and ignore for deselected
    if(sender.selected) {
        NSLog(@"Selected color: %@", sender.titleLabel.text);
      
      
        
        NSUserDefaults *defaults= DEFAULTS;
        NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
        [parameterCountry setObject:[defaults objectForKey:@"memberid"] forKey:@"memberid"];
        if ([sender.titleLabel.text isEqualToString:@"男"]) {
            [parameterCountry setObject:@"1" forKey:@"sex"];
        } else {
            [parameterCountry setObject:@"2" forKey:@"sex"];
        }
        
        
        [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_editSex withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
            NSLog(@"error%zd",error.code);
            if (!error) {
                BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
                if (response.code  == 200) {
                    NSLog(@"%@",response.data);
                    
        
                    
                }else{
                   
                    
                }
                
                if (self.HUD) {
                    [self.HUD hideAnimated:true];
                }
                [self TextButtonAction:response.msg];
            }else{
                if (self.HUD) {
                    [self.HUD hideAnimated:true];
                }
                [self TextButtonAction:error.domain];
            }
            
        }];
        
        
        
        
    }
}

-(void)initdata
{
    NSUserDefaults *defaults= DEFAULTS;
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    [parameterCountry setObject:[defaults objectForKey:@"memberid"] forKey:@"memberid"];
    
    [self GeneralButtonAction];
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_getUserInfo withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                 NSLog(@"%@",response.data);
                if (self.HUD) {
                    [self.HUD hideAnimated:true];
                }
                UserInfoResponse *userinfo =[UserInfoResponse mj_objectWithKeyValues:response.data];
                [self updateview:userinfo];
                
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


-(void)to:(id)sender
{
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    NSLog (@"%zd",[tapRecognizer.view tag]);
      tab=(int)[tapRecognizer.view tag];
    switch ([tapRecognizer.view tag]) {
        case 0:
           
            [self checkimage];
            
            break;
        case 1:
            [self presentViewController:[EditnickViewController new] animated:YES completion:nil];
            
            
            break;
        case 2:
            [self presentViewController:[EditnameViewController new] animated:YES completion:nil];
            
            
            break;
        case 3:
            
            
            
            break;
        case 4:
            [self presentViewController:[EditDescibreViewController new] animated:YES completion:nil];
            
            
            break;
    
        default:
            break;
    }
}






-(void)checkname:(NSString *)type
{
    NSUserDefaults *defaults= DEFAULTS;
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    [parameterCountry setObject:[defaults objectForKey:@"memberid"] forKey:@"memberid"];
    [parameterCountry setObject:type forKey:@"type"];
    
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_editName withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                NSLog(@"%@",response.data);
                
                
                if (self.HUD) {
                    [self.HUD hideAnimated:true];
                }
                
              
                
                NSDictionary *data =response.data;
                NSString *url=[data objectForKey:@"headimgurl"];
                
          
                [_headimage yy_setImageWithURL:[NSURL URLWithString:url]
                                              placeholder:nil
                                                  options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation
                                                 progress:nil
                                                transform:^UIImage *(UIImage *image, NSURL *url) {
                                                    image = [image yy_imageByResizeToSize:CGSizeMake(_headimage.frame.size.width, _headimage.frame.size.height) contentMode:UIViewContentModeScaleToFill];
                                                    //                            return [image yy_imageByRoundCornerRadius:10];
                                                    return  image;
                                                }
                                               completion:nil];
                
            }else{
                if (self.HUD) {
                    [self.HUD hideAnimated:true];
                }
                [self TextButtonAction:response.msg];
                
            }
        }else{
            if (self.HUD) {
                [self.HUD hideAnimated:true];
            }
            [self TextButtonAction:error.domain];
        }
        
    }];
    

}



-(void)checkimage
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickerVc.title =@"图片";
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        NSLog(@"%zd",photos.count);
        NSData *imageData = UIImageJPEGRepresentation(photos[0], 1.0);
        NSString *encodedString = [imageData base64Encoding];
         NSLog(@"%zd",encodedString);
        
        NSUserDefaults *defaults= DEFAULTS;
        NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
        [parameterCountry setObject:[defaults objectForKey:@"memberid"] forKey:@"memberid"];
        [parameterCountry setObject:encodedString forKey:@"photo_data"];
        
        [self GeneralButtonAction];
        [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_uploadPhoto withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
             NSLog(@"error%zd",error.code);
            if (!error) {
                BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
                if (response.code  == 200) {
                    NSLog(@"%@",response.data);
                    
                    
                    if (self.HUD) {
                        [self.HUD hideAnimated:true];
                    }
                    
                   
                    
                    NSDictionary *data =response.data;
                    NSString *url=[data objectForKey:@"headimgurl"];
                    
            
                  
                    [_headimage yy_setImageWithURL:[NSURL URLWithString:url]
                                                  placeholder:nil
                                                      options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation
                                                     progress:nil
                                                    transform:^UIImage *(UIImage *image, NSURL *url) {
                                                        image = [image yy_imageByResizeToSize:CGSizeMake(_headimage.frame.size.width, _headimage.frame.size.height) contentMode:UIViewContentModeScaleToFill];
                                                        //                            return [image yy_imageByRoundCornerRadius:10];
                                                        return  image;
                                                    }
                                       completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
                                           //  把头像设置成圆形
                                           _headimage.layer.cornerRadius=_headimage.frame.size.width/2;//裁成圆角
                                           _headimage.layer.masksToBounds=YES;//隐藏裁剪掉的部分
                                           //  给头像加一个圆形边框
                                           _headimage.layer.borderWidth = 1.5f;//宽度
                                           _headimage.layer.borderColor = [UIColor whiteColor].CGColor;//颜色
                                           
                                           [[NSNotificationCenter defaultCenter] postNotificationName:loginNotification object:self userInfo:@{@"isLogin":[NSString stringWithFormat:@"%d", true]}];
                                           
                                           
                                           
                                       }];
                    
                    
                    
                }else{
                    if (self.HUD) {
                        [self.HUD hideAnimated:true];
                    }
                    [self TextButtonAction:response.msg];
                    
                }
            }else{
                if (self.HUD) {
                    [self.HUD hideAnimated:true];
                }
                [self TextButtonAction:error.domain];
            }
          
        }];
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}


-(void) updateview:(UserInfoResponse *)user{
    NSLog(@"updateview  user.headimgurl:\n%@",user.headimgurl);
    NSLog(@"updateview  user.nick:\n%@",user.nick);
    NSLog(@"updateview  user.nickname:\n%@",user.nickname);
    NSLog(@"updateview  user.sex:\n%@",user.sex);
    
    NSUserDefaults *defaults =DEFAULTS;
    
    if (user.descibre) {
        [defaults setObject:user.descibre forKey:@"descibre"];
    }
    if (user.push_url) {
        [defaults setObject:user.push_url forKey:@"push_url"];
    }
    if (user.play_url) {
        [defaults setObject:user.play_url forKey:@"play_url"];
    }
    if (user.app_url_name) {
        [defaults setObject:user.app_url_name forKey:@"app_url_name"];
    }
    if (user.stream_name) {
        [defaults setObject:user.stream_name forKey:@"stream_name"];
    }
    
    
    
 
    
    
    [_headimage yy_setImageWithURL:[NSURL URLWithString:user.headimgurl]
                                  placeholder:nil
                                      options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation
                                     progress:nil
                                    transform:^UIImage *(UIImage *image, NSURL *url) {
                                        image = [image yy_imageByResizeToSize:CGSizeMake(_headimage.frame.size.width, _headimage.frame.size.height) contentMode:UIViewContentModeScaleToFill];
                                        //                            return [image yy_imageByRoundCornerRadius:10];
                                        return  image;
                                    }
                       completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
                           //  把头像设置成圆形
                           _headimage.layer.cornerRadius=_headimage.frame.size.width/2;//裁成圆角
                           _headimage.layer.masksToBounds=YES;//隐藏裁剪掉的部分
                           //  给头像加一个圆形边框
                           _headimage.layer.borderWidth = 1.5f;//宽度
                           _headimage.layer.borderColor = [UIColor whiteColor].CGColor;//颜色
                           
                       }];
    
    
    
    if (user.nick) {
        [_lablenick setText:user.nick];
    }
    
    if (user.nickname) {
        [_lablenickname setText:user.nickname];
    }
    if (user.position) {
        [_lablenickposition setText:user.position];
    }
    
    if ([user.sex  isEqualToString:@"1"]) {
        [_buttons[0] setGroupButtons:_buttons]; // Setting buttons into the group
        [_buttons[0] setSelected:YES]; // Making the first button initially selected
    }else{
        [_buttons[0] setGroupButtons:_buttons]; // Setting buttons into the group
        [_buttons[0] setSelected:YES]; // Making the first button initially selected
    }
   
    
    if (user.descibre) {
         [_lablenickdescibre setText:user.descibre];
    }else{
         [_lablenickdescibre setText:@"点击修改简介"];
    }
}


-(void)Alertdo:(NSString *)string
{
    [super Alertdo:string];
    switch (tab) {
        case 1:
            [self editname:string edittype:@"1"];
            break;
            
        case 2:
            [self editname:string edittype:@"2"];
            break;
            
        case 4:
            [self editPosition:string];
            break;
        default:
            break;
    }
    
}

-(void)editname:(NSString *)user_name edittype:(NSString *)type
{
    NSUserDefaults *defaults= DEFAULTS;
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    [parameterCountry setObject:[defaults objectForKey:@"memberid"] forKey:@"memberid"];
    [parameterCountry setObject:type forKey:@"type"];
    [parameterCountry setObject:user_name forKey:@"user_name"];
    
    [self GeneralButtonAction];
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_editName withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                NSLog(@"%@",response.data);
                
                NSDictionary *data =response.data;
                NSString *user_name=[data objectForKey:@"user_name"];
                if (tab==1) {
                    [_lablenick setText:user_name];
                }else if (tab==2){
                    [_lablenickname setText:user_name];
                }
            
                
             [[NSNotificationCenter defaultCenter] postNotificationName:loginNotification object:self userInfo:@{@"isLogin":[NSString stringWithFormat:@"%d", true]}];
          
            
            }else{
              
            }
            
            if (self.HUD) {
                [self.HUD hideAnimated:true];
            }
            [self TextButtonAction:response.msg];
            
        }else{
            if (self.HUD) {
                [self.HUD hideAnimated:true];
            }
            [self TextButtonAction:error.domain];
        }
        
    }];
}


-(void)editPosition:(NSString *)Position
{
    NSUserDefaults *defaults= DEFAULTS;
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    [parameterCountry setObject:[defaults objectForKey:@"memberid"] forKey:@"memberid"];
    [parameterCountry setObject:Position forKey:@"position"];
    
    [self GeneralButtonAction];
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_editPosition withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                NSLog(@"%@",response.data);
                
     
                [_lablenickposition setText:Position];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:loginNotification object:self userInfo:@{@"isLogin":[NSString stringWithFormat:@"%d", true]}];
                
                
            }else{
                 [self TextButtonAction:response.msg];
            }
            
            if (self.HUD) {
                [self.HUD hideAnimated:true];
            }
           
            
        }else{
            if (self.HUD) {
                [self.HUD hideAnimated:true];
            }
            [self TextButtonAction:error.domain];
        }
        
    }];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //注册观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editdescibre:) name:editdescibreNotification object:nil];
}


- (void)dealloc
{
    [self animated];
}


-(void)animated{
    //移除观察者 self
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)editdescibre:(NSNotification *)sender
{
    NSDictionary *dic =sender.userInfo ;
    NSString *edi = [dic objectForKey:@"editdescibre"];
    NSString *name = [dic objectForKey:@"name"];
    NSString *nick = [dic objectForKey:@"nick"];
    [[NSNotificationCenter defaultCenter] postNotificationName:loginNotification object:self userInfo:@{@"isLogin":[NSString stringWithFormat:@"%d", true]}];
    if (edi) {
        [_lablenickdescibre setText:edi];
    }
    if (name) {
        [_lablenickname setText:name];
    }
    
    if (nick) {
        [_lablenick setText:nick];
    }
}

@end
