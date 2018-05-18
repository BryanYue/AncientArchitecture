//
//  yiboViewController.m
//  AncientArchitecture
//
//  Created by Bryan on 2018/5/18.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "yiboViewController.h"
#import "MJRefresh.h"
#import "CourseDetailResponse.h"
#import "TeacheCourseViewCollectionViewCell.h"
@interface yiboViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(strong,nonatomic)UICollectionView *yibolistCollectionV;
@end

@implementation yiboViewController

NSMutableArray<CourseDetailResponse *> *yibolistCourse;
int ybi = 1;
bool isybrefreshing =false;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (yibolistCourse) {
         [yibolistCourse removeAllObjects] ;
    }else{
        yibolistCourse =[NSMutableArray array];
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
    
    _yibolistCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, kScreen_Width,kScreen_Height-30-statusBar_Height-49-50)collectionViewLayout:flowL];
    
    //设置代理为当前控制器
    
    _yibolistCollectionV.delegate =self;
    
    _yibolistCollectionV.dataSource =self;
    
    
    //设置背景
    
    _yibolistCollectionV.backgroundColor =[UIColor whiteColor];
    
    _yibolistCollectionV.delaysContentTouches = true;
    
#pragma mark -- 注册单元格
    
    [_yibolistCollectionV registerClass:[TeacheCourseViewCollectionViewCell class] forCellWithReuseIdentifier:@"yibocellid"];
    
    
    
    
    
    
    _yibolistCollectionV.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_yibolistCollectionV.mj_footer  resetNoMoreData ];
        isybrefreshing=true;
        ybi=1;
        [self initjijiangCourse];
        
    }];
    
    
    _yibolistCollectionV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        

        [self initjijiangCourse];
        
    }];
    
    [self.view addSubview:_yibolistCollectionV];
}

//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return yibolistCourse.count;
    
}




//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    TeacheCourseViewCollectionViewCell  *Coursecell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"yibocellid" forIndexPath:indexPath];
    
    if (yibolistCourse) {
        if (yibolistCourse[indexPath.item].img_url) {
            Coursecell.imageName =yibolistCourse[indexPath.item].img_url;
        }
        
        
        if (yibolistCourse[indexPath.item].title) {
            
            Coursecell.titlename  =yibolistCourse[indexPath.item].title;
            
        }
        
        if (yibolistCourse[indexPath.item].teacher_name) {
            Coursecell.teachername=yibolistCourse[indexPath.item].teacher_name;
        }
        
        if (yibolistCourse[indexPath.row].teacher_photo) {
            Coursecell.headimageName=yibolistCourse[indexPath.item].teacher_photo;
        }
        
        if (yibolistCourse[indexPath.row].start_time) {
            Coursecell.timename=yibolistCourse[indexPath.item].start_time;
        }
        
        
        
    }
    
    return Coursecell;
}




-(void)initjijiangCourse
{
    
   
  
    
    NSString *pathWithPhoneNum = [NSString stringWithFormat:@"%@?type=%@&page=%@",url_allCourse,@"3",@(ybi)];
    
    [self GeneralButtonAction];
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:pathWithPhoneNum withParams:nil withMethodType:Get autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        [_yibolistCollectionV.mj_header  endRefreshing];
        if (!error) {
            
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                
                if (isybrefreshing) {
                    if (yibolistCourse) {
                        [yibolistCourse removeAllObjects] ;
                    }
                    isybrefreshing=false;
                }
                
                
                NSMutableArray<CourseDetailResponse *> *tempCourse=[CourseDetailResponse mj_objectArrayWithKeyValuesArray:response.data];
                

                if (tempCourse) {
                    
                        [yibolistCourse addObjectsFromArray: tempCourse];
                    
                    }
                    
                    
                    
                
                if (response.page_num>isybrefreshing) {
                    ybi++;
                }else{
                    [_yibolistCollectionV.mj_footer  endRefreshingWithNoMoreData];
                }
                
                
               [_yibolistCollectionV reloadData];
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



//设置点击 Cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
    
    
}
@end
