//
//  BaseViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/3/18.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
  
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
        
     
        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)initbaseView{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //自定义标题栏
    self.topView=[[UIView alloc] init];
    self.topView.frame=CGRectMake(0, 0, kScreen_Width, 44+statusBar_Height);
    self.topView.backgroundColor=[UIColor_ColorChange colorWithHexString:app_theme ];
    
    self.topTitleLabel=[[UILabel alloc] init];
    self.topTitleLabel.frame=CGRectMake(50, statusBar_Height, kScreen_Width-100, 44);
    self.topTitleLabel.backgroundColor=[UIColor clearColor];
    self.topTitleLabel.textAlignment=NSTextAlignmentCenter;
    self.topTitleLabel.textColor=[UIColor whiteColor];
    self.topTitleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.topView addSubview:self.topTitleLabel];
    [self.view addSubview:self.topView];
}
-(void)addBackButton{
    UIImageView *backImageView = [[UIImageView alloc] init];
    backImageView.image = [UIImage imageNamed:@"nav_icon_back"];
    backImageView.frame = CGRectMake(10, statusBar_Height+18-backImageView.image.size.height/2, backImageView.image.size.width, backImageView.image.size.height);
    [self.topView addSubview:backImageView];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setFrame:CGRectMake(0, statusBar_Height, 80, 44)];
    [_backButton addTarget:self action:@selector(backButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:_backButton];
}


-(void)addRightbuttonWithTitle:(NSString *)image{
    UIImageView *rightImageView = [[UIImageView alloc] init];
    rightImageView.image = [UIImage imageNamed:image];
    rightImageView.frame  = CGRectMake(kScreen_Width-10-rightImageView.image.size.width, statusBar_Height+18-rightImageView.image.size.height/2, rightImageView.image.size.width, rightImageView.image.size.height);
    [self.topView addSubview:rightImageView];
    
    _rightChangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightChangeBtn setFrame:CGRectMake(kScreen_Width-20-rightImageView.image.size.width, statusBar_Height, 80, rightImageView.image.size.height)];
    [_rightChangeBtn addTarget:self action:@selector(rightButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:_rightChangeBtn];

}


-(void)backButtonPress{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)rightButtonPress{
    
}

//   通常情况  文字  加 菊花
- (void)GeneralButtonAction{
    //初始化进度框，置于当前的View当中
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    //如果设置此属性则当前的view置于后台
    _HUD.dimBackground = YES;
    //设置对话框文字
    _HUD.labelText = @"加载中";
    //细节文字
    _HUD.detailsLabelText = @"请耐心等待";
    [_HUD showAnimated:true];
}
// 只显示文字
- (void)TextButtonAction:(NSString *)string{

    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.labelText = string;
    _HUD.mode = MBProgressHUDModeText;
    
    [_HUD showAnimated:YES whileExecutingBlock:^{
        sleep(1.5);
        
    }
       completionBlock:^{
           [_HUD removeFromSuperview];
           _HUD = nil;
       }];
    
}





-(void)viewDidDisappear:(BOOL)animated{
    [_HUD removeFromSuperview];
    _HUD = nil;
}

-(void)showAction:(NSString *)string{
    UIAlertController * alertCon = [UIAlertController alertControllerWithTitle:@"温馨提示" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertCon addAction:action];
    [self presentViewController:alertCon animated:YES completion:nil];
}

-(void)showUITextFieldAction:(NSString *)string{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取第1个输入框；
        UITextField *userNameTextField = alertController.textFields.firstObject;
        NSLog(@"%@",userNameTextField.text);
        
        if (userNameTextField) {
            [userNameTextField resignFirstResponder];
        }
        
        [self Alertdo:userNameTextField.text];
    }]];
    
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    //定义第一个输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = string;
    }];
    
    
    [self presentViewController:alertController animated:true completion:nil];
}

- (void) dimissAlert:(NSTimer *)timer {
    UIAlertController *alert = [timer userInfo];
    [alert dismissViewControllerAnimated:YES completion:nil];
    alert = nil;
    [self exit];
}

-(void)exit{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)Alertdo:(NSString *)string{
   
}
@end
