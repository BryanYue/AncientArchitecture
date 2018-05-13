//
//  myCourseViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/4/15.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "myCourseViewController.h"
#import "courseViewController.h"
@interface myCourseViewController ()
@end

@implementation myCourseViewController
courseViewController *courseView;

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
    [self addBackButton];
    [self.topTitleLabel setText:@"我的课程"];
    self.view.backgroundColor =[UIColor whiteColor];
    if (!courseView) {
        courseView =[courseViewController new];
        courseView.view.frame=CGRectMake(0, self.topView.frame.size.height, kScreen_Width,kScreen_Height-self.topView.frame.size.height);
        
       
    }
    
    [self.view addSubview:courseView.view];
   
    
    
    
    
    
    
    
     
    NSLog(@"is_teacher%@",[DEFAULTS objectForKey:@"is_teacher"]);
    

    
    
    
    
    
}

-(void)dealloc{
    if (courseView) {
        courseView=nil;
    }
}

-(void)initdata
{
    
    
}


@end
