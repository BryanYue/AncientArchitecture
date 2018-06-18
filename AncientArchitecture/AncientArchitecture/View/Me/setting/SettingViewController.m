//
//  SettingViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/3/18.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "SettingViewController.h"
#import "personalInformationViewController.h"
#import "accountSettingsViewController.h"
#import "LLFileTool.h"

#define loginNotification @"loginstatus"
#define cachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface SettingViewController ()

@end

@implementation SettingViewController

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
    [self initbaseView];
    self.view.backgroundColor=[UIColor whiteColor];
    [self addBackButton];
    [self.topTitleLabel setText:@"设置"];
    
    UIView *headline=[UIView new];
    headline.frame=CGRectMake(0,self.topView.frame.size.height,kScreen_Width,6);
    headline.backgroundColor =[UIColor_ColorChange colorWithHexString:@"f3f3f3"];
    [self.view addSubview:headline];
    
    NSArray<NSString *> *titletext=@[@"个人资料",@"账号设置",@"版本更新",@"清除缓存",@"消息推送",@"退出登陆"];
    
    for (int i=0; i<titletext.count; i++) {
        if (i==5) {
            UIButton *button=[UIButton new];
            button.frame=CGRectMake((kScreen_Width-160)/2, self.topView.frame.size.height+6+46*i+25, 160,40);
            button.backgroundColor=[UIColor_ColorChange colorWithHexString:app_theme];
            [button setTitle: titletext[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor_ColorChange whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:18];
            button.layer.cornerRadius = 18.0;
            [button addTarget:self action:@selector(loginout:) forControlEvents: UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }else{
            UIView *view=[UIView new];
            view.backgroundColor=[UIColor clearColor];
            view.frame=CGRectMake(0, self.topView.frame.size.height+6+46*i, kScreen_Width,46 );
            
            UILabel *lable=[UILabel new];
            [lable setText:titletext[i]];
            lable.frame=CGRectMake(10, 0, 80,45 );
            lable.textAlignment=NSTextAlignmentCenter;
            lable.textColor=[UIColor blackColor];
            lable.font = [UIFont systemFontOfSize:18];
            UIView *line=[UIView new];
            line.backgroundColor=[UIColor_ColorChange colorWithHexString:@"f3f3f3"];
            line.frame=CGRectMake(0, 45, kScreen_Width,1 );
            [view addSubview:lable];
            [view addSubview:line];
            if (i==4) {
                UISwitch *switchview=[UISwitch new];
                switchview.frame=CGRectMake(kScreen_Width-10-50, 7, 50,40 );
                switchview.onTintColor = [UIColor_ColorChange colorWithHexString:app_theme];
                switchview.tintColor = [UIColor grayColor];
                switchview.thumbTintColor = [UIColor grayColor];
                [switchview addTarget:self action:@selector(ispush:)forControlEvents:UIControlEventValueChanged];
                [view addSubview:switchview];
            }else{
                UIImageView *image=[UIImageView new];
                [image setImage:[UIImage imageNamed:@"箭头"]];
                image.frame=CGRectMake(kScreen_Width-10-image.image.size.width, (46-image.image.size.height)/2, image.image.size.width,image.image.size.height );
                [view addSubview:image];
                view.userInteractionEnabled = YES;
                [view setTag:i];
                [view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(to:)]];
            }
            
            if (i==2) {
                NSString *string = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
                UILabel *lable2=[UILabel new];
                [lable2 setText:string];
                lable2.frame=CGRectMake(kScreen_Width-10-50-45, 0, 80,45 );
                lable2.textAlignment=NSTextAlignmentCenter;
                lable2.textColor=[UIColor grayColor];
                lable2.font = [UIFont systemFontOfSize:18];
                 [view addSubview:lable2];
                
                
            }
            
            if (i==3) {
              
                
                
            }
           
            [self.view addSubview:view];
        }
        
        
    }
    
    
//    UIButton *personal =[[UIButton alloc]init];
//    personal.backgroundColor =[UIColor blueColor];
//    [personal setTitle:@"个人资料" forState:UIControlStateNormal];
//    [personal setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
//    personal.frame=CGRectMake(0, statusBar_Height+36, kScreen_Width, 45);
//
//    [personal addTarget:self action:@selector(exit) forControlEvents: UIControlEventTouchUpInside];
    
//    [self.view addSubview:personal];
}












-(void)ispush:(UISwitch *)swi{
    if (swi.isOn) {
       
        
    }else{
      
        
    }
    
}

-(void)loginout:(id)sender{
    NSLog (@"退出");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退出" message:@"您确定退出登陆？" preferredStyle:UIAlertControllerStyleActionSheet];
    // 设置popover指向的item
    alert.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItem;
    
    // 添加按钮
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        //
       
        NSUserDefaults *defaults= DEFAULTS;
        
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
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:loginNotification object:self userInfo:@{@"isLogin":[NSString stringWithFormat:@"%d", false]}];
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                    
                    
                    
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
        
        
        
        
        
        
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击了取消按钮");
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}


-(void)to:(id)sender{
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    NSLog (@"%zd",[tapRecognizer.view tag]);
    switch ([tapRecognizer.view tag]) {
        case 0:
             [self presentViewController:[personalInformationViewController new] animated:YES completion:nil];
            break;
        case 1:
            [self presentViewController:[accountSettingsViewController new] animated:YES completion:nil];
            break;
        default:
            break;
    }
}




@end



