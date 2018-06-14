//
//  CateCourseDetaiViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/19.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "CateCourseDetaiViewController.h"
#import "MJRefresh.h"
#import "CourseDetailResponse.h"
#import "TeacheCourseViewCollectionViewCell.h"
#import "playerViewController.h"
#import "LoginViewController.h"
@interface CateCourseDetaiViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(strong,nonatomic)UICollectionView *CateCourseDetaiCollectionV;


@end

@implementation CateCourseDetaiViewController
NSMutableArray<CourseDetailResponse *> *CateCourseDetaiCourse;
int CateCourseDetaii = 1;
bool CateCourseDetairefreshing =false;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    
    [self addTheCollectionView];
   
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
    
    self.CateCourseDetaiCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, kScreen_Width,kScreen_Height-30-statusBar_Height-49-50)collectionViewLayout:flowL];
    
    //设置代理为当前控制器
    
    self.CateCourseDetaiCollectionV.delegate =self;
    
    self.CateCourseDetaiCollectionV.dataSource =self;
    
    
    //设置背景
    
    self.CateCourseDetaiCollectionV.backgroundColor =[UIColor whiteColor];
    
    self.CateCourseDetaiCollectionV.delaysContentTouches = true;
    
#pragma mark -- 注册单元格
    
    [self.CateCourseDetaiCollectionV registerClass:[TeacheCourseViewCollectionViewCell class] forCellWithReuseIdentifier:@"CateCourseDetai"];
    
    
    
    
    
    
    self.CateCourseDetaiCollectionV.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.CateCourseDetaiCollectionV.mj_footer  resetNoMoreData ];
        CateCourseDetairefreshing=true;
        CateCourseDetaii=1;
        [self initjijiangCourse];
        
    }];
    
    
    self.CateCourseDetaiCollectionV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        
        
        [self initjijiangCourse];
        
    }];
    
    [self.view addSubview:self.CateCourseDetaiCollectionV];
}

//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return CateCourseDetaiCourse.count;
    
}




//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    TeacheCourseViewCollectionViewCell  *Coursecell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"CateCourseDetai" forIndexPath:indexPath];
    
    if (CateCourseDetaiCourse.count>0) {
        if (CateCourseDetaiCourse[indexPath.item].img_url) {
            Coursecell.imageName =CateCourseDetaiCourse[indexPath.item].img_url;
        }
        
        
        if (CateCourseDetaiCourse[indexPath.item].title) {
            
            Coursecell.titlename  =CateCourseDetaiCourse[indexPath.item].title;
            
        }
        
        if (CateCourseDetaiCourse[indexPath.item].teacher_name) {
            Coursecell.teachername=CateCourseDetaiCourse[indexPath.item].teacher_name;
        }
        
        if (CateCourseDetaiCourse[indexPath.row].teacher_photo) {
            Coursecell.headimageName=CateCourseDetaiCourse[indexPath.item].teacher_photo;
        }
        
        if (CateCourseDetaiCourse[indexPath.row].start_time) {
            Coursecell.timename=CateCourseDetaiCourse[indexPath.item].start_time;
        }
        
        
        
    }
    
    return Coursecell;
}




-(void)initjijiangCourse
{
    
    
    
    
    NSString *pathWithPhoneNum = [NSString stringWithFormat:@"%@?id=%@&page=%@",url_getCateCourseDetail,self.CateCourseDetaiid,@(CateCourseDetaii)];
    
    [self GeneralButtonAction];
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:pathWithPhoneNum withParams:nil withMethodType:Get autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        [self.CateCourseDetaiCollectionV.mj_header  endRefreshing];
        if (!error) {
            
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                
                if (CateCourseDetairefreshing) {
                    if (CateCourseDetaiCourse) {
                        [CateCourseDetaiCourse removeAllObjects] ;
                    }
                    CateCourseDetairefreshing=false;
                }
                
                
                NSMutableArray<CourseDetailResponse *> *tempCourse=[CourseDetailResponse mj_objectArrayWithKeyValuesArray:response.data];
                
                
                if (tempCourse) {
                    
                    if (tempCourse.count>0) {
                        
                        [CateCourseDetaiCourse addObjectsFromArray: tempCourse];
                        
                        
                    }
                    
                    
                    
                }
                if (response.page>CateCourseDetaii) {
                    CateCourseDetaii++;
                }else{
                    [self.CateCourseDetaiCollectionV.mj_footer  endRefreshingWithNoMoreData];
                }
                
                
                
            }else{
                 [self TextButtonAction:response.msg];
            }
            [self.CateCourseDetaiCollectionV reloadData];
            
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
  
    if (CateCourseDetaiCourse.count>0) {
        if (CateCourseDetaiCourse[indexPath.row]) {
            NSUserDefaults *defaults= DEFAULTS;
            
            [defaults removeObjectForKey:@"play_url"];
            [defaults synchronize];
            [defaults setObject:CateCourseDetaiCourse[indexPath.row].id forKey:@"play_url"];
            [self presentViewController:[playerViewController new] animated:YES completion:nil];
        }
    }else{
        
    }
 
    
   
}




- (void)setSetid:(NSString *)setid{
    NSLog(@"setid%@",setid);
    self.CateCourseDetaiid=setid;
    if (CateCourseDetaiCourse) {
        [CateCourseDetaiCourse removeAllObjects] ;
    }else{
        CateCourseDetaiCourse =[[NSMutableArray alloc] init];
    }
    CateCourseDetaii=1;
    [self initjijiangCourse];
}







@end
