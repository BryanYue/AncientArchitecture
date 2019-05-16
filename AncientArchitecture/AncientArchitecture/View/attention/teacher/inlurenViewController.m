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
#import "playerViewController.h"
@interface inlurenViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate
>
@property (nonatomic, strong) UIImageView *inluren_image;
@property (nonatomic, strong)  UILabel * tinluren_name;
@property (nonatomic, strong) UILabel * tinluren_speaker;
@property (nonatomic, strong)  UILabel * tinluren_longevity;
@property (nonatomic, strong) UILabel * tinluren_motto;
@property (nonatomic, strong) UILabel * tinluren_descibre;
@property (nonatomic, strong) UILabel * tinluren_kecheng;
@property (nonatomic, strong) UIScrollView * yinluscrollView;
@property (nonatomic, strong)UICollectionView *tinlurenCollectionV;
@property (nonatomic, strong) NSMutableArray<CourseDetailResponse *> *tinlurenCourse;
@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation inlurenViewController

float h;
int is_follow;

NSString *teacher_nameyl;
NSString *teacher_photoyl;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_tinlurenCourse) {
        [_tinlurenCourse removeAllObjects ];
    }else{
        _tinlurenCourse=[NSMutableArray array];
    }
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
                  [_inluren_image sd_setImageWithURL:[NSURL URLWithString:yiluren.photo]];
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
                    [_tinluren_name setText: yiluren.name ];
                    teacher_nameyl=yiluren.name ;
                }
                
                if (yiluren.speaker_content) {
        
                    NSString *s=[@"主讲课程:" stringByAppendingString: yiluren.speaker_content];
                    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:s];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(5, yiluren.speaker_content.length)];
                     _tinluren_speaker.attributedText=string;
                }
                
                
                if (yiluren.longevity) {
                    
                    NSString *s=[@"从业时间:" stringByAppendingString: yiluren.longevity];
                    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:s];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(5, yiluren.longevity.length)];
                    _tinluren_longevity.attributedText=string;
                }
                
                if (yiluren.teacher_motto) {
                    
                    NSString *s=[@"讲师格言:" stringByAppendingString: yiluren.teacher_motto];
                    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:s];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(5, yiluren.teacher_motto.length)];
                    _tinluren_motto.attributedText=string;
                }
                if (yiluren.descibre) {
                     [_tinluren_descibre setText: yiluren.descibre ];
                    _tinluren_descibre.numberOfLines=0;//行数设为0，表示不限制行数
                    //根据label的内容和label的font为label设置frame，100为label的长度
                    CGRect txRect = [_tinluren_descibre.text boundingRectWithSize:CGSizeMake(kScreen_Width-40, [UIScreen mainScreen].bounds.size.height*10) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_tinluren_descibre.font} context:nil];
                    _tinluren_descibre.frame=CGRectMake(20, h, txRect.size.width, txRect.size.height+20);//重新为label设置frame
                    h=h+_tinluren_descibre.frame.size.height;
                    [self.view addSubview:_yinluscrollView];
                }
                
                
               
                UILabel * tinluren_kecheng=[[UILabel alloc] init];
                 tinluren_kecheng.textAlignment=NSTextAlignmentLeft;
                 tinluren_kecheng.textColor=[UIColor blackColor];
                 tinluren_kecheng.frame=CGRectMake(20, h,kScreen_Width,_yinluscrollView.frame.size.height/ 3/3);
                [_yinluscrollView addSubview: tinluren_kecheng];
                h=h+ tinluren_kecheng.frame.size.height;
                [ tinluren_kecheng setText: @"讲师课程" ];
                
                
                CGRect txRect = [tinluren_kecheng.text boundingRectWithSize:CGSizeMake(kScreen_Width, [UIScreen mainScreen].bounds.size.height*10) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:tinluren_kecheng.font} context:nil];
                UIView *line3=[[UIView alloc] init ];
                line3.backgroundColor=[UIColor_ColorChange colorWithHexString:app_theme];
                line3.frame=CGRectMake(0, h , 20+txRect.size.width,1 );
                
                [_yinluscrollView addSubview:line3];
                h=h+line3.frame.size.height;
                
                [self addTheCollectionView];
                [self initgzyinluCourse];
                 _yinluscrollView.contentSize=CGSizeMake(kScreen_Width-40, h);
                
                
              if ((int)1==[yiluren.is_follow intValue]) {
                   _rightImageView.image = [UIImage imageNamed:@"icon_colloect_pink"];
                    is_follow=0;
                }else{
                   _rightImageView.image = [UIImage imageNamed:@"icon_colloect_white"];
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
    
    _tinlurenCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0,h, kScreen_Width,kScreen_Height-statusBar_Height)collectionViewLayout:flowL];
    h=h+kScreen_Height-statusBar_Height;
    _tinlurenCollectionV.delegate =self;
    _tinlurenCollectionV.dataSource =self;
    _tinlurenCollectionV.backgroundColor =[UIColor whiteColor];
    
    _tinlurenCollectionV.delaysContentTouches = true;
    
    
    _tinlurenCollectionV.emptyDataSetSource=self;
    _tinlurenCollectionV.emptyDataSetDelegate=self;
    
    [_tinlurenCollectionV registerClass:[TeacheCourseViewCollectionViewCell class] forCellWithReuseIdentifier:@"yinluren"];
    
    
    _tinlurenCollectionV.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self initgzyinluCourse];
        
    }];
    
    
    [_yinluscrollView addSubview:_tinlurenCollectionV];
}


//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _tinlurenCourse.count;
    
}



//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    TeacheCourseViewCollectionViewCell  *Coursecell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"yinluren" forIndexPath:indexPath];
    
    if (_tinlurenCourse.count>0) {
        if (_tinlurenCourse[indexPath.item].img_url) {
            Coursecell.imageName =_tinlurenCourse[indexPath.item].img_url;
        }
        
        
        if (_tinlurenCourse[indexPath.item].title) {
            
            Coursecell.titlename  =_tinlurenCourse[indexPath.item].title;
            
        }
        
        if (teacher_nameyl) {
            Coursecell.teachername=teacher_nameyl;
        }
        
        if (teacher_photoyl) {
            Coursecell.headimageName=teacher_photoyl;
        }
        
        if (_tinlurenCourse[indexPath.row].start_time) {
            Coursecell.timename=_tinlurenCourse[indexPath.item].start_time;
        }
        
        if (_tinlurenCourse[indexPath.row].cate_name) {
            Coursecell.classificationname=_tinlurenCourse[indexPath.row].cate_name;
        }
        
    }
    
    return Coursecell;
}

//设置点击 Cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
    if (_tinlurenCourse.count>0) {
        NSUserDefaults *defaults= DEFAULTS;
        
        [defaults removeObjectForKey:@"play_url"];
        [defaults synchronize];
        [defaults setObject:_tinlurenCourse[indexPath.row].id forKey:@"play_url"];
        
        
        [self presentViewController:[playerViewController new] animated:YES completion:nil];
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
                if (_tinlurenCourse) {
                    [_tinlurenCourse removeAllObjects ];
                }else{
                    _tinlurenCourse=[NSMutableArray array];
                }
                _tinlurenCourse=[CourseDetailResponse mj_objectArrayWithKeyValuesArray:response.data];
                
                NSLog(@"tinlurenCourse%@",_tinlurenCourse);
                if (_tinlurenCourse.count >0) {
                    
                    
                    [_tinlurenCollectionV reloadData];
                    
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
        [_tinlurenCollectionV.mj_header  endRefreshing];
        
    }];
}





-(void) initview
{
    [self initbaseView];
    self.view.backgroundColor=[UIColor whiteColor];
    [self addBackButton];
    [self.topTitleLabel setText:@"引路人"];
    
    h=0;
    _yinluscrollView = [UIScrollView new];
    _yinluscrollView.frame=CGRectMake(0, self.topView.frame.size.height, kScreen_Width,kScreen_Height-self.topView.frame.size.height );
    
    
    _inluren_image=[[UIImageView alloc]init ];
    _inluren_image.frame=CGRectMake(0, 0,kScreen_Width,_yinluscrollView.frame.size.height/5*3 );
    [_yinluscrollView addSubview:_inluren_image];
    
    [_inluren_image setContentScaleFactor:[[UIScreen mainScreen] scale]];
    _inluren_image.contentMode =  UIViewContentModeScaleAspectFill;
    _inluren_image.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _inluren_image.clipsToBounds  = YES;
    h=h+_inluren_image.frame.size.height;
    
    _tinluren_name=[[UILabel alloc] init];
    _tinluren_name.textAlignment=NSTextAlignmentLeft;
    _tinluren_name.textColor=[UIColor blackColor];
    _tinluren_name.frame=CGRectMake(20, h,kScreen_Width,_yinluscrollView.frame.size.height/ 3/3);
    [_yinluscrollView addSubview:_tinluren_name];
    h=h+_tinluren_name.frame.size.height;
    
    UIView *line1=[[UIView alloc] init ];
    line1.backgroundColor=[UIColor_ColorChange colorWithHexString:app_theme];
    line1.frame=CGRectMake(0, h , kScreen_Width,1 );
    [_yinluscrollView addSubview:line1];
    h=h+line1.frame.size.height;
    
    _tinluren_speaker=[[UILabel alloc] init];
    _tinluren_speaker.textAlignment=NSTextAlignmentLeft;
    _tinluren_speaker.textColor=[UIColor blackColor];
    _tinluren_speaker.numberOfLines=1;
    _tinluren_speaker.frame=CGRectMake(20, h,kScreen_Width-20,_yinluscrollView.frame.size.height/ 3/4);
    [_yinluscrollView addSubview:_tinluren_speaker];
     h=h+_tinluren_speaker.frame.size.height;
    
    _tinluren_longevity=[[UILabel alloc] init];
    _tinluren_longevity.textAlignment=NSTextAlignmentLeft;
    _tinluren_longevity.textColor=[UIColor blackColor];
    _tinluren_longevity.numberOfLines=1;
    _tinluren_longevity.frame=CGRectMake(20, h,kScreen_Width,_yinluscrollView.frame.size.height/ 3/4);
    [_yinluscrollView addSubview:_tinluren_longevity];
      h=h+_tinluren_longevity.frame.size.height;
    
    _tinluren_motto=[[UILabel alloc] init];
    _tinluren_motto.textAlignment=NSTextAlignmentLeft;
    _tinluren_motto.textColor=[UIColor blackColor];
    _tinluren_motto.numberOfLines=1;
    _tinluren_motto.frame=CGRectMake(20, h,kScreen_Width,_yinluscrollView.frame.size.height/ 3/4);
    [_yinluscrollView addSubview:_tinluren_motto];
    h=h+_tinluren_motto.frame.size.height;
    
    
    
    UILabel *tinluren_jianjie=[[UILabel alloc] init];
    tinluren_jianjie.textAlignment=NSTextAlignmentLeft;
    tinluren_jianjie.textColor=[UIColor blackColor];
    tinluren_jianjie.frame=CGRectMake(20, h,kScreen_Width,_yinluscrollView.frame.size.height/ 3/3);
    [_yinluscrollView addSubview:tinluren_jianjie];
    h=h+tinluren_jianjie.frame.size.height;
     [tinluren_jianjie setText: @"讲师简介" ];
    
    
    CGRect txRect = [tinluren_jianjie.text boundingRectWithSize:CGSizeMake(kScreen_Width, [UIScreen mainScreen].bounds.size.height*10) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:tinluren_jianjie.font} context:nil];
    UIView *line2=[[UIView alloc] init ];
    line2.backgroundColor=[UIColor_ColorChange colorWithHexString:app_theme];
    line2.frame=CGRectMake(0, h , 20+txRect.size.width,1 );
    [_yinluscrollView addSubview:line2];
    h=h+line2.frame.size.height;
    
    
    _tinluren_descibre=[[UILabel alloc] init];
    _tinluren_descibre.textAlignment=NSTextAlignmentLeft;
    _tinluren_descibre.textColor=[UIColor grayColor];
    _tinluren_descibre.frame=CGRectMake(20, h,kScreen_Width,0);
    [_yinluscrollView addSubview:_tinluren_descibre];
    
    [self addRightbutton:@"icon_colloect_white"];
   
}

-(void)addRightbutton:(NSString *)image{
    _rightImageView = [[UIImageView alloc] init];
    _rightImageView.image = [UIImage imageNamed:image];
    _rightImageView.frame  = CGRectMake(kScreen_Width-10-_rightImageView.image.size.width, statusBar_Height+18-_rightImageView.image.size.height/2, _rightImageView.image.size.width, _rightImageView.image.size.height);
    [self.topView addSubview:_rightImageView];
    
    self.rightChangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightChangeBtn setFrame:CGRectMake(kScreen_Width-20-_rightImageView.image.size.width, statusBar_Height, 80, _rightImageView.image.size.height)];
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
                 _rightImageView.image = [UIImage imageNamed:is_follow==0?@"icon_colloect_white":@"icon_colloect_pink"];
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
