//
//  H5PayViewController.m
//  AncientArchitecture
//
//  Created by 岳敏俊 on 2019/1/22.
//  Copyright © 2019 通感科技. All rights reserved.
//

#import "H5PayViewController.h"

@interface H5PayViewController ()

@end

@implementation H5PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initbaseView];
    [self addBackButton];
    
    UIWebView *webview=[[UIWebView alloc] initWithFrame:CGRectMake(0, 49, kScreen_Width, kScreen_Height-44-statusBar_Height)];
    
    
    NSString *urlStr = self.url;
    NSURL *url = [NSURL URLWithString:urlStr];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [self.view addSubview: webview];
    [webview loadRequest:request];
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
