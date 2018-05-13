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

@interface yuboViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(strong,nonatomic)UICollectionView *yuboCollectionV;
@end

@implementation yuboViewController
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
    
    _yuboCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, kScreen_Width,kScreen_Height-30-statusBar_Height-49)collectionViewLayout:flowL];
    _yuboCollectionV.delegate =self;
    _yuboCollectionV.dataSource =self;
    _yuboCollectionV.backgroundColor =[UIColor whiteColor];
    
    _yuboCollectionV.delaysContentTouches = true;
    
    
    
    [_yuboCollectionV registerClass:[TeacheCourseViewCollectionViewCell class] forCellWithReuseIdentifier:@"yubocellid"];
    
    
    _yuboCollectionV.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self initgzyinluCourse];
        
    }];
    
    
    [self.view addSubview:_yuboCollectionV];
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
        
        
        
    }
    
    return Coursecell;
}

-(void)initgzyinluCourse
{
    
    NSUserDefaults *defaults= DEFAULTS;
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    [parameterCountry setObject:[defaults objectForKey:@"teacher_id"] forKey:@"teacher_id"];
    [parameterCountry setObject:[defaults objectForKey:@"memberid"] forKey:@"memberid"];
    
    
    
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
                
                
                if (yuboCourse) {
                    
                    
                    [_yuboCollectionV reloadData];
                    
                }else{
                    NSLog(@"hotCourse.count==nil");
                }
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
        [_yuboCollectionV.mj_header  endRefreshing];
        
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


@end
