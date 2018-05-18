//
//  classificationViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/19.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "classificationViewController.h"
#import "classVTMagicController.h"

@interface classificationViewController ()

@end

@implementation classificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initbaseView];
    [self addBackButton];
    
    NSString *title =[DEFAULTS objectForKey:@"classification_title"];
    
    
    
    
    [self.topTitleLabel setText:title];
    self.view.backgroundColor =[UIColor whiteColor];
    
    
    if (!self.classVTMagicController) {
        self.classVTMagicController =[[classVTMagicController alloc] init] ;
        self.classVTMagicController.view.frame=CGRectMake(0, self.topView.frame.size.height, kScreen_Width,kScreen_Height-self.topView.frame.size.height);
        
        
    }
   
    [self.view addSubview: self.classVTMagicController.view];
    
    
    
    
    
    

    

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
