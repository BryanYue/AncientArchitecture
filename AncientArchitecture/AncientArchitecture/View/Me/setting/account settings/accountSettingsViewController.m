//
//  accountSettingsViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/3/30.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "accountSettingsViewController.h"

@interface accountSettingsViewController ()

@end

@implementation accountSettingsViewController

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

-(void)initview
{
    [self initbaseView];
    self.view.backgroundColor=[UIColor whiteColor];
    [self addBackButton];
    [self.topTitleLabel setText:@"账号设置"];
    
    UIView *headline=[UIView new];
    headline.frame=CGRectMake(0,self.topView.frame.size.height,kScreen_Width,6);
    headline.backgroundColor =[UIColor_ColorChange colorWithHexString:@"f3f3f3"];
    [self.view addSubview:headline];
    
     NSArray<NSString *> *titletext=@[@"手机",@"实名认证",@"会员状态"];
    for (int i=0; i<titletext.count; i++) {
        UIView *view=[UIView new];
        view.backgroundColor=[UIColor clearColor];
        view.frame=CGRectMake(0, self.topView.frame.size.height+6+46*i, kScreen_Width,46 );
        
        UILabel *lable=[UILabel new];
        [lable setText:titletext[i]];
        lable.frame=CGRectMake(10, 0, 80,45 );
        lable.textAlignment=NSTextAlignmentCenter;
        lable.textColor=[UIColor blackColor];
        lable.font = [UIFont boldSystemFontOfSize:18];
        UIView *line=[UIView new];
        line.backgroundColor=[UIColor_ColorChange colorWithHexString:@"f3f3f3"];
        line.frame=CGRectMake(0, 45, kScreen_Width,1 );
        [view addSubview:lable];
        [view addSubview:line];
        
        [self.view addSubview:view];
    }
    
}





@end



