//
//  searchViewController.m
//  AncientArchitecture
//
//  Created by Bryan on 2018/5/16.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "searchViewController.h"
#import "MyUITextField.h"
#import "CourseDetailResponse.h"
#import "TeacheCourseViewCollectionViewCell.h"
#import "MJRefresh.h"
#import "playerViewController.h"

@interface searchViewController ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate
>

@end

@implementation searchViewController
MyUITextField * searchText;
UICollectionView *CollectionV;
NSMutableArray<CourseDetailResponse *>  *searchhCourse;

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

-(void)initview{
     [self initbaseView];
    
    [self addBackButton];
    self.view.backgroundColor =[UIColor whiteColor];
    
    
    searchText=[[MyUITextField alloc] init];
    
    NSAttributedString *attrpasswd = [[NSAttributedString alloc] initWithString:@"请输入课程关键字" attributes:
                                      @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                        NSFontAttributeName:searchText.font
                                        }];
    searchText.attributedPlaceholder = attrpasswd;
    searchText.textColor=[UIColor blackColor];
    UIImageView *imagepasswd=[[UIImageView alloc]init];
    imagepasswd.image =[UIImage imageNamed:@"icon_search_gray"];
    imagepasswd.frame=CGRectMake(0, 0, imagepasswd.image.size.width, imagepasswd.image.size.height);
    searchText.leftView=imagepasswd;
    searchText.leftViewMode=UITextFieldViewModeAlways;
    searchText.frame=CGRectMake(60, statusBar_Height, kScreen_Width-100, 44);
    searchText.returnKeyType = UIReturnKeySearch;//变为搜索按钮
    searchText.delegate =self;
    
   
    UIView *ui =[[UIView alloc]init];
    ui.frame=CGRectMake(50, statusBar_Height+2, kScreen_Width-80, 36);
    ui.backgroundColor =[UIColor_ColorChange whiteColor];
    ui.layer.masksToBounds=YES;
    ui.layer.cornerRadius = 20;
    
    [self.view addSubview:ui];
    [self.view addSubview:searchText];
    [self addTheCollectionView];
    
    if (searchhCourse) {
        [searchhCourse removeAllObjects ];
    }else{
        searchhCourse= [NSMutableArray array];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (searchText.text != nil && searchText.text.length > 0) {
        [searchhCourse removeAllObjects ];
        [self initgzyinluCourse];
    }
    [CollectionV reloadData];
     [searchText resignFirstResponder];//取消第一响应者
    return YES;
}





-(void)addTheCollectionView{
    UICollectionViewFlowLayout *flowL = [UICollectionViewFlowLayout new];
    flowL.itemSize =CGSizeMake(kScreen_Width,240);
    [flowL setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    CollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0,statusBar_Height+searchText.frame.size.height, kScreen_Width,kScreen_Height-statusBar_Height-searchText.frame.size.height)collectionViewLayout:flowL];
    CollectionV.delegate =self;
    CollectionV.dataSource =self;
    
    CollectionV.backgroundColor = [UIColor whiteColor];
    CollectionV.delaysContentTouches = true;
    
    
    CollectionV.emptyDataSetSource=self;
    CollectionV.emptyDataSetDelegate=self;
    
    [CollectionV registerClass:[TeacheCourseViewCollectionViewCell class] forCellWithReuseIdentifier:@"searchcellid"];
    
    
   
    
    
    [self.view addSubview:CollectionV];
}


- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"img_noinfo_default"];
}


- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return true;
}





//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return searchhCourse.count;
    
}

//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    TeacheCourseViewCollectionViewCell  *Coursecell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"searchcellid" forIndexPath:indexPath];
    
    if (searchhCourse) {
        if (searchhCourse[indexPath.item].img_url) {
            Coursecell.imageName =searchhCourse[indexPath.item].img_url;
        }
        
        
        if (searchhCourse[indexPath.item].title) {
            
            Coursecell.titlename  =searchhCourse[indexPath.item].title;
            
        }
        
        if (searchhCourse[indexPath.item].teacher_name) {
            Coursecell.teachername=searchhCourse[indexPath.item].teacher_name;
        }
        
        if (searchhCourse[indexPath.row].teacher_photo) {
            Coursecell.headimageName=searchhCourse[indexPath.item].teacher_photo;
        }
        
        if (searchhCourse[indexPath.row].start_time) {
            Coursecell.timename=searchhCourse[indexPath.item].start_time;
        }
        
        
        
    }
    
    return Coursecell;
}


-(void)initgzyinluCourse
{
    
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    [parameterCountry setObject:searchText.text forKey:@"text"];
        
        
        
        [self GeneralButtonAction];
        [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:searchCourse withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
            NSLog(@"error%zd",error.code);
            if (!error) {
                BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
                if (response.code  == 200) {
                    if (searchhCourse) {
                        [searchhCourse removeAllObjects ];
                    }
                    searchhCourse=[CourseDetailResponse mj_objectArrayWithKeyValuesArray:response.data];
                    
                    
                    if (searchhCourse) {
                        
                        
                        [CollectionV reloadData];
                        
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
           
            
        }];
    
    
    
}

//设置点击 Cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
    
        
        
        
        
        NSUserDefaults *defaults= DEFAULTS;
        
        [defaults removeObjectForKey:@"play_url"];
        [defaults synchronize];
        [defaults setObject:searchhCourse[indexPath.row].id forKey:@"play_url"];
        
        
        [self presentViewController:[playerViewController new] animated:YES completion:nil];
        
    
}
@end
