//
//  uploadCourseViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/3/24.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "uploadCourseViewController.h"

@interface uploadCourseViewController ()

@end

@implementation uploadCourseViewController

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
    self.view.backgroundColor=[UIColor whiteColor];
    [self addBackButton];
    [self.topTitleLabel setText:@"上传课程"];
    
    NSArray<NSString *> *titletext=@[@"新开课程",@"续传课程"];
    for (int i=0; i<titletext.count; i++) {
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
            UIImageView *image=[UIImageView new];
            [image setImage:[UIImage imageNamed:@"箭头"]];
            image.frame=CGRectMake(kScreen_Width-10-image.image.size.width, (46-image.image.size.height)/2, image.image.size.width,image.image.size.height );
            [view addSubview:image];
            view.userInteractionEnabled = YES;
           [view setTag:i];
           [view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(to:)]];
        
        
           [self.view addSubview:view];
        }
        
}




-(void)to:(id)sender{
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    NSLog (@"%zd",[tapRecognizer.view tag]);
}


@end
