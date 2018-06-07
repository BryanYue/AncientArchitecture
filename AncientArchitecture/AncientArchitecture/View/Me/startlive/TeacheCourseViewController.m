//
//  TeacheCourseViewController.m
//  AncientArchitecture
//
//  Created by Bryan on 2018/4/2.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "TeacheCourseViewController.h"

#import "TeacheCourseResponse.h"
#import "TeacheCourseViewCollectionViewCell.h"
#import "startLiveViewController.h"

@interface TeacheCourseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate
>


@end

@implementation TeacheCourseViewController
NSMutableArray<TeacheCourseResponse *> *Coursearry;
UICollectionView * collect;
NSString *teacher_name;
NSString *teacher_photo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initview];
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
-(void)initview
{
    [self initbaseView];
    [self addBackButton];
    [self.topTitleLabel setText:@"选择直播课程"];
    
    
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为100*100
    layout.itemSize = CGSizeMake(kScreen_Width, 247);
    //创建collectionView 通过一个布局策略layout来创建
    CGRect fram =CGRectMake(0, self.topView.frame.size.height, kScreen_Width, kScreen_Height-self.topView.frame.size.height);;
    
    collect = [[UICollectionView alloc]initWithFrame:fram collectionViewLayout:layout];
    
    //代理设置
    collect.delegate=self;
    collect.dataSource=self;
    collect.emptyDataSetSource=self;
    collect.emptyDataSetDelegate=self;
    
    [collect registerClass:[TeacheCourseViewCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    collect.backgroundColor =[UIColor whiteColor];
    collect.delaysContentTouches = true;
    
    [self.view addSubview:collect];
    if (Coursearry) {
        [Coursearry removeAllObjects ];
    }
    [self initdata];
    
}



-(void)initdata
{
    
  
    NSUserDefaults *defaults= DEFAULTS;
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    
    
    
    teacher_name=[defaults objectForKey:@"teacher_name"];
    teacher_photo=[defaults objectForKey:@"teacher_photo"];
    NSLog(@"teacher_name%@",teacher_name);
    NSLog(@"teacher_photo%@",teacher_photo);
    if ([defaults objectForKey:@"teacher_id"]) {
        [parameterCountry setObject:[defaults objectForKey:@"teacher_id"] forKey:@"teacher_id"];
         [parameterCountry setObject:[defaults objectForKey:@"memberid"] forKey:@"memberid"];
         [parameterCountry setObject:@"3" forKey:@"type"];
        [self GeneralButtonAction];
        [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_getTeacheCourse withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
            NSLog(@"error%zd",error.code);
            if (!error) {
                BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
                if (response.code  == 200) {
                    NSLog(@"%@",response.data);
                    if (Coursearry) {
                        [Coursearry removeAllObjects ];
                    }
                    Coursearry =[TeacheCourseResponse mj_objectArrayWithKeyValuesArray:response.data];
                    if (Coursearry) {
                        if (Coursearry.count>0) {
                            [collect reloadData];
                        }else{
                            NSLog(@"Coursearry.count==0");
                        }
                    }else{
                        NSLog(@"Coursearry.count==nil");
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
            
        }];
    }
    
    
    
   
}

//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return Coursearry.count;
}
//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TeacheCourseViewCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    
    if (cell==nil) {
        NSLog(@"cell%@",@"cell null");
    }
    
     NSLog(@"indexPath%zd",indexPath.row);
     NSLog(@"indexPath%zd",indexPath.item);
     NSLog(@"Coursearry.count%zd",Coursearry.count);
   
    
        if (Coursearry[indexPath.item].img_url) {
            cell.imageName =Coursearry[indexPath.item].img_url;
        }


        if (Coursearry[indexPath.item].title) {

           cell.titlename  =Coursearry[indexPath.item].title;

        }

        if (teacher_name) {
            cell.teachername=teacher_name;
        }

        if (teacher_photo) {
            cell.headimageName=teacher_photo;
        }

        if (Coursearry[indexPath.item].start_time) {
             cell.timename=Coursearry[indexPath.item].start_time;
        }
    
 
    
    return cell;
}
//设置点击 Cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
    
    if (Coursearry.count>indexPath.row) {
         NSLog(@"id %@",Coursearry[indexPath.row].id);
        
        NSUserDefaults *defaults= DEFAULTS;
        
        [defaults removeObjectForKey:@"push_id"];
        [defaults synchronize];
        [defaults setObject:Coursearry[indexPath.row].id forKey:@"push_id"];
        
        
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
