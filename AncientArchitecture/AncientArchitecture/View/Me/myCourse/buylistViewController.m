//
//  buylistViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/13.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "buylistViewController.h"
#import "CourseDetailResponse.h"
#import "MJRefresh.h"
#import "TeacheCourseViewCollectionViewCell.h"
#import "buylist.h"
@interface buylistViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate
>
@property(strong,nonatomic)UICollectionView *buylistCollectionV;
@end

@implementation buylistViewController
NSMutableArray<buylist *> *buylistCourse;
int i = 1;
bool isrefreshing =false;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (buylistCourse) {
        [buylistCourse removeAllObjects] ;
    }else{
        buylistCourse=[NSMutableArray  array];
    }
    [self addTheCollectionView];
    i=1;
    [self initbuylistCourse];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
    
}




-(void)addTheCollectionView{
    UICollectionViewFlowLayout *flowL = [UICollectionViewFlowLayout new];
    flowL.itemSize =CGSizeMake(kScreen_Width,240);
    [flowL setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _buylistCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, kScreen_Width,kScreen_Height-30-statusBar_Height-49)collectionViewLayout:flowL];
    _buylistCollectionV.delegate =self;
    _buylistCollectionV.dataSource =self;
    _buylistCollectionV.backgroundColor =[UIColor whiteColor];
    
    _buylistCollectionV.delaysContentTouches = true;
    
    
    _buylistCollectionV.emptyDataSetSource=self;
    _buylistCollectionV.emptyDataSetDelegate=self;
    
    [_buylistCollectionV registerClass:[TeacheCourseViewCollectionViewCell class] forCellWithReuseIdentifier:@"buylistcellid"];
    
    
    _buylistCollectionV.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_buylistCollectionV.mj_footer  resetNoMoreData ];
        isrefreshing=true;
        i=1;
        [self initbuylistCourse];
        
    }];
    
    
    _buylistCollectionV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
       
       
        [self initbuylistCourse];
        
    }];
    
    [self.view addSubview:_buylistCollectionV];
}



- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *title = @"这里空空如也";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:18],
                                 NSForegroundColorAttributeName:[UIColor darkGrayColor]
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
    
}




- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"img_noinfo_default"];
}


- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return true;
}




//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return buylistCourse.count;
    
}

//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    TeacheCourseViewCollectionViewCell  *Coursecell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"buylistcellid" forIndexPath:indexPath];
    
    if (buylistCourse) {
        if (buylistCourse[indexPath.item].img_url) {
            Coursecell.imageName =buylistCourse[indexPath.item].img_url;
        }
        
        
        if (buylistCourse[indexPath.item].title) {
            
            Coursecell.titlename  =buylistCourse[indexPath.item].title;
            
        }
        
      
        
        if (buylistCourse[indexPath.item].start_time) {
            Coursecell.timename=buylistCourse[indexPath.item].start_time;
        }
        
      
        
    }
    
    return Coursecell;
}











-(void)initbuylistCourse
{
    
    NSUserDefaults *defaults= DEFAULTS;
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    [parameterCountry setObject:@(i) forKey:@"page"];
    [parameterCountry setObject:[defaults objectForKey:@"memberid"] forKey:@"memberid"];
    
    
    
    [self GeneralButtonAction];
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_buyCourse withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
         [_buylistCollectionV.mj_header  endRefreshing];
        if (!error) {
            
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                
                if (isrefreshing) {
                    if (buylistCourse) {
                        [buylistCourse removeAllObjects] ;
                    }
                    isrefreshing=false;
                }
                
                
                NSMutableArray<buylist *> *tempCourse=[buylist mj_objectArrayWithKeyValuesArray:response.data];
                
             
                if (tempCourse) {
                    
                    if (tempCourse.count>0) {
                        
                        [buylistCourse addObjectsFromArray: tempCourse];
                        NSLog(@"tempCourse%@",tempCourse);
                        NSLog(@"buylistCourse%@",buylistCourse);
                        NSLog(@"tempCourse.count%zd",tempCourse.count);
                        NSLog(@"buylist.Course%zd",buylistCourse.count);
                        [_buylistCollectionV reloadData];
                    }
                   
                    
                    
                }
                if (response.page>i) {
                     i++;
                }else{
                         [_buylistCollectionV.mj_footer  endRefreshingWithNoMoreData];
                    
                    
                }
                
                
                
            }else{
                  [self TextButtonAction:response.msg];
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



//设置点击 Cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
    
   
}







@end
