//
//  attaourseViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/13.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "attaourseViewController.h"
#import "CourseDetailResponse.h"
#import "MJRefresh.h"
#import "TeacheCourseViewCollectionViewCell.h"
#import "LoginViewController.h"
#import "playerViewController.h"
@interface attaourseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate
>
@property(strong,nonatomic)UICollectionView *guanzhuCollectionV;
@end

@implementation attaourseViewController
NSMutableArray<CourseDetailResponse *> *guanzhuCourse;
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
    flowL.itemSize =CGSizeMake(kScreen_Width,240);
    [flowL setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _guanzhuCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, kScreen_Width,kScreen_Height-30-statusBar_Height-49)collectionViewLayout:flowL];
    _guanzhuCollectionV.delegate =self;
    _guanzhuCollectionV.dataSource =self;
    _guanzhuCollectionV.backgroundColor =[UIColor whiteColor];
    
    _guanzhuCollectionV.delaysContentTouches = true;
    
    _guanzhuCollectionV.emptyDataSetSource=self;
    _guanzhuCollectionV.emptyDataSetDelegate=self;
    
    
    [_guanzhuCollectionV registerClass:[TeacheCourseViewCollectionViewCell class] forCellWithReuseIdentifier:@"guanzhucellid"];
    
    
    _guanzhuCollectionV.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if([DEFAULTS objectForKey:@"islogin"]){
            [self initgzyinluCourse];
        }else{
            [_guanzhuCollectionV.mj_header  endRefreshing];
            [self presentViewController:[LoginViewController new] animated:YES completion:nil];
        }
       
        
    }];
    
    
    [self.view addSubview:_guanzhuCollectionV];
}

//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return guanzhuCourse.count;
    
}

//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    TeacheCourseViewCollectionViewCell  *Coursecell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"guanzhucellid" forIndexPath:indexPath];
    
    if (guanzhuCourse.count>0) {
        if (guanzhuCourse[indexPath.item].img_url) {
            Coursecell.imageName =guanzhuCourse[indexPath.item].img_url;
        }
        
        
        if (guanzhuCourse[indexPath.item].title) {
            
            Coursecell.titlename  =guanzhuCourse[indexPath.item].title;
            
        }
        
        if (guanzhuCourse[indexPath.item].teacher_name) {
            Coursecell.teachername=guanzhuCourse[indexPath.item].teacher_name;
        }
        
        if (guanzhuCourse[indexPath.row].teacher_photo) {
            Coursecell.headimageName=guanzhuCourse[indexPath.item].teacher_photo;
        }
        
        if (guanzhuCourse[indexPath.row].start_time) {
            Coursecell.timename=guanzhuCourse[indexPath.item].start_time;
        }
        
        
        
    }
    
    return Coursecell;
}





//设置点击 Cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
   
    if (guanzhuCourse.count>0) {
        if([DEFAULTS objectForKey:@"islogin"]){
            NSUserDefaults *defaults= DEFAULTS;
            
            [defaults removeObjectForKey:@"play_url"];
            [defaults synchronize];
            [defaults setObject:guanzhuCourse[indexPath.row].id forKey:@"play_url"];
            
            
            [self.view.window.rootViewController presentViewController:[playerViewController new] animated:YES completion:nil];
        }else{
            
            [self.view.window.rootViewController presentViewController:[LoginViewController new] animated:YES completion:nil];
        }
        
    }
   

    
    
}



-(void)viewDidAppear:(BOOL)animated{
    [self initgzyinluCourse];
}



-(void)initgzyinluCourse
{
   
    if([DEFAULTS objectForKey:@"islogin"]){
        NSUserDefaults *defaults= DEFAULTS;
        NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
   
        if ([DEFAULTS objectForKey:@"memberid"]) {
            [parameterCountry setObject:[DEFAULTS objectForKey:@"memberid"] forKey:@"memberid"];
        }
        
        
        [self GeneralButtonAction];
        [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_getFollowCourse withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
            NSLog(@"error%zd",error.code);
            if (!error) {
                BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
                if (response.code  == 200) {
                    if (guanzhuCourse) {
                        [guanzhuCourse removeAllObjects ];
                    }
                    guanzhuCourse=[CourseDetailResponse mj_objectArrayWithKeyValuesArray:response.data];
                    
                    
                    if (guanzhuCourse) {
                        
                        
                        [_guanzhuCollectionV reloadData];
                        
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
            [_guanzhuCollectionV.mj_header  endRefreshing];
            
        }];
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
