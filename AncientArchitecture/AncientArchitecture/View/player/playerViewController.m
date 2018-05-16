//
//  playerViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/13.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "playerViewController.h"
#import "CourseDetailResponse.h"

#import <PLPlayerKit/PLPlayerKit.h>


@interface playerViewController ()



@end

@implementation playerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self initview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated{
   
}


-(void)initview{
    

    [self initbaseView];
    [self addBackButton];
    
    
    
    
    
    //网络视频，填写网络url地址
    NSURL *url = [NSURL URLWithString:@"http://player.alicdn.com/video/aliyunmedia.mp4"];
    //prepareToPlay:此方法传入的参数是NSURL类型.
   
   
    
    
  
}


-(void)initdata{
    
    NSUserDefaults *defaults= DEFAULTS;
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    [parameterCountry setObject:[defaults objectForKey:@"play_url"] forKey:@"course_id"];
    
    [parameterCountry setObject:[defaults objectForKey:@"memberid"] forKey:@"memberid"];
    [self GeneralButtonAction];
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_getCourseDetail withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                
                CourseDetailResponse *detailResponse =[CourseDetailResponse mj_objectWithKeyValues:response.data];
              
                
                
            }else{
                
            }
            
            if (self.HUD) {
                [self.HUD hideAnimated:true];
            }
            [self TextButtonAction:response.msg];
            
        }else{
            
        }
        
    
          [self showAction:@"该课程失效，无法直播"];
  
    }];


    
}











@end
