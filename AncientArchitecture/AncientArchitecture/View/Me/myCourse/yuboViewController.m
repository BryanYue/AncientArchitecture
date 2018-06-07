//
//  yuboViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/13.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "yuboViewController.h"
#import "CourseDetailResponse.h"
#import "MJRefresh.h"
#import "TeacheCourseViewCollectionViewCell.h"
#import "startLiveViewController.h"

@interface yuboViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate
>

@end

@implementation yuboViewController
UICollectionView *yuboCollectionV;
NSMutableArray<CourseDetailResponse *> *yuboCourse;
NSString *teacher_nameyb;
NSString *teacher_photoyb;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    teacher_nameyb=[DEFAULTS objectForKey:@"teacher_name"];
    teacher_photoyb=[DEFAULTS objectForKey:@"teacher_photo"];
    [self addTheCollectionView];
    [self initgzyinluCourse];
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
    UICollectionViewFlowLayout *flowL = [UICollectionViewFlowLayout new];
    flowL.itemSize =CGSizeMake(kScreen_Width,240);
    [flowL setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    yuboCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, kScreen_Width,kScreen_Height-30-statusBar_Height-49)collectionViewLayout:flowL];
    yuboCollectionV.delegate =self;
    yuboCollectionV.dataSource =self;
    yuboCollectionV.backgroundColor =[UIColor whiteColor];
    
    yuboCollectionV.delaysContentTouches = true;
    
    
    yuboCollectionV.emptyDataSetSource=self;
    yuboCollectionV.emptyDataSetDelegate=self;
    
    [yuboCollectionV registerClass:[TeacheCourseViewCollectionViewCell class] forCellWithReuseIdentifier:@"yubocellid"];
    
    
    yuboCollectionV.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self initgzyinluCourse];
        
    }];
    
    
    [self.view addSubview:yuboCollectionV];
}




//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return yuboCourse.count;
    
}

//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    TeacheCourseViewCollectionViewCell  *Coursecell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"yubocellid" forIndexPath:indexPath];
    
    if (yuboCourse) {
        if (yuboCourse[indexPath.item].img_url) {
            Coursecell.imageName =yuboCourse[indexPath.item].img_url;
        }
        
        
        if (yuboCourse[indexPath.item].title) {
            
            Coursecell.titlename  =yuboCourse[indexPath.item].title;
            
        }
        
        if (teacher_nameyb) {
            Coursecell.teachername=teacher_nameyb;
        }
        
        if (teacher_photoyb) {
            Coursecell.headimageName=teacher_photoyb;
        }
        
        if (yuboCourse[indexPath.row].start_time) {
            Coursecell.timename=yuboCourse[indexPath.item].start_time;
        }
        
        if (yuboCourse[indexPath.row].cate_name) {
            Coursecell.classificationname=yuboCourse[indexPath.row].cate_name;
        }
        
    }
    
    return Coursecell;
}

-(void)initgzyinluCourse
{
    
    NSUserDefaults *defaults= DEFAULTS;
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    [parameterCountry setObject:[defaults objectForKey:@"teacher_id"] forKey:@"teacher_id"];
    [parameterCountry setObject:[defaults objectForKey:@"memberid"] forKey:@"memberid"];
      [parameterCountry setObject:@"2" forKey:@"type"];
    
    
    [self GeneralButtonAction];
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_getTeacheCourse withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                if (yuboCourse) {
                    [yuboCourse removeAllObjects ];
                }
                yuboCourse=[CourseDetailResponse mj_objectArrayWithKeyValuesArray:response.data];
                
                  NSLog(@"yuboCourse%@",yuboCourse);
                if (yuboCourse) {
                    
                    
                    [yuboCollectionV reloadData];
                    
                }else{
                    NSLog(@"hotCourse.count==nil");
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
        [yuboCollectionV.mj_header  endRefreshing];
        
    }];
}


//设置点击 Cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
    
    if (yuboCourse.count>indexPath.row) {
        NSLog(@"id %@",yuboCourse[indexPath.row].id);
        
        NSUserDefaults *defaults= DEFAULTS;
        
        [defaults removeObjectForKey:@"push_id"];
        [defaults synchronize];
        [defaults setObject:yuboCourse[indexPath.row].id forKey:@"push_id"];
        
        
        [self presentViewController:[startLiveViewController new] animated:YES completion:nil];
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
