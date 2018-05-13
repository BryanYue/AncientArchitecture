//
//  HomeViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/3/11.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "HomeViewController.h"
#import "MeViewController.h"
#import "VTattenViewController.h"
#import "HomeController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HomeController *v1=[HomeController new];
    v1.view.frame=CGRectMake(0, 0, kScreen_Width, kScreen_Height-49-39-statusBar_Height);
    v1.tabBarItem.image = [UIImage imageNamed:@"首页"];
    v1.tabBarItem.title = @"首页";
    
    
    VTattenViewController *v2 = [VTattenViewController new];
    v2.view.frame=CGRectMake(0, 0, kScreen_Width, kScreen_Height-49-39-statusBar_Height);
    v2.tabBarItem.image = [UIImage imageNamed:@"关注"];
    v2.tabBarItem.title = @"关注";
    
    
    MeViewController *me = [MeViewController new];
    me.view.frame=CGRectMake(0, 0, kScreen_Width, kScreen_Height-49);
    me.tabBarItem.image = [UIImage imageNamed:@"我的"];
    me.tabBarItem.title = @"我的";

    
   
   
//    UINavigationController *n1 = [[UINavigationController alloc] initWithRootViewController:v1];


//    UINavigationController *n2 = [[UINavigationController alloc] initWithRootViewController:v2];


//    UINavigationController *n3 = [[UINavigationController alloc] initWithRootViewController:v3];
    
    
    self.viewControllers = @[v1,v2,me];
    self.tabBarController.tabBar.frame =CGRectMake(0, kScreen_Height-49-49, kScreen_Width, 49);
   

    
    
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

@end
