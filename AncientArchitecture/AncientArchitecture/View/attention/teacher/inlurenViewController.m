//
//  inlurenViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/15.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "inlurenViewController.h"
#import "TeacherResponse.h"
#import "LoginViewController.h"
#import "CourseDetailResponse.h"
#import "TeacheCourseViewCollectionViewCell.h"
#import "MJRefresh.h"
#import "startLiveViewController.h"
@interface inlurenViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate
>


@end

@implementation inlurenViewController
UIImageView *inluren_image;
UILabel * tinluren_name;
UILabel * tinluren_speaker;
UILabel * tinluren_longevity;
UILabel * tinluren_motto;
UILabel * tinluren_descibre;
UILabel * tinluren_kecheng;
UIScrollView * yinluscrollView;
UICollectionView *tinlurenCollectionV;
NSMutableArray<CourseDetailResponse *> *tinlurenCourse;
float h;
int is_follow;
UIImageView *rightImageView;
NSString *teacher_nameyl;
NSString *teacher_photoyl;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initview];
    [self initdata];
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
-(void)initdata
{
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    if ([DEFAULTS objectForKey:@"memberid"]) {
        [parameterCountry setObject:[DEFAULTS objectForKey:@"memberid"] forKey:@"memberid"];
    }
    
    [parameterCountry setObject:[DEFAULTS objectForKey:@"attteacher_id"] forKey:@"teacher_id"];
    
    
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_getTeacher withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                NSLog(@"%@",response.data);
                
              
                TeacherResponse *yiluren =[TeacherResponse mj_objectWithKeyValues:response.data];
                
                if (yiluren.photo) {
                    teacher_photoyl=yiluren.photo;
//                    [inluren_image yy_setImageWithURL:[NSURL URLWithString:yiluren.photo] placeholder:nil]  ;
                  [inluren_image sd_setImageWithURL:[NSURL URLWithString:yiluren.photo]];
//                    [inluren_image yy_setImageWithURL:[NSURL URLWithString:yiluren.photo]
//                                                  placeholder:nil
//                                                      options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation
//                                                     progress:nil
//                                                    transform:^UIImage *(UIImage *image, NSURL *url) {
////                                                        image = [image yy_imageByResizeToSize:CGSizeMake(kScreen_Width,yinluscrollView.frame.size.height/5*3) contentMode:UIViewContentModeScaleToFill];
//                                                        //                            return [image yy_imageByRoundCornerRadius:10];
//                                                        return  image;
//                                                    }
//                                                   completion:nil];
                }
                
                if (yiluren.name) {
                    [tinluren_name setText: yiluren.name ];
                    teacher_nameyl=yiluren.name ;
                }
                
                if (yiluren.speaker_content) {
        
                    NSString *s=[@"主讲课程:" stringByAppendingString: yiluren.speaker_content];
                    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:s];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(5, yiluren.speaker_content.length)];
                     tinluren_speaker.attributedText=string;
                }
                
                
                if (yiluren.longevity) {
                    
                    NSString *s=[@"从业时间:" stringByAppendingString: yiluren.longevity];
                    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:s];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(5, yiluren.longevity.length)];
                    tinluren_longevity.attributedText=string;
                }
                
                if (yiluren.teacher_motto) {
                    
                    NSString *s=[@"讲师格言:" stringByAppendingString: yiluren.teacher_motto];
                    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:s];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(5, yiluren.teacher_motto.length)];
                    tinluren_motto.attributedText=string;
                }
                if (yiluren.descibre) {
                     [tinluren_descibre setText: yiluren.descibre ];
                    tinluren_descibre.numberOfLines=0;//行数设为0，表示不限制行数
                    //根据label的内容和label的font为label设置frame，100为label的长度
                    CGRect txRect = [tinluren_descibre.text boundingRectWithSize:CGSizeMake(kScreen_Width, [UIScreen mainScreen].bounds.size.height*10) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:tinluren_descibre.font} context:nil];
                    tinluren_descibre.frame=CGRectMake(20, h, txRect.size.width, txRect.size.height+20);//重新为label设置frame
                    h=h+tinluren_descibre.frame.size.height;
                    [self.view addSubview:yinluscrollView];
                }
                
                
               
                UILabel * tinluren_kecheng=[[UILabel alloc] init];
                 tinluren_kecheng.textAlignment=NSTextAlignmentLeft;
                 tinluren_kecheng.textColor=[UIColor blackColor];
                 tinluren_kecheng.frame=CGRectMake(20, h,kScreen_Width,yinluscrollView.frame.size.height/ 3/3);
                [yinluscrollView addSubview: tinluren_kecheng];
                h=h+ tinluren_kecheng.frame.size.height;
                [ tinluren_kecheng setText: @"讲师课程" ];
                
                
                CGRect txRect = [tinluren_kecheng.text boundingRectWithSize:CGSizeMake(kScreen_Width, [UIScreen mainScreen].bounds.size.height*10) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:tinluren_kecheng.font} context:nil];
                UIView *line3=[[UIView alloc] init ];
                line3.backgroundColor=[UIColor_ColorChange colorWithHexString:app_theme];
                line3.frame=CGRectMake(0, h , 20+txRect.size.width,1 );
                [yinluscrollView addSubview:line3];
                h=h+line3.frame.size.height;
                
                [self addTheCollectionView];
                [self initgzyinluCourse];
                 yinluscrollView.contentSize=CGSizeMake(kScreen_Width-40, h);
                
                
                if ((int)1==[yiluren.is_follow intValue]) {
                   rightImageView.image = [UIImage imageNamed:@"icon_colloect_pink"];
                    is_follow=0;
                }else{
                    rightImageView.image = [UIImage imageNamed:@"icon_colloect_white"];
                    is_follow=1;
                }
               

              
            }
            
            
            
        }
        
    }];
}

-(void)addTheCollectionView{
    UICollectionViewFlowLayout *flowL = [UICollectionViewFlowLayout new];
    flowL.itemSize =CGSizeMake(kScreen_Width,240);
    [flowL setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    tinlurenCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0,h, kScreen_Width,kScreen_Height-30-statusBar_Height-49)collectionViewLayout:flowL];
    h=h+kScreen_Height-30-statusBar_Height-49;
    tinlurenCollectionV.delegate =self;
    tinlurenCollectionV.dataSource =self;
    tinlurenCollectionV.backgroundColor =[UIColor whiteColor];
    
    tinlurenCollectionV.delaysContentTouches = true;
    
    
    tinlurenCollectionV.emptyDataSetSource=self;
    tinlurenCollectionV.emptyDataSetDelegate=self;
    
    [tinlurenCollectionV registerClass:[TeacheCourseViewCollectionViewCell class] forCellWithReuseIdentifier:@"yinluren"];
    
    
    tinlurenCollectionV.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self initgzyinluCourse];
        
    }];
    
    
    [self.view addSubview:tinlurenCollectionV];
}


//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return tinlurenCourse.count;
    
}



//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    TeacheCourseViewCollectionViewCell  *Coursecell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"yinluren" forIndexPath:indexPath];
    
    if (tinlurenCourse.count>0) {
        if (tinlurenCourse[indexPath.item].img_url) {
            Coursecell.imageName =tinlurenCourse[indexPath.item].img_url;
        }
        
        
        if (tinlurenCourse[indexPath.item].title) {
            
            Coursecell.titlename  =tinlurenCourse[indexPath.item].title;
            
        }
        
        if (teacher_nameyl) {
            Coursecell.teachername=teacher_nameyl;
        }
        
        if (teacher_photoyl) {
            Coursecell.headimageName=teacher_photoyl;
        }
        
        if (tinlurenCourse[indexPath.row].start_time) {
            Coursecell.timename=tinlurenCourse[indexPath.item].start_time;
        }
        
        if (tinlurenCourse[indexPath.row].cate_name) {
            Coursecell.classificationname=tinlurenCourse[indexPath.row].cate_name;
        }
        
    }
    
    return Coursecell;
}

//设置点击 Cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
    if (tinlurenCourse.count>0) {
        if (tinlurenCourse.count>indexPath.row) {
            NSLog(@"id %@",tinlurenCourse[indexPath.row].id);
            
            NSUserDefaults *defaults= DEFAULTS;
            
            [defaults removeObjectForKey:@"push_id"];
            [defaults synchronize];
            [defaults setObject:tinlurenCourse[indexPath.row].id forKey:@"push_id"];
            
            
            [self presentViewController:[startLiveViewController new] animated:YES completion:nil];
        }
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

-(void)initgzyinluCourse
{
    
  
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    if ([DEFAULTS objectForKey:@"memberid"]) {
        [parameterCountry setObject:[DEFAULTS objectForKey:@"memberid"] forKey:@"memberid"];
    }
    
    [parameterCountry setObject:[DEFAULTS objectForKey:@"attteacher_id"] forKey:@"teacher_id"];
   
    
    
    [self GeneralButtonAction];
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_getTeacheCourse withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                if (tinlurenCourse) {
                    [tinlurenCourse removeAllObjects ];
                }else{
                    tinlurenCourse=[NSMutableArray array];
                }
                tinlurenCourse=[CourseDetailResponse mj_objectArrayWithKeyValuesArray:response.data];
                
                NSLog(@"tinlurenCourse%@",tinlurenCourse);
                if (tinlurenCourse) {
                    
                    
                    [tinlurenCollectionV reloadData];
                    
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
        [tinlurenCollectionV.mj_header  endRefreshing];
        
    }];
}





-(void) initview
{
    [self initbaseView];
    self.view.backgroundColor=[UIColor whiteColor];
    [self addBackButton];
    [self.topTitleLabel setText:@"引路人"];
    
    h=0;
    yinluscrollView = [UIScrollView new];
    yinluscrollView.frame=CGRectMake(0, self.topView.frame.size.height, kScreen_Width,kScreen_Height-self.topView.frame.size.height );
    
    
    inluren_image=[[UIImageView alloc]init ];
    inluren_image.frame=CGRectMake(0, 0,kScreen_Width,yinluscrollView.frame.size.height/5*3 );
    [yinluscrollView addSubview:inluren_image];
    
    [inluren_image setContentScaleFactor:[[UIScreen mainScreen] scale]];
    inluren_image.contentMode =  UIViewContentModeScaleAspectFill;
    inluren_image.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    inluren_image.clipsToBounds  = YES;
    h=h+inluren_image.frame.size.height;
    
    tinluren_name=[[UILabel alloc] init];
    tinluren_name.textAlignment=NSTextAlignmentLeft;
    tinluren_name.textColor=[UIColor blackColor];
    tinluren_name.frame=CGRectMake(20, h,kScreen_Width,yinluscrollView.frame.size.height/ 3/3);
    [yinluscrollView addSubview:tinluren_name];
    h=h+tinluren_name.frame.size.height;
    
    UIView *line1=[[UIView alloc] init ];
    line1.backgroundColor=[UIColor_ColorChange colorWithHexString:app_theme];
    line1.frame=CGRectMake(0, h , kScreen_Width,1 );
    [yinluscrollView addSubview:line1];
    h=h+line1.frame.size.height;
    
    tinluren_speaker=[[UILabel alloc] init];
    tinluren_speaker.textAlignment=NSTextAlignmentLeft;
    tinluren_speaker.textColor=[UIColor blackColor];
    tinluren_speaker.numberOfLines=1;
    tinluren_speaker.frame=CGRectMake(20, h,kScreen_Width-20,yinluscrollView.frame.size.height/ 3/4);
    [yinluscrollView addSubview:tinluren_speaker];
     h=h+tinluren_speaker.frame.size.height;
    
    tinluren_longevity=[[UILabel alloc] init];
    tinluren_longevity.textAlignment=NSTextAlignmentLeft;
    tinluren_longevity.textColor=[UIColor blackColor];
    tinluren_longevity.numberOfLines=1;
    tinluren_longevity.frame=CGRectMake(20, h,kScreen_Width,yinluscrollView.frame.size.height/ 3/4);
    [yinluscrollView addSubview:tinluren_longevity];
      h=h+tinluren_longevity.frame.size.height;
    
    tinluren_motto=[[UILabel alloc] init];
    tinluren_motto.textAlignment=NSTextAlignmentLeft;
    tinluren_motto.textColor=[UIColor blackColor];
    tinluren_motto.numberOfLines=1;
    tinluren_motto.frame=CGRectMake(20, h,kScreen_Width,yinluscrollView.frame.size.height/ 3/4);
    [yinluscrollView addSubview:tinluren_motto];
    h=h+tinluren_motto.frame.size.height;
    
    
    
    UILabel *tinluren_jianjie=[[UILabel alloc] init];
    tinluren_jianjie.textAlignment=NSTextAlignmentLeft;
    tinluren_jianjie.textColor=[UIColor blackColor];
    tinluren_jianjie.frame=CGRectMake(20, h,kScreen_Width,yinluscrollView.frame.size.height/ 3/3);
    [yinluscrollView addSubview:tinluren_jianjie];
    h=h+tinluren_jianjie.frame.size.height;
     [tinluren_jianjie setText: @"讲师简介" ];
    
    
    CGRect txRect = [tinluren_jianjie.text boundingRectWithSize:CGSizeMake(kScreen_Width, [UIScreen mainScreen].bounds.size.height*10) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:tinluren_jianjie.font} context:nil];
    UIView *line2=[[UIView alloc] init ];
    line2.backgroundColor=[UIColor_ColorChange colorWithHexString:app_theme];
    line2.frame=CGRectMake(0, h , 20+txRect.size.width,1 );
    [yinluscrollView addSubview:line2];
    h=h+line2.frame.size.height;
    
    
    tinluren_descibre=[[UILabel alloc] init];
    tinluren_descibre.textAlignment=NSTextAlignmentLeft;
    tinluren_descibre.textColor=[UIColor grayColor];
    tinluren_descibre.frame=CGRectMake(20, h,kScreen_Width,0);
    [yinluscrollView addSubview:tinluren_descibre];
    
    [self addRightbutton:@"icon_colloect_white"];
   
}

-(void)addRightbutton:(NSString *)image{
    rightImageView = [[UIImageView alloc] init];
    rightImageView.image = [UIImage imageNamed:image];
    rightImageView.frame  = CGRectMake(kScreen_Width-10-rightImageView.image.size.width, statusBar_Height+18-rightImageView.image.size.height/2, rightImageView.image.size.width, rightImageView.image.size.height);
    [self.topView addSubview:rightImageView];
    
    self.rightChangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightChangeBtn setFrame:CGRectMake(kScreen_Width-20-rightImageView.image.size.width, statusBar_Height, 80, rightImageView.image.size.height)];
    [self.rightChangeBtn addTarget:self action:@selector(rightButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.rightChangeBtn];
    
}





-(void)rightButtonPress{
     if([DEFAULTS objectForKey:@"islogin"]){
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    
    
    if ([DEFAULTS objectForKey:@"memberid"]) {
        [parameterCountry setObject:[DEFAULTS objectForKey:@"memberid"] forKey:@"memberid"];
    }
   
    [parameterCountry setObject:[DEFAULTS objectForKey:@"attteacher_id"] forKey:@"teacher_id"];
     [parameterCountry setObject:@(is_follow) forKey:@"type"];
    
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_teacherCollect withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                NSLog(@"%@",response.data);
                 rightImageView.image = [UIImage imageNamed:is_follow==0?@"icon_colloect_white":@"icon_colloect_pink"];
                is_follow=is_follow==1?0:1;
               
                
            }else{
                [self TextButtonAction:response.msg];

            }
        }else{
             [self TextButtonAction:error.domain];
        }
        
    }];
         
     }else{
          [self presentViewController:[LoginViewController new] animated:YES completion:nil];
     }
}











@end
