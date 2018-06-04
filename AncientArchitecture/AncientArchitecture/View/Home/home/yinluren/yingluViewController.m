//
//  yingluViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/12.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "yingluViewController.h"
#import "TeacherResponse.h"
#import "MJRefresh.h"
#import "TeacherUICollectionViewCell.h"
#import "inlurenViewController.h"
@interface yingluViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(strong,nonatomic)UICollectionView *yingluCollectionV;
@end

@implementation yingluViewController
NSMutableArray<TeacherResponse *> *yinluCourse;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    [self addTheCollectionView];
    [self inityinluCourse];
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
    flowL.itemSize =CGSizeMake(kScreen_Width,kScreen_Width/3+30);
    [flowL setScrollDirection:UICollectionViewScrollDirectionVertical];

    _yingluCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, kScreen_Width,kScreen_Height-30-statusBar_Height-49-50)collectionViewLayout:flowL];
    _yingluCollectionV.delegate =self;
    _yingluCollectionV.dataSource =self;
    _yingluCollectionV.backgroundColor =[UIColor whiteColor];
    
    _yingluCollectionV.delaysContentTouches = true;
    
    
    
    [_yingluCollectionV registerClass:[TeacherUICollectionViewCell class] forCellWithReuseIdentifier:@"yinglucellid"];
    
    
    _yingluCollectionV.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self inityinluCourse];
        
    }];
    
    
    [self.view addSubview:_yingluCollectionV];
}





//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return yinluCourse.count;
    
}


//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    TeacherUICollectionViewCell  *Coursecell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"yinglucellid" forIndexPath:indexPath];
    
    if (yinluCourse) {
        if (yinluCourse[indexPath.item].teacher_motto) {
            Coursecell.imageName =yinluCourse[indexPath.item].teacher_motto;
        }
        
        
        if (yinluCourse[indexPath.item].speaker_content) {
            
            Coursecell.titlename  =yinluCourse[indexPath.item].speaker_content;
            
        }
        
        if (yinluCourse[indexPath.item].name) {
            Coursecell.teachername=yinluCourse[indexPath.item].name;
        }
        
        if (yinluCourse[indexPath.row].photo) {
            Coursecell.headimageName=yinluCourse[indexPath.item].photo;
        }
        
        if (yinluCourse[indexPath.row].longevity) {
            Coursecell.timename=yinluCourse[indexPath.item].longevity;
        }
        
        
        
    }
    
    return Coursecell;
}






-(void)inityinluCourse
{
    
   
    
    
    
   
    [self GeneralButtonAction];
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_getAllTeacher withParams:nil withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                if (yinluCourse) {
                    [yinluCourse removeAllObjects ];
                }
                yinluCourse=[TeacherResponse mj_objectArrayWithKeyValuesArray:response.data];
                
                
                if (yinluCourse) {
                    
                    
                    [_yingluCollectionV reloadData];
                    
                }else{
                    NSLog(@"hotCourse.count==nil");
                }
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
        [_yingluCollectionV.mj_header  endRefreshing];
        
    }];
}


//设置点击 Cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
    
    if (yinluCourse.count>indexPath.row) {
        NSLog(@"id %@",yinluCourse[indexPath.row].id);
        
        NSUserDefaults *defaults= DEFAULTS;
        
        [defaults removeObjectForKey:@"attteacher_id"];
        
        [defaults setObject:yinluCourse[indexPath.row].id forKey:@"attteacher_id"];
        [defaults synchronize];
        
        [self.view.window.rootViewController presentViewController:[[inlurenViewController alloc] init] animated:YES completion:nil];
    }
}

@end
