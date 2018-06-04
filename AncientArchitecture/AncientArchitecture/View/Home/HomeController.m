//
//  HomeController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/9.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "HomeController.h"
#import "CarouselImgResponse.h"
#import "SDCycleScrollView.h"
#import "MJRefresh.h"
#import "LoginViewController.h"
#import "searchViewController.h"
#import "VTDivideViewController.h"


@interface HomeController ()<SDCycleScrollViewDelegate>

@end

@implementation HomeController

NSMutableArray<NSString *> *CarouselImgdata;
SDCycleScrollView *bannerAd;
UIScrollView * scrollView;
VTDivideViewController *tableview;

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
    self.view.backgroundColor=[UIColor whiteColor];
    UIView *avr = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 44+statusBar_Height)];
    avr.backgroundColor =[UIColor_ColorChange colorWithHexString:app_theme];
    
    UIImageView *back =[[UIImageView alloc]init];
    back.image=[UIImage imageNamed:@"img_theme_bg_top"];
    back.frame = CGRectMake(0, 0, kScreen_Width, 44+statusBar_Height);
    
    UIImageView *title =[[UIImageView alloc]init];
    title.image=[UIImage imageNamed:@"img_logo_title"];
    title.frame = CGRectMake((kScreen_Width-title.image.size.width)/2, 6+(44+statusBar_Height-title.image.size.height)/2, title.image.size.width, title.image.size.height);
    
    
    UIImageView *message =[[UIImageView alloc]init];
    message.image=[UIImage imageNamed:@"icon_home"];
    message.frame = CGRectMake(10, 6+statusBar_Height, message.image.size.width, message.image.size.height);
    message.userInteractionEnabled = YES;
   
    
    UIImageView *edit =[[UIImageView alloc]init];
    edit.image=[UIImage imageNamed:@"icon_search_gray"];
    edit.frame = CGRectMake(kScreen_Width-10-message.image.size.width, 12+statusBar_Height, edit.image.size.width, edit.image.size.height);
    edit.userInteractionEnabled = YES;
    [edit addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(search)]];
    
    [avr addSubview:back];
    [avr addSubview:title];
    [avr addSubview:message];
    [avr addSubview:edit];
    
    [self.view addSubview:avr];
    
    
   
    float height=0;
   
        scrollView = [[UIScrollView alloc]init ];
        scrollView.frame=CGRectMake(0, avr.frame.size.height, kScreen_Width,kScreen_Height-avr.frame.size.height-49);
        
        scrollView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //刷新时候，需要执行的代码。一般是请求最新数据，请求成功之后，刷新列表
            [self initdata];
        }];
        
        
        
    
    
    
    
        bannerAd = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreen_Width, 224) delegate:self placeholderImage:[UIImage imageNamed:@"default"]];
        bannerAd.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        bannerAd.currentPageDotColor = [UIColor whiteColor];
//        bannerAd.imageURLStringsGroup = imagesURLStrings;
        height=height+224;
  
    
    
        tableview =[[VTDivideViewController alloc] init];
    if (IS_IPHONE_X) {
        tableview.view.frame=CGRectMake(0, 224, kScreen_Width,kScreen_Height-avr.frame.size.height-49-44);
    }else{
        tableview.view.frame=CGRectMake(0, 224, kScreen_Width,kScreen_Height-avr.frame.size.height-49);
    }
    

        height=height+tableview.view.frame.size.height;
    
    
    [scrollView addSubview:tableview.view];
    [scrollView addSubview:bannerAd];
    
    scrollView.contentSize=CGSizeMake(kScreen_Width, height);
    [self.view addSubview:scrollView];
   
    [self initdata];
}




-(void)search{
   
    bool islogin = [DEFAULTS objectForKey:@"islogin"];
    
    if (islogin) {
        
        [self.view.window.rootViewController presentViewController:[searchViewController new] animated:YES completion:nil];
    }else{
         [self.view.window.rootViewController presentViewController:[LoginViewController new] animated:YES completion:nil];
    }
}








-(void)initdata
{
    
    [self GeneralButtonAction];
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_getCarouselImg withParams:nil withMethodType:Get autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                NSLog(@"%@",response.data);
                
                if (CarouselImgdata) {
                    [CarouselImgdata removeAllObjects ];
                }else{
                    CarouselImgdata=[NSMutableArray new];
                }
                NSMutableArray<CarouselImgResponse *> *imgdata =[CarouselImgResponse mj_objectArrayWithKeyValuesArray:response.data];
                if (imgdata.count>0) {
                    for (int i=0; i<imgdata.count; i++) {
                        CarouselImgResponse *teamdate = imgdata[i];

                        [CarouselImgdata addObject:teamdate.img_url];
                       
                    }
                     bannerAd.imageURLStringsGroup = CarouselImgdata;
                }
              
                [scrollView.mj_header  endRefreshing];
                
            }else{
                
            }
            
            if (self.HUD) {
                [self.HUD hideAnimated:true];
            }
          
            
        }else{
            if (self.HUD) {
                [self.HUD hideAnimated:true];
            }
            [self TextButtonAction:error.domain];
        }
        
    }];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    

}


@end
