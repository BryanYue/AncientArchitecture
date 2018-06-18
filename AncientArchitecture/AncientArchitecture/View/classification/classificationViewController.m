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
    
    
    if (!_classVTMagicController) {
        _classVTMagicController =[[classVTMagicController alloc] init] ;
        _classVTMagicController.view.frame=CGRectMake(0, 44+statusBar_Height, kScreen_Width,kScreen_Height-44-statusBar_Height);
        
        
    }
   
   
     [self.view addSubview: _classVTMagicController.view];
    
    
    
    
    

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)viewWillDisappear:(BOOL)animated{
 
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
