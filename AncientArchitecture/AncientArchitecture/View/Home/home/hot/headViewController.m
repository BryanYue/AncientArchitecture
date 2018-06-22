//
//  headViewController.m
//  AncientArchitecture
//
//  Created by Bryan on 2018/5/18.
//  Copyright © 2018年 通感科技. All rights reserved.
//
#import "MRLineLayout.h"
#import "MRCircleLayout.h"
#import "MRGridLayout.h"
#import "headViewController.h"
#import "GLCoverFlowLayout.h"
#import "MJRefresh.h"
#import "TeacherResponse.h"
#import "teacherCollectionViewCell.h"
#import "inlurenViewController.h"
#import "LoginViewController.h"
#import "CourseDetailResponse.h"
#import "CustomCollectionViewCell.h"
#import "playerViewController.h"
@interface headViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation headViewController
NSMutableArray<TeacherResponse *> *guzhuyinluCourse;
NSMutableArray<CourseDetailResponse *> *adtitle;
 SDCycleScrollView *_customCellScrollViewDemo;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self addtextAd];
    [self addTheCollectionView];
    [self addtitle];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addtextAd{
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_playNowVideo withParams:nil withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
              
                adtitle=[NSMutableArray array];
                [adtitle removeAllObjects ];
                adtitle=[CourseDetailResponse mj_objectArrayWithKeyValuesArray:response.data];
                _customCellScrollViewDemo = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreen_Width, 80) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
                _customCellScrollViewDemo.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
                _customCellScrollViewDemo.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
                
                if (adtitle.count>0) {
                 _customCellScrollViewDemo.hidden=false;
                    NSMutableArray<NSString *> *CarouselImgdata =[[NSMutableArray alloc]init];;
                    for (int i=0; i<adtitle.count; i++) {
                        [CarouselImgdata addObject:adtitle[i].img_url];
                        
                    }
                    _customCellScrollViewDemo.imageURLStringsGroup = CarouselImgdata;
                      [self.view addSubview:_customCellScrollViewDemo];
                }else{
                    UIImageView *title =[[UIImageView alloc]init];
                    title.image=[UIImage imageNamed:@"img_hom_hot_precourse"];
                    title.frame = CGRectMake(30,20+ title.image.size.height/2, title.image.size.width, title.image.size.height);
                    [self.view addSubview: title];
                    
                    _customCellScrollViewDemo.hidden=true;
                    UILabel *lablen=[[UILabel alloc]init];
                    [lablen setText:@"暂无预告课程"];
                    lablen.frame=CGRectMake(0,5, kScreen_Width,80 );
                    lablen.textAlignment=NSTextAlignmentCenter;
                    lablen.textColor=[UIColor_ColorChange colorWithHexString:app_theme];
                    
                    lablen.font = [UIFont systemFontOfSize:20];
                    [self.view addSubview:lablen];
                }
                
                
             
                
                
            }
            
           
            
        }else{
           
        }
        
    }];

    
    
    
    
 
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    NSUserDefaults *defaults= DEFAULTS;
    
    [defaults removeObjectForKey:@"play_url"];
    [defaults synchronize];
    [defaults setObject:adtitle[index].id forKey:@"play_url"];
    [self.view.window.rootViewController presentViewController:[playerViewController new] animated:YES completion:nil];
    
}




// 不需要自定义轮播cell的请忽略下面的代理方法

// 如果要实现自定义cell的轮播图，必须先实现customCollectionViewCellClassForCycleScrollView:和setupCustomCell:forIndex:代理方法

- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view
{
    if (view != _customCellScrollViewDemo) {
        return nil;
    }
    return [CustomCollectionViewCell class];
}

- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view
{
    CustomCollectionViewCell *myCell = (CustomCollectionViewCell *)cell;
    myCell.title =adtitle[index].title ;
    myCell.time =adtitle[index].start_time ;
}





















-(void)enterBtnClick{
    
    
    
}


-(void)addtitle{
    if (!self.teacherbtn) {
        self.teacherbtn=[[UIButton alloc] init];
        self.teacherbtn.userInteractionEnabled = YES;
    }
    
    self.teacherbtn.frame = CGRectMake(kScreen_Width/3, 90, kScreen_Width/3, 40);
    [self.teacherbtn setImage:[UIImage imageNamed:@"icon_teacher_black"] forState:UIControlStateNormal];
    [self.teacherbtn setTitle: @"推荐讲师" forState:UIControlStateNormal];
    [self.teacherbtn setTitleColor:[UIColor_ColorChange grayColor] forState:UIControlStateNormal];
    self.teacherbtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.teacherbtn.backgroundColor=[UIColor clearColor];
    self.teacherbtn.imageEdgeInsets = UIEdgeInsetsMake(0,-20,0,0);

    [self.view addSubview:self.teacherbtn];
    
    UIView *line1=[[UIView alloc] init ];
    line1.backgroundColor=[UIColor_ColorChange blackColor];
    line1.frame=CGRectMake(0, 90+self.teacherbtn.frame.size.height/2 , kScreen_Width/3,1 );
    [self.view addSubview:line1];
 
    UIView *line2=[[UIView alloc] init ];
    line2.backgroundColor=[UIColor_ColorChange blackColor];
    line2.frame=CGRectMake(kScreen_Width/3*2, 90+self.teacherbtn.frame.size.height/2 , kScreen_Width/3,1 );
    [self.view addSubview:line2];
    
    
    if (!self.coursebtn) {
        self.coursebtn=[[UIButton alloc] init];
        self.coursebtn.userInteractionEnabled = YES;
    }
    
    self.coursebtn.frame = CGRectMake(kScreen_Width/3, 420, kScreen_Width/3, 40);
    [self.coursebtn setImage:[UIImage imageNamed:@"icon_teacher_black"] forState:UIControlStateNormal];
    [self.coursebtn setTitle: @"热门课程" forState:UIControlStateNormal];
    [self.coursebtn setTitleColor:[UIColor_ColorChange grayColor] forState:UIControlStateNormal];
    self.coursebtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.coursebtn.backgroundColor=[UIColor clearColor];
    self.coursebtn.imageEdgeInsets = UIEdgeInsetsMake(0,-20,0,0);
    
    [self.view addSubview:self.coursebtn];
    
    UIView *line3=[[UIView alloc] init ];
    line3.backgroundColor=[UIColor_ColorChange blackColor];
    line3.frame=CGRectMake(0, 420+self.coursebtn.frame.size.height/2 , kScreen_Width/3,1 );
    [self.view addSubview:line3];
    
    UIView *line4=[[UIView alloc] init ];
    line4.backgroundColor=[UIColor_ColorChange blackColor];
    line4.frame=CGRectMake(kScreen_Width/3*2, 420+self.coursebtn.frame.size.height/2 , kScreen_Width/3,1 );
    [self.view addSubview:line4];
    
    
    
    
}










-(void)addTheCollectionView{
    // 创建自定义布局
    MRLineLayout *layout = [[MRLineLayout alloc] init];
    // 设置UICollectionView中每个Item的size
    layout.itemSize = CGSizeMake(120, 240);
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
  
    self.myhotteacherCollectionV=[[UICollectionView alloc]initWithFrame:CGRectMake(0,80, kScreen_Width,350)collectionViewLayout:layout];
    self.myhotteacherCollectionV.delegate =self;
    self.myhotteacherCollectionV.dataSource =self;
    self.myhotteacherCollectionV.backgroundColor =[UIColor whiteColor];
    self.myhotteacherCollectionV.showsHorizontalScrollIndicator =NO;
    
    self.myhotteacherCollectionV.delaysContentTouches = true;
    
    
    [self.myhotteacherCollectionV registerClass:[teacherCollectionViewCell class] forCellWithReuseIdentifier:@"teacherColl"];
    
    
    self.myhotteacherCollectionV.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self inithotteacher];
        
    }];
    
    
    [self.view addSubview: self.myhotteacherCollectionV];
    [self inithotteacher];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    UICollectionViewLayout *layout; // 布局
//
//    if([self.myhotteacherCollectionV.collectionViewLayout isKindOfClass:[MRLineLayout class]]) {
//
//        layout = [[MRCircleLayout alloc] init];
//
//    }else if([self.myhotteacherCollectionV.collectionViewLayout isKindOfClass:[MRCircleLayout class]]) {
//
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//
//        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
//
//        // 重新设置布局
//        [self.myhotteacherCollectionV setCollectionViewLayout:layout animated:YES];
//
//        return;
//
//    }else if([self.myhotteacherCollectionV.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]){
//
//        MRGridLayout *layout = [[MRGridLayout alloc] init];
//
//        [self.myhotteacherCollectionV setCollectionViewLayout:layout animated:YES];
//
//        return;
//
//    }else {
//
//        MRLineLayout *layout = [[MRLineLayout alloc] init];
//
//        layout.itemSize = CGSizeMake(150, 150);
//
//        // 重新设置布局
//        [self.myhotteacherCollectionV setCollectionViewLayout:layout animated:YES];
//
//        return;
//    }
//
//    // 重新设置布局
//    [self.myhotteacherCollectionV setCollectionViewLayout:layout animated:YES];
//}





//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return guzhuyinluCourse.count;
    
}


//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    teacherCollectionViewCell  *Coursecell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"teacherColl" forIndexPath:indexPath];
    
    if (guzhuyinluCourse.count>0) {
        if (guzhuyinluCourse[indexPath.item].photo) {
            Coursecell.imageName =guzhuyinluCourse[indexPath.item].photo;
        }
        
        
        if (guzhuyinluCourse[indexPath.item].name) {
            
            Coursecell.name  =guzhuyinluCourse[indexPath.item].name;
            
        }
        
        if (guzhuyinluCourse[indexPath.item].follow_num) {
            Coursecell.num=guzhuyinluCourse[indexPath.item].follow_num;
        }
        
       
        
        
        
    }
    
    return Coursecell;
}







-(void)inithotteacher{
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_getHotTeacher withParams:nil withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                if (guzhuyinluCourse) {
                    [guzhuyinluCourse removeAllObjects ];
                }
                guzhuyinluCourse=[TeacherResponse mj_objectArrayWithKeyValuesArray:response.data];
                
                
                if (guzhuyinluCourse) {
                    
                    
                    [self.myhotteacherCollectionV reloadData];
                    
                }else{
                    NSLog(@"hotCourse.count==nil");
                }
            }
            
            
           
           
            
        }else{
           
           
        }
        [self.myhotteacherCollectionV.mj_header  endRefreshing];
        
    }];
}


//设置点击 Cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
    
    if (guzhuyinluCourse.count>0) {
        if (guzhuyinluCourse.count>indexPath.row) {
            
            
            NSLog(@"id %@",guzhuyinluCourse[indexPath.row].id);
            
            NSUserDefaults *defaults= DEFAULTS;
            
            [defaults removeObjectForKey:@"attteacher_id"];
            
            [defaults setObject:guzhuyinluCourse[indexPath.row].id forKey:@"attteacher_id"];
            [defaults synchronize];
            
            [self.view.window.rootViewController presentViewController:[[inlurenViewController alloc] init] animated:YES completion:nil];
            
            
            
            
        }
    }

}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{


    // 坐标系转换获得collectionView上面的位于中心的cell
    CGPoint pointInView = [self.view convertPoint:self.myhotteacherCollectionV.center toView:self.myhotteacherCollectionV];
    // 获取这一点的indexPath
    NSIndexPath *indexPathNow = [self.myhotteacherCollectionV indexPathForItemAtPoint:pointInView];



    teacherCollectionViewCell  *cell= (teacherCollectionViewCell *)[self.myhotteacherCollectionV cellForItemAtIndexPath:indexPathNow];


    [self.myhotteacherCollectionV bringSubviewToFront:cell];



}

@end
