//
//  attteacherViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/13.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "attteacherViewController.h"
#import "TeacherResponse.h"
#import "MJRefresh.h"
#import "TeacherUICollectionViewCell.h"
@interface attteacherViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(strong,nonatomic)UICollectionView *gzyingluCollectionV;
@end

@implementation attteacherViewController
NSMutableArray<TeacherResponse *> *gzyinluCourse;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    flowL.itemSize =CGSizeMake(kScreen_Width,kScreen_Width/3+30);
    [flowL setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _gzyingluCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, kScreen_Width,kScreen_Height-30-statusBar_Height-49)collectionViewLayout:flowL];
    _gzyingluCollectionV.delegate =self;
    _gzyingluCollectionV.dataSource =self;
    _gzyingluCollectionV.backgroundColor =[UIColor whiteColor];
    
    _gzyingluCollectionV.delaysContentTouches = true;
    
    
    
    [_gzyingluCollectionV registerClass:[TeacherUICollectionViewCell class] forCellWithReuseIdentifier:@"gzyinglucellid"];
    
    
    _gzyingluCollectionV.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self initgzyinluCourse];
        
    }];
    
    
    [self.view addSubview:_gzyingluCollectionV];
}


//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return gzyinluCourse.count;
    
}



//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    TeacherUICollectionViewCell  *Coursecell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"gzyinglucellid" forIndexPath:indexPath];
    
    if (gzyinluCourse) {
        if (gzyinluCourse[indexPath.item].teacher_motto) {
            Coursecell.imageName =gzyinluCourse[indexPath.item].teacher_motto;
        }
        
        
        if (gzyinluCourse[indexPath.item].speaker_content) {
            
            Coursecell.titlename  =gzyinluCourse[indexPath.item].speaker_content;
            
        }
        
        if (gzyinluCourse[indexPath.item].name) {
            Coursecell.teachername=gzyinluCourse[indexPath.item].name;
        }
        
        if (gzyinluCourse[indexPath.row].photo) {
            Coursecell.headimageName=gzyinluCourse[indexPath.item].photo;
        }
        
        if (gzyinluCourse[indexPath.row].longevity) {
            Coursecell.timename=gzyinluCourse[indexPath.item].longevity;
        }
        
        
        
    }
    
    return Coursecell;
}



-(void)initgzyinluCourse
{
    
    NSUserDefaults *defaults= DEFAULTS;
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    [parameterCountry setObject:[defaults objectForKey:@"memberid"] forKey:@"memberid"];
    
    
    
    [self GeneralButtonAction];
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_getFollowTeacher withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                if (gzyinluCourse) {
                    [gzyinluCourse removeAllObjects ];
                }
                gzyinluCourse=[TeacherResponse mj_objectArrayWithKeyValuesArray:response.data];
                
                
                if (gzyinluCourse) {
                    
                    
                    [_gzyingluCollectionV reloadData];
                    
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
        [_gzyingluCollectionV.mj_header  endRefreshing];
        
    }];
}


@end