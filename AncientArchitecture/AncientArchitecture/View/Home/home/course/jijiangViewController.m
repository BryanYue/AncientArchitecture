//
//  jijiangViewController.m
//  AncientArchitecture
//
//  Created by Bryan on 2018/5/18.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "jijiangViewController.h"
#import "MJRefresh.h"
#import "CourseDetailResponse.h"
#import "TeacheCourseViewCollectionViewCell.h"
#import "playerViewController.h"
#import "LoginViewController.h"
@interface jijiangViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property(strong,nonatomic)UICollectionView *jijianglistCollectionV;
@end

@implementation jijiangViewController
NSMutableArray<CourseDetailResponse *> *jijianglistCourse;
int jji = 1;
bool isjjrefreshing =false;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (jijianglistCourse) {
        [jijianglistCourse removeAllObjects] ;
    }else{
        jijianglistCourse =[NSMutableArray array];
    }
    
    [self addTheCollectionView];
    [self initjijiangCourse];
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


-(void)addTheCollectionView{
    //=======================1===========================
    
    //创建一个块状表格布局对象
    
    UICollectionViewFlowLayout *flowL = [UICollectionViewFlowLayout new];
    
    //格子的大小 (长，高)
    
    flowL.itemSize =CGSizeMake(kScreen_Width,240);
    
    //如果有多个区 就可以拉动
    
    [flowL setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    
    
    
    
    //创建一个UICollectionView
    
    _jijianglistCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, kScreen_Width,kScreen_Height-30-statusBar_Height-49-50)collectionViewLayout:flowL];
    
    //设置代理为当前控制器
    
    _jijianglistCollectionV.delegate =self;
    
    _jijianglistCollectionV.dataSource =self;
    
    _jijianglistCollectionV.emptyDataSetSource=self;
    _jijianglistCollectionV.emptyDataSetDelegate=self;
    //设置背景
    
    _jijianglistCollectionV.backgroundColor =[UIColor whiteColor];
    
    _jijianglistCollectionV.delaysContentTouches = true;
    
#pragma mark -- 注册单元格
    
    [_jijianglistCollectionV registerClass:[TeacheCourseViewCollectionViewCell class] forCellWithReuseIdentifier:@"jijiangcellid"];
    
    
    

    
    
    _jijianglistCollectionV.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_jijianglistCollectionV.mj_footer  resetNoMoreData ];
        isjjrefreshing=true;
        jji=1;
        [self initjijiangCourse];
        
    }];
    
    
    _jijianglistCollectionV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        
        
        [self initjijiangCourse];
        
    }];
    
    [self.view addSubview:_jijianglistCollectionV];
}

//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return jijianglistCourse.count;
    
}




//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    TeacheCourseViewCollectionViewCell  *Coursecell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"jijiangcellid" forIndexPath:indexPath];
    
    if (jijianglistCourse.count>0) {
        if (jijianglistCourse[indexPath.item].img_url) {
            Coursecell.imageName =jijianglistCourse[indexPath.item].img_url;
        }
        
        
        if (jijianglistCourse[indexPath.item].title) {
            
            Coursecell.titlename  =jijianglistCourse[indexPath.item].title;
            
        }
        
        if (jijianglistCourse[indexPath.item].teacher_name) {
            Coursecell.teachername=jijianglistCourse[indexPath.item].teacher_name;
        }
        
        if (jijianglistCourse[indexPath.row].teacher_photo) {
            Coursecell.headimageName=jijianglistCourse[indexPath.item].teacher_photo;
        }
        
        if (jijianglistCourse[indexPath.row].start_time) {
            Coursecell.timename=jijianglistCourse[indexPath.item].start_time;
        }
        
        
        
    }
    
    return Coursecell;
}




-(void)initjijiangCourse
{
    
    

    
     NSString *pathWithPhoneNum = [NSString stringWithFormat:@"%@?type=%@&page=%@",url_allCourse,@"2",@(jji)];
    
    [self GeneralButtonAction];
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:pathWithPhoneNum withParams:nil withMethodType:Get autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        [_jijianglistCollectionV.mj_header  endRefreshing];
        if (!error) {
            
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                
                if (isjjrefreshing) {
                    if (jijianglistCourse) {
                        [jijianglistCourse removeAllObjects] ;
                    }
                    isjjrefreshing=false;
                }
                
                
                NSMutableArray<CourseDetailResponse *> *tempCourse=[CourseDetailResponse mj_objectArrayWithKeyValuesArray:response.data];
                
                
                if (tempCourse) {
                    
                    if (tempCourse.count>0) {
                        
                        [jijianglistCourse addObjectsFromArray: tempCourse];
                    
                       
                    }
                    
                    
                    
                }
                if (response.page>jji) {
                    jji++;
                }else{
                   
                [_jijianglistCollectionV.mj_footer  endRefreshingWithNoMoreData];
                    
                    
                }
                
                if (jijianglistCourse.count==0) {
                    [_jijianglistCollectionV.mj_footer  removeFromSuperview ];
                }
                
                
                
            }
             [_jijianglistCollectionV reloadData];
            
            if (self.HUD) {
                [self.HUD hideAnimated:true];
            }
           
            
        }else{
            if (self.HUD) {
                [self.HUD hideAnimated:true];
            }
            [self TextButtonAction:error.domain];
             [_jijianglistCollectionV.mj_footer  removeFromSuperview ];
        }
        
        
        
    }];
}



//设置点击 Cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
   
        if (jijianglistCourse.count>0) {
            NSUserDefaults *defaults= DEFAULTS;
            
            [defaults removeObjectForKey:@"play_url"];
            [defaults synchronize];
            [defaults setObject:jijianglistCourse[indexPath.row].id forKey:@"play_url"];
            
            
            [self.view.window.rootViewController presentViewController:[playerViewController new] animated:YES completion:nil];
        }

    
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
@end
