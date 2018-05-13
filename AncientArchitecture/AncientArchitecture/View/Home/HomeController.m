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
    [self initbaseView];
    [self.topTitleLabel setText:@"非物质"];
    float height=0;
    if (!scrollView) {
        scrollView = [UIScrollView new];
        scrollView.frame=CGRectMake(0, self.topView.frame.size.height, kScreen_Width,kScreen_Height-self.topView.frame.size.height);
        
        scrollView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //刷新时候，需要执行的代码。一般是请求最新数据，请求成功之后，刷新列表
            [self initdata];
        }];
        
        
        
    }
    
    
    if (!bannerAd) {
        bannerAd = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreen_Width, 224) delegate:self placeholderImage:[UIImage imageNamed:@"default"]];
        bannerAd.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        bannerAd.currentPageDotColor = [UIColor whiteColor];
//        bannerAd.imageURLStringsGroup = imagesURLStrings;
        height=height+224;
    }
    
    if (!tableview) {
        tableview =[VTDivideViewController new];
        tableview.view.frame=CGRectMake(0, 224, kScreen_Width,kScreen_Height-self.topView.frame.size.height-49);

        height=height+tableview.view.frame.size.height;
    }
    
    [scrollView addSubview:tableview.view];
    [scrollView addSubview:bannerAd];
    
    scrollView.contentSize=CGSizeMake(kScreen_Width, height);
    [self.view addSubview:scrollView];
   
    [self initdata];
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
            [self TextButtonAction:response.msg];
            
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
