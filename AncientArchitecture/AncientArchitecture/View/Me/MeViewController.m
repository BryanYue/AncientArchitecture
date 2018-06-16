//
//  MeViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/3/15.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "MeViewController.h"
#import "SettingViewController.h"
#import "LoginViewController.h"
#import "postPpreviewViewController.h"
#import "TeacheCourseViewController.h"
#import "uploadCourseViewController.h"
#import "UserInfoResponse.h"
#import "personalInformationViewController.h"
#import "myCourseViewController.h"
#import "AboutusViewController.h"


#define loginNotification @"loginstatus"

// 宽度(自定义)
#define PIC_WIDTH kScreen_Width/3
// 高度(自定义)
#define PIC_HEIGHT kScreen_Width/3
// 列数(自定义)
#define COL_COUNT 3


@interface MeViewController ()



@end

@implementation MeViewController
UILabel *username;
UILabel *userid;
UIImageView *imageView;

NSArray<NSString *> *pictures;
NSArray<NSString *> *title;
CGFloat high;
NSUserDefaults *defaults;
bool islogin=false;
NSString *isteacher;




- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    NSLog(@"%f",kScreen_Width);
    NSLog(@"%f",statusBar_Height);
    self.view.backgroundColor=[UIColor_ColorChange colorWithHexString:@"f3f3f3"];
    
    defaults =DEFAULTS;
    islogin = [defaults objectForKey:@"islogin"];

    isteacher=[defaults objectForKey:@"is_teacher"];
    NSLog(@"islogin: %@" ,islogin?@"YES":@"NO");
    NSLog(@"isteacher: %@" ,isteacher);
    //注册观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginstatus:) name:loginNotification object:nil];
    [self initview];
    if (islogin) {
         [self initdata];
    }
   
   
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

/** 九宫格形式添加图片 */
-(void)initview {
    
   
    [self initbaseView];
   high=kScreen_Height-PIC_WIDTH*3-49-statusBar_Height;

    NSMutableArray *picArray = [NSMutableArray array];
    NSMutableArray *titleName =[NSMutableArray array];
    
    if ([isteacher isEqualToString:@"1"] ) {
        [picArray addObject:@"发布预播"];
        [titleName addObject:@"发布预播"];
        
        [picArray addObject:@"开始直播"];
        [titleName addObject:@"开始直播"];
        
//        [picArray addObject:@"上传"];
//        [titleName addObject:@"上传课程"];
    }
    [picArray addObject:@"课程"];
    [titleName addObject:@"我的课程"];
    
    [picArray addObject:@"客服"];
    [titleName addObject:@"联系客服"];
    
    [picArray addObject:@"关于我们"];
    [titleName addObject:@"关于我们"];
    
    [picArray addObject:@"设置"];
    [titleName addObject:@"设置"];
    
    [picArray addObject:@"退出"];
    if (islogin) {
        [titleName addObject:@"退出"];
    }else{
        [titleName addObject:@"登录"];
    }
    
//    for (int i = 0; i < 9; i++) {
//        NSString *imageName = [NSString stringWithFormat:@"课程"];
//        [picArray addObject:imageName];
//    }
    pictures = picArray.copy;
    title =titleName.copy;
   
    
    
    // 循环的次数代表将要创建图片个数，不要忘了这个for循环
    // pictures.count中的pictures是一个图片数组，代表着要添加多少个图片
    for (int i = 0; i < pictures.count; i++) {
        //创建图片
//        UIImageView *imageView = [[UIImageView alloc] init];
//        imageView.image = [UIImage imageNamed:pictures[i]];
        UIButton *button=[[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:pictures[i]] forState:UIControlStateNormal];
        [button setTitle: title[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor_ColorChange colorWithHexString:@"333333"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.backgroundColor=[UIColor whiteColor];
        
      
        // 图片所在行
        NSInteger row = i / COL_COUNT;
        // 图片所在列
        NSInteger col = i % COL_COUNT;
        // 间距
//        CGFloat margin = (self.view.bounds.size.width - (PIC_WIDTH * COL_COUNT)) / (COL_COUNT + 1);
        // PointX
        CGFloat picX = 1 + (PIC_WIDTH + 1) * col;
        // PointY
        CGFloat picY = 1 + (PIC_HEIGHT + 1) * row;
        
        
        // 图片的frame
//        imageView.frame = CGRectMake(picX, picY+220.0+statusBar_Height, PIC_WIDTH, PIC_HEIGHT);
        button.frame = CGRectMake(picX, picY+high, PIC_WIDTH, PIC_HEIGHT);
        [button layoutIfNeeded];
        
       
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;  // 水平方向整体居中
        // 目标图文间距
        CGFloat interImageTitleSpacing = 10;
        
        // 图片上移，右移
        button.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                  0,
                                                  button.titleLabel.frame.size.height + interImageTitleSpacing,
                                                  -(button.titleLabel.frame.size.width));
        
        // 文字下移，左移
        button.titleEdgeInsets = UIEdgeInsetsMake(button.imageView.frame.size.height + interImageTitleSpacing,
                                                  -(button.imageView.frame.size.width),
                                                  0,
                                                  0);
        
        [button setTag:i];
        [button addTarget:self action:@selector(changeColor:) forControlEvents: UIControlEventTouchUpInside];
        
        
        
     
       
        [self.view addSubview:button];
        
    }
    
    
    [self initavr];
}


-(void)initavr{
    UIView *avr = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, high)];
    avr.backgroundColor =[UIColor_ColorChange colorWithHexString:app_theme];
    
    UIImageView *message =[[UIImageView alloc]init];
    message.image=[UIImage imageNamed:@"消息"];
    message.frame = CGRectMake(10, 6+statusBar_Height, message.image.size.width, message.image.size.height);
    message.userInteractionEnabled = YES;
    [message addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toMessage)]];
   
    UIImageView *edit =[[UIImageView alloc]init];
    edit.image=[UIImage imageNamed:@"编辑"];
    edit.frame = CGRectMake(kScreen_Width-10-message.image.size.width, 6+statusBar_Height, message.image.size.width, message.image.size.height);
    edit.userInteractionEnabled = YES;
    [edit addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toEdit)]];
    
    

    if (islogin) {
         username =[[UILabel alloc]init];
        if ([defaults objectForKey:@"nickname"]) {
            username.text=[NSString stringWithFormat:@"%@%@", @"您好！ ", [defaults objectForKey:@"nickname"]];
        }else{
            if ([defaults objectForKey:@"nick"]) {
                username.text=[NSString stringWithFormat:@"%@%@", @"您好！ ", [defaults objectForKey:@"nick"]];
            }else{
                username.text=[NSString stringWithFormat:@"%@%@", @"您好！ ", [defaults objectForKey:@"phone"]];
            }
        }
        
        
        username.font = [UIFont systemFontOfSize:18];
        username.textColor=[UIColor whiteColor];
        username.textAlignment=NSTextAlignmentCenter;
        username.frame = CGRectMake(0, high/4*3, kScreen_Width, 20);
        [avr addSubview:username];
        
        userid =[[UILabel alloc]init];
        NSString *phone=[defaults objectForKey:@"phone"];
        
        userid.text=[NSString stringWithFormat:@"%@%@", @"ID: ", phone];
        userid.font = [UIFont systemFontOfSize:15];
        userid.textColor=[UIColor whiteColor];
        userid.textAlignment=NSTextAlignmentCenter;
        userid.frame = CGRectMake(0, high/4*3+25, kScreen_Width, 20);
        [avr addSubview:userid];
        
        
        imageView = [[UIImageView alloc]init];
        imageView.frame=CGRectMake(kScreen_Width/2-75/2, high/4+statusBar_Height,75,75);
        imageView.backgroundColor =[UIColor clearColor];
        [avr addSubview:imageView];
   
    
    }else{
        UILabel *username =[[UILabel alloc]init];
        username.text=@"请登陆";
        username.font = [UIFont systemFontOfSize:18];
        username.textColor=[UIColor whiteColor];
        username.textAlignment=NSTextAlignmentCenter;
        username.frame = CGRectMake(0, high/4*3, kScreen_Width, 20);
        username.userInteractionEnabled = YES;
        [username addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toLogin)]];
        [avr addSubview:username];
    }
    
    
    
    [avr addSubview:message];
    [avr addSubview:edit];
    
    [self.view addSubview:avr];
}





-(void)changeColor:(UIButton *)button{
    NSLog(@"========%zd",[button tag]);
    if (!islogin) {
        [self toLogin];
    }else{
        if ([isteacher isEqualToString:@"1"]) {
            switch ([button tag]) {
                case 0:
                    [self presentViewController:[postPpreviewViewController new] animated:YES completion:nil];
                    break;
                case 1:
                    [self presentViewController:[TeacheCourseViewController new] animated:YES completion:nil];
                    break;
                case 2:
                    [self presentViewController:[myCourseViewController new] animated:YES completion:nil];
                    break;
                case 3:
                    
                    break;
                case 4:
                     [self presentViewController:[AboutusViewController new] animated:YES completion:nil];
                    
                    break;
                case 5:
                     [self presentViewController:[SettingViewController new] animated:YES completion:nil];
                    break;
                case 6:
                     [self loginout];
                   
                    break;
                case 7:
                   
                    break;
                
            }
        }else{
            switch ([button tag]) {
                case 0:
                     [self presentViewController:[myCourseViewController new] animated:YES completion:nil];
                    break;
                case 3:
                    
                    [self presentViewController:[SettingViewController new] animated:YES completion:nil];
                    break;
                case 4:
                    [self loginout];
                    break;
                default:
                    break;
            }
        }

        
    }
   
 }


 -(void)toMessage{
         NSLog(@"消息");
     if (islogin) {
       
     }else{
         [self toLogin];
     }
 }

-(void)toEdit{
    NSLog(@"编辑");

    if (islogin) {
        [self presentViewController:[personalInformationViewController new] animated:YES completion:nil];
    }else{
        [self toLogin];
    }
}

-(void)toLogin{
    NSLog(@"登陆");
     [self presentViewController:[LoginViewController new] animated:YES completion:nil];
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
                UserInfoResponse *userinfo =[UserInfoResponse mj_objectWithKeyValues:response.data];
                if (userinfo.nick) {
                    username.text=[NSString stringWithFormat:@"%@%@", @"您好！ ", userinfo.nick];
                }else{
                    if (userinfo.nickname) {
                        username.text=[NSString stringWithFormat:@"%@%@", @"您好！ ", userinfo.nickname];
                    }else{
                        username.text=[NSString stringWithFormat:@"%@%@", @"您好！ ", [defaults objectForKey:@"phone"]];
                    }
                }
                userid.text=[NSString stringWithFormat:@"%@%@", @"ID: ", [defaults objectForKey:@"memberid"]];
            
                
                
                [imageView yy_setImageWithURL:[NSURL URLWithString:userinfo.headimgurl]
                                              placeholder:nil
                                                  options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation
                                                 progress:nil
                                                transform:^UIImage *(UIImage *image, NSURL *url) {
                                                    image = [image yy_imageByResizeToSize:CGSizeMake(75, 75) contentMode:UIViewContentModeScaleToFill];
                                                    //                            return [image yy_imageByRoundCornerRadius:10];
                                                    return  image;
                                                }
                                               completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
                                                   //  把头像设置成圆形
                                                   imageView.layer.cornerRadius=imageView.frame.size.width/2;//裁成圆角
                                                   imageView.layer.masksToBounds=YES;//隐藏裁剪掉的部分
                                                   //  给头像加一个圆形边框
                                                   imageView.layer.borderWidth = 1.5f;//宽度
                                                   imageView.layer.borderColor = [UIColor whiteColor].CGColor;//颜色
                                               }];
                
                
                
                
              
                NSUserDefaults *defaults =DEFAULTS;
                if (userinfo.descibre) {
                    [defaults setObject:userinfo.descibre forKey:@"descibre"];
                }
                if (userinfo.push_url) {
                    [defaults setObject:userinfo.push_url forKey:@"push_url"];
                }
                if (userinfo.play_url) {
                    [defaults setObject:userinfo.play_url forKey:@"play_url"];
                }
                if (userinfo.app_url_name) {
                    [defaults setObject:userinfo.app_url_name forKey:@"app_url_name"];
                }
                if (userinfo.stream_name) {
                    [defaults setObject:userinfo.stream_name forKey:@"stream_name"];
                }
                if (userinfo.headimgurl) {
                    [defaults setObject:userinfo.stream_name forKey:@"headimgurl"];
                }
                
            }else if(response.code  == 6){
                [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                [defaults setBool:false forKey:@"islogin"];
                [defaults removeObjectForKey:@"islogin"];
                [defaults removeObjectForKey:@"token"];
                [defaults removeObjectForKey:@"is_teacher"];
                [defaults synchronize];
                islogin=false;
                isteacher=false;
                 [self initview];
                 [self TextButtonAction:response.msg];
            }
            
            if (self.HUD) {
                [self.HUD hideAnimated:true];
            }
           
            
        } else {
            if (self.HUD) {
                [self.HUD hideAnimated:true];
            }
            [self TextButtonAction:error.domain];
        }
        
        
    }];
    
    
    if (isteacher) {
        NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
        [parameterCountry setObject:[defaults objectForKey:@"memberid"] forKey:@"memberid"];
         [parameterCountry setObject:[defaults objectForKey:@"teacher_id"] forKey:@"teacher_id"];
       

        [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_getTeacher withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
            if (!error) {
                BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
                if (response.code  == 200) {
                    NSLog(@"%@",response.data);
                   
                    NSDictionary *data =response.data;
                    NSString *name=[data objectForKey:@"name"];
                    NSString *photo=[data objectForKey:@"photo"];
                    NSUserDefaults *defaults =DEFAULTS;
                     [defaults removeObjectForKey:@"name"];
                    [defaults removeObjectForKey:@"photo"];
                    if (name) {
                        [defaults setObject:name forKey:@"teacher_name"];
                    }
                    if (photo) {
                         [defaults setObject:photo forKey:@"teacher_photo"];
                    }
             
                    
                }

                
                
            }
 
        }];
    }
    
    
}





-(void)loginout{
    if (islogin) {
        NSLog (@"退出");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退出" message:@"您确定退出登陆？" preferredStyle:UIAlertControllerStyleActionSheet];
        // 设置popover指向的item
        alert.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItem;
        
        // 添加按钮
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            //
            //        [[NSNotificationCenter defaultCenter] postNotificationName:loginNotification object:self userInfo:@{@"isLogin":[NSString stringWithFormat:@"%d", false]}];
            //
            //        [self dismissViewControllerAnimated:YES completion:nil];
            if(islogin){
                NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
                [parameterCountry setObject:[defaults objectForKey:@"memberid"] forKey:@"memberid"];
                [self GeneralButtonAction];
                [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_signout withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
                    
                    if (!error) {
                        BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
                        if (response.code  == 200) {
                            if (self.HUD) {
                                [self.HUD hideAnimated:true];
                            }
                            [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                            //            [defaults setBool:false forKey:@"islogin"];
                            [defaults removeObjectForKey:@"islogin"];
                            [defaults removeObjectForKey:@"token"];
                            [defaults removeObjectForKey:@"is_teacher"];
                            [defaults synchronize];
                            islogin=false;
                            isteacher=false;
                            [self initview];
                        }else{
                          [self TextButtonAction:response.msg];
                            
                        }
                        if (self.HUD) {
                            [self.HUD hideAnimated:true];
                        }
                        
                    } else {
                        if (self.HUD) {
                            [self.HUD hideAnimated:true];
                        }
                        [self TextButtonAction:error.domain];
                    }
                    
                }];
            }
            
            
            
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSLog(@"点击了取消按钮");
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }else{
          [self toLogin];
    }
   
    
    
}










- (void)dealloc
{
   [self animated];
}


-(void)animated{
   //移除观察者 self
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//收到通知
-(void)loginstatus:(NSNotification *)sender{
   
    NSDictionary *dic =sender.userInfo ;
    BOOL b = [dic[@"isLogin"] isEqualToString:@"0"]?NO:YES;
    if (b) {
        //
        NSLog(@"观察者登录");
        if (!islogin) {
            NSLog(@"刷新view");
            [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [defaults setBool:true forKey:@"islogin"];
             isteacher=[defaults objectForKey:@"is_teacher"];
            [defaults synchronize];
            islogin=true;
            [self initview];
            [self initdata];
        
        }else{
             [self initdata];
        }
    }else{
        NSLog(@"观察者退出");
        if (islogin) {
             NSLog(@"移除view");
      
            [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//            [defaults setBool:false forKey:@"islogin"];
            [defaults removeObjectForKey:@"islogin"];
             [defaults removeObjectForKey:@"token"];
            [defaults removeObjectForKey:@"is_teacher"];
            [defaults synchronize];
            islogin=false;
            isteacher=false;
            [self initview];
        }
       
        
        
    }
}













@end
