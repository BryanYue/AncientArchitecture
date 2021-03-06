//
//  xianchangViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/12.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "xianchangViewController.h"
#import "CourseDetailResponse.h"
#import "MJRefresh.h"
#import "TeacheCourseViewCollectionViewCell.h"
#import "playerViewController.h"


@interface xianchangViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property(strong,nonatomic)UICollectionView *xianchangCollectionV;
@end

@implementation xianchangViewController
NSMutableArray<CourseDetailResponse *> *xianchangCourse;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTheCollectionView];
    [self initxianchangCourse];
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



-(void)viewDidAppear:(BOOL)animated{
      [self initxianchangCourse];
}
//创建视图

-(void)addTheCollectionView{
    //=======================1===========================
    
    //创建一个块状表格布局对象
    
    UICollectionViewFlowLayout *flowL = [UICollectionViewFlowLayout new];
    
    //格子的大小 (长，高)

    flowL.itemSize =CGSizeMake(kScreen_Width,240);

    //如果有多个区 就可以拉动
    
    [flowL setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    
    
    
    
    //创建一个UICollectionView
    
    _xianchangCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, kScreen_Width,kScreen_Height-30-statusBar_Height-49-50)collectionViewLayout:flowL];
    
    //设置代理为当前控制器
    
    _xianchangCollectionV.delegate =self;
    
    _xianchangCollectionV.dataSource =self;
    _xianchangCollectionV.emptyDataSetSource=self;
    _xianchangCollectionV.emptyDataSetDelegate=self;
    //设置背景
    
    _xianchangCollectionV.backgroundColor =[UIColor whiteColor];
    
     _xianchangCollectionV.delaysContentTouches = true;
    
#pragma mark -- 注册单元格
    
    [_xianchangCollectionV registerClass:[TeacheCourseViewCollectionViewCell class] forCellWithReuseIdentifier:@"xianchangcellid"];
    

    
    
    //添加视图
    _xianchangCollectionV.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //刷新时候，需要执行的代码。一般是请求最新数据，请求成功之后，刷新列表
        
        [self initxianchangCourse];
       
    }];
    
    
    [self.view addSubview:_xianchangCollectionV];
}

//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
  return xianchangCourse.count;
    
}




//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
   
        TeacheCourseViewCollectionViewCell  *Coursecell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"xianchangcellid" forIndexPath:indexPath];
        
        if (xianchangCourse.count>0) {
            if (xianchangCourse[indexPath.item].img_url) {
                Coursecell.imageName =xianchangCourse[indexPath.item].img_url;
            }
            
            
            if (xianchangCourse[indexPath.item].title) {
                
                Coursecell.titlename  =xianchangCourse[indexPath.item].title;
                
            }
            
            if (xianchangCourse[indexPath.item].teacher_name) {
                Coursecell.teachername=xianchangCourse[indexPath.item].teacher_name;
            }
            
            if (xianchangCourse[indexPath.row].teacher_photo) {
                Coursecell.headimageName=xianchangCourse[indexPath.item].teacher_photo;
            }
            
            if (xianchangCourse[indexPath.row].start_time) {
                Coursecell.timename=xianchangCourse[indexPath.item].start_time;
            }
            
            
           
        }

    return Coursecell;
}


-(void) initxianchangCourse
{
    
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    [parameterCountry setObject:@"1" forKey:@"page"];
    [parameterCountry setObject:@"1" forKey:@"type"];
//    [self GeneralButtonAction];
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_allCourse withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                if (xianchangCourse) {
                     [xianchangCourse removeAllObjects ];
                }
                xianchangCourse=[CourseDetailResponse mj_objectArrayWithKeyValuesArray:response.data];
                
                
                if (xianchangCourse) {
                    
                    
                    [_xianchangCollectionV reloadData];
                    
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
        [_xianchangCollectionV.mj_header  endRefreshing];
        
    }];
}
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *title = @"这里空空如也";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:16],
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







//设置点击 Cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
  
        
        
        if (xianchangCourse.count>0) {
            NSUserDefaults *defaults= DEFAULTS;
            
            [defaults removeObjectForKey:@"play_url"];
            [defaults synchronize];
            [defaults setObject:xianchangCourse[indexPath.row].id forKey:@"play_url"];
            playerViewController *classificationView=[[playerViewController alloc]init];
            [self.view.window.rootViewController presentViewController:classificationView animated:YES completion:nil];
            
            //            [self.magicController presentViewController:[playerViewController new] animated:YES completion:nil];
        }
        
        
        
        
        
  

}






@end
