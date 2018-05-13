//
//  HotViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/12.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "HotViewController.h"
#import "HotReusableView.h"
#import "TeacheCourseViewCollectionViewCell.h"
#import "CategoryResponse.h"
#import "CourseResponse.h"
#import "CourseDetailResponse.h"
#import "MJRefresh.h"
#import "playerViewController.h"
#import "CoursefeileiCollectionViewCell.h"
@interface HotViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(strong,nonatomic)UICollectionView *myhotCollectionV;
@end

@implementation HotViewController
NSMutableArray<CourseResponse *> *hotCategory;
NSMutableArray<CourseDetailResponse *> *hotCourse;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTheCollectionView];
    
    [self initHotCourse];
    [self initcategroy];
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


//创建视图

-(void)addTheCollectionView{
    //=======================1===========================
    
    //创建一个块状表格布局对象
    
    UICollectionViewFlowLayout *flowL = [UICollectionViewFlowLayout new];
    
    //格子的大小 (长，高)
    
    flowL.itemSize =CGSizeMake(kScreen_Width,240);
    
    
    //如果有多个区 就可以拉动
    
    [flowL setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    //设置头部并给定大小
    
    [flowL setHeaderReferenceSize:CGSizeMake(kScreen_Width,300)];
    
    

    //创建一个UICollectionView
    
    _myhotCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, kScreen_Width,kScreen_Height-30-statusBar_Height-49-50)collectionViewLayout:flowL];
    
    //设置代理为当前控制器
    
    _myhotCollectionV.delegate =self;
    
    _myhotCollectionV.dataSource =self;
    
   
    //设置背景
    
    _myhotCollectionV.backgroundColor =[UIColor whiteColor];
    
    
    
#pragma mark -- 注册单元格
    
    [_myhotCollectionV registerClass:[TeacheCourseViewCollectionViewCell class] forCellWithReuseIdentifier:@"hotcellid"];
    [_myhotCollectionV registerClass:[CoursefeileiCollectionViewCell class] forCellWithReuseIdentifier:@"categroycellid"];
    
#pragma mark -- 注册头部视图
    
    [_myhotCollectionV registerClass: [HotReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerid"];
    
    
    //添加视图
    _myhotCollectionV.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //刷新时候，需要执行的代码。一般是请求最新数据，请求成功之后，刷新列表
       
        [self initHotCourse];
        [self initcategroy];
    }];
    
    
    [self.view addSubview:_myhotCollectionV];
}

//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return hotCourse.count;
    }else{
        return hotCategory.count;
    }
}

//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell  *cell = nil;
    if (indexPath.section==0) {
        TeacheCourseViewCollectionViewCell  *Coursecell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"hotcellid" forIndexPath:indexPath];

        if (hotCourse) {
            if (hotCourse[indexPath.row].img_url) {
                Coursecell.imageName =hotCourse[indexPath.row].img_url;
            }
            
            
            if (hotCourse[indexPath.row].title) {
                
                Coursecell.titlename  =hotCourse[indexPath.row].title;
                
            }
            
            if (hotCourse[indexPath.row].teacher_name) {
                Coursecell.teachername=hotCourse[indexPath.row].teacher_name;
            }
            
            if (hotCourse[indexPath.row].teacher_photo) {
                Coursecell.headimageName=hotCourse[indexPath.row].teacher_photo;
            }
            
            if (hotCourse[indexPath.row].start_time) {
                Coursecell.timename=hotCourse[indexPath.row].start_time;
            }
            

            cell=Coursecell;
        }
 

        
    }else{
        CoursefeileiCollectionViewCell *categroycell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"categroycellid"forIndexPath:indexPath];
        
        if(hotCategory){
            if(hotCategory[indexPath.row].img_url){
                categroycell.imageName=hotCategory[indexPath.row].img_url;
            }
        }
        
        cell=categroycell;
    }
    
     return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return CGSizeMake(kScreen_Width, 240);
    }else{
        return CGSizeMake(kScreen_Width, 100);
    }
    
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return CGSizeMake(kScreen_Width, 300);
    }else{
        return CGSizeMake(kScreen_Width, 50);
    }
   
}



//设置头尾部内容

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{
    
    UICollectionReusableView *reusableView =nil;
    
    
    
    if (kind ==UICollectionElementKindSectionHeader) {
        
        //定制头部视图的内容
        
        HotReusableView *headerV = (HotReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerid" forIndexPath:indexPath];
                                                       
                                                     
        
        headerV.titleLab.text =@"头部视图";
        
      
        
       
        
        reusableView = headerV;
        
    }
    

    
    return reusableView;
    
}





//设置点击 Cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
    if (indexPath.section==0) {
       
        [self.view.window.rootViewController presentViewController:[playerViewController new] animated:YES completion:nil];
  
    }
//    if (Coursearry.count>indexPath.row) {
//        NSLog(@"id %@",Coursearry[indexPath.row].id);
//
//        NSUserDefaults *defaults= DEFAULTS;
//
//        [defaults removeObjectForKey:@"push_id"];
//        [defaults synchronize];
//        [defaults setObject:Coursearry[indexPath.row].id forKey:@"push_id"];
//
//
//        [self presentViewController:[startLiveViewController new] animated:YES completion:nil];
//    }
}






-(void)initHotCourse
{
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_getHotCourse withParams:nil withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                if (hotCourse) {
                    [hotCourse removeAllObjects ];
                }
                 hotCourse=[CourseDetailResponse mj_objectArrayWithKeyValuesArray:response.data];
              
                
                if (hotCourse) {
                    
                    [_myhotCollectionV reloadData];
                   
                }else{
                    NSLog(@"hotCourse.count==nil");
                }
            }
            
            
        
            [self TextButtonAction:response.msg];
            
        }else{
           
            [self TextButtonAction:error.domain];
        }
        
    }];
}





//获取课程分类
-(void)initcategroy
{
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_getCategory withParams:nil withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                NSLog(@"%@",response.data);
               
                [_myhotCollectionV.mj_header  endRefreshing];
                
                if (hotCategory) {
                    [hotCategory removeAllObjects ];
                }
               hotCategory=[CourseDetailResponse mj_objectArrayWithKeyValuesArray:response.data];
                NSLog(@"CategoryResponse:%lu",hotCategory.count);
                
               
                if (hotCategory) {
                    
                   
                        [_myhotCollectionV reloadData];
                   
                }else{
                    NSLog(@"hotCategory.count==nil");
                }
                
            
                
            }
            
           
            [self TextButtonAction:response.msg];
            
        }else{
            
            [self TextButtonAction:error.domain];
        }
         [_myhotCollectionV.mj_header  endRefreshing];
    }];
}




@end
