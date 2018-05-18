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
@interface headViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate>

@end

@implementation headViewController
NSMutableArray<TeacherResponse *> *guzhuyinluCourse;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self addtextAd];
    [self addTheCollectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addtextAd{
    
    UIImageView *title =[[UIImageView alloc]init];
    title.image=[UIImage imageNamed:@"img_hom_hot_precourse"];
    title.frame = CGRectMake(30, 33, title.image.size.width, title.image.size.height);
    

    
    
    NSArray *textStrings = @[@"纯文字上下滚动轮播，纯文字上下滚动轮播1",
                             @"纯文字上下滚动轮播，纯文字上下滚动轮播2",
                             @"纯文字上下滚动轮播，纯文字上下滚动轮播3",
                             @"纯文字上下滚动轮播，纯文字上下滚动轮播4"];
    self.textAd = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(100, 33, kScreen_Width-200, 54) delegate:self placeholderImage:nil];
    self.textAd.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.textAd.onlyDisplayText = YES;
    self.textAd.titlesGroup = textStrings;
    self.textAd.titleLabelTextColor = [UIColor darkTextColor];
    self.textAd.titleLabelBackgroundColor = [UIColor whiteColor];
    
    
    
    UIButton *enterButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreen_Width-70,
                                                                       26, 45,40)];
    [enterButton setTitle:@"查看" forState:UIControlStateNormal];
    [enterButton setTitleColor:[UIColor_ColorChange colorWithHexString:@"952e3a"] forState:UIControlStateNormal];
    [enterButton.layer setBorderWidth:1.0];
    [enterButton.layer setBorderColor:[UIColor_ColorChange colorWithHexString:@"952e3a"].CGColor];
     enterButton.backgroundColor =[UIColor clearColor];
    
    [enterButton addTarget:self action:@selector(enterBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:enterButton];
   
    
    
    
    [self.view addSubview: title];
    [self.view addSubview: self.textAd];
}
-(void)enterBtnClick{
    
    
    
}

-(void)addTheCollectionView{
    // 创建自定义布局
    MRLineLayout *layout = [[MRLineLayout alloc] init];
    // 设置UICollectionView中每个Item的size
    layout.itemSize = CGSizeMake(200, 300);
    
  
    self.myhotteacherCollectionV=[[UICollectionView alloc]initWithFrame:CGRectMake(0,200, kScreen_Width,350)collectionViewLayout:layout];
    self.myhotteacherCollectionV.delegate =self;
    self.myhotteacherCollectionV.dataSource =self;
    self.myhotteacherCollectionV.backgroundColor =[UIColor whiteColor];
    
    self.myhotteacherCollectionV.delaysContentTouches = true;
    
    
    [self.myhotteacherCollectionV registerClass:[teacherCollectionViewCell class] forCellWithReuseIdentifier:@"teacherColl"];
    
    
//    self.myhotteacherCollectionV.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        
//        [self inithotteacher];
//        
//    }];
    
    
    [self.view addSubview: self.myhotteacherCollectionV];
    [self inithotteacher];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UICollectionViewLayout *layout; // 布局
    
    if([self.myhotteacherCollectionV.collectionViewLayout isKindOfClass:[MRLineLayout class]]) {
        
        layout = [[MRCircleLayout alloc] init];
        
    }else if([self.myhotteacherCollectionV.collectionViewLayout isKindOfClass:[MRCircleLayout class]]) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        
        // 重新设置布局
        [self.myhotteacherCollectionV setCollectionViewLayout:layout animated:YES];
        
        return;
        
    }else if([self.myhotteacherCollectionV.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]){
        
        MRGridLayout *layout = [[MRGridLayout alloc] init];
        
        [self.myhotteacherCollectionV setCollectionViewLayout:layout animated:YES];
        
        return;
        
    }else {
        
        MRLineLayout *layout = [[MRLineLayout alloc] init];
        
        layout.itemSize = CGSizeMake(150, 150);
        
        // 重新设置布局
        [self.myhotteacherCollectionV setCollectionViewLayout:layout animated:YES];
        
        return;
    }
    
    // 重新设置布局
    [self.myhotteacherCollectionV setCollectionViewLayout:layout animated:YES];
}





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
    
    if (guzhuyinluCourse) {
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
    
    if (guzhuyinluCourse.count>indexPath.row) {
        NSLog(@"id %@",guzhuyinluCourse[indexPath.row].id);
        
        NSUserDefaults *defaults= DEFAULTS;
        
        [defaults removeObjectForKey:@"attteacher_id"];
        
        [defaults setObject:guzhuyinluCourse[indexPath.row].id forKey:@"attteacher_id"];
        [defaults synchronize];
        
        [self.view.window.rootViewController presentViewController:[[inlurenViewController alloc] init] animated:YES completion:nil];
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
