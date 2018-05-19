//
//  playerViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/13.
//  Copyright © 2018年 通感科技. All rights reserved.
//
#import "BaseResponse.h"
#import "CourseDetailResponse.h"
#import "playerViewController.h"
#import "CourseDetailResponse.h"
#import "MJRefresh.h"
#import "xiangguanCollectionViewCell.h"
#import "LoginViewController.h"
#import "relevantCourseResponse.h"
@interface playerViewController ()<AliyunVodPlayerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>




@end

@implementation playerViewController
bool isFreePlay;
int playerViewh;
int is_playefollow;
NSString *courseId;
NSMutableArray<relevantCourseResponse *> *relevant;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self initview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated{
    if (self.playerView) {
         [self.playerView stop];
    }
}


-(void)initview{
    self.scrollView = [[UIScrollView alloc]init ];
    self.scrollView.frame=CGRectMake(0, kScreen_Height/3, kScreen_Width,kScreen_Height);
    
    self.scrollView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //刷新时候，需要执行的代码。一般是请求最新数据，请求成功之后，刷新列表
        [self.playerView stop];
        [self initdata];
    }];
    

//    //创建播放器
//    self.mediaPlayer = [[AliVcMediaPlayer alloc] init];
//    //创建播放器视图，其中contentView为UIView实例，自己根据业务需求创建一个视图即可
//    /*self.mediaPlayer:NSObject类型，需要UIView来展示播放界面。
//     self.contentView：承载mediaPlayer图像的UIView类。
//     self.contentView = [[UIView alloc] init];
//     [self.view addSubview:self.contentView];
//     */
//    [self.mediaPlayer create:self.contentView];
//    //设置播放类型，0为点播、1为直播，默认使用自动
//    self.mediaPlayer.mediaType = MediaType_AUTO;
//    //设置超时时间，单位为毫秒
//    self.mediaPlayer.timeout = 25000;
//    //缓冲区超过设置值时开始丢帧，单位为毫秒。直播时设置，点播设置无效。范围：500～100000
//    self.mediaPlayer.dropBufferDuration = 8000;
    
    //创建播放器对象，AliyunVodPlayerView继承自UIView，可以创建多实例，提供4套皮肤可设置
   self.playerView = [[AliyunVodPlayerView alloc] initWithFrame:CGRectMake(0,0, kScreen_Width, kScreen_Height/3) andSkin:AliyunVodPlayerViewSkinRed];
    //设置播放器代理
    [self.playerView setDelegate:self];
    //将播放器添加到需要展示的界面上
    [self.view addSubview: self.playerView];
    //prepareToPlay:此方法传入的参数是NSURL类型.
    self.playerView.circlePlay = NO;
    //   [self.playerView setAutoPlay:YES];
    
    [self addRightbutton:@"icon_colloect_white"];
    self.uiview =[[UIView alloc]init ];
//    self.uiview.frame=CGRectMake(0, kScreen_Height/3, kScreen_Width, 320);

    

    
    
    
    
    
    

    
    courseId =[DEFAULTS objectForKey:@"play_url"];
    [self initdata];
    
    
    
}

-(void)inituiview{
    
    
    
}

-(void)addRightbutton:(NSString *)image{
    self.rightChangeBtn = [[UIImageView alloc] init];
     self.rightChangeBtn.image = [UIImage imageNamed:image];
     self.rightChangeBtn.frame  = CGRectMake(kScreen_Width-10- self.rightChangeBtn.image.size.width, statusBar_Height+18,  self.rightChangeBtn.image.size.width,  self.rightChangeBtn.image.size.height);

    self.rightChangeBtn.userInteractionEnabled = YES;
    [self.rightChangeBtn addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightButtonPress)]];
    [self.view addSubview: self.rightChangeBtn];
    
}

-(void)rightButtonPress{
    NSLog(@"rightButtonPress");
    
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    [parameterCountry setObject:[DEFAULTS objectForKey:@"memberid"] forKey:@"memberid"];
    [parameterCountry setObject:courseId forKey:@"course_id"];
    [parameterCountry setObject:@(is_playefollow) forKey:@"type"];
    
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_courseCollect withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                NSLog(@"%@",response.data);
                self.rightChangeBtn.image = [UIImage imageNamed:is_playefollow==0?@"icon_colloect_white":@"icon_colloect_pink"];
                is_playefollow=is_playefollow==1?0:1;
                
                
            }
            [self TextButtonAction:response.msg];
        }else{
            [self TextButtonAction:error.domain];
        }
        
    }];
}

-(void)buy{
    NSLog(@"buy");
}


-(void)initdata{
    NSUserDefaults *defaults= DEFAULTS;
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    [parameterCountry setObject:courseId forKey:@"course_id"];
    [parameterCountry setObject:[defaults objectForKey:@"memberid"] forKey:@"memberid"];
    [parameterCountry setObject:[defaults objectForKey:@"token"] forKey:@"token"];
    
    NSString *pathWithPhoneNum = [NSString stringWithFormat:@"%@?course_id=%@&memberid=%@",url_getCourseDetail,courseId ,[defaults objectForKey:@"memberid"]];
   
    [self GeneralButtonAction];
    
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_isFreePlay withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                isFreePlay=true;
            }else{
                isFreePlay=false;
            }
        }else{
            
        }
        
        
        
        
    }];
    
    
  
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:pathWithPhoneNum withParams:nil withMethodType:Get autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                
               
                
                
                CourseDetailResponse *detailResponse =[CourseDetailResponse mj_objectWithKeyValues:response.data];
                
                if ((int)1==[detailResponse.is_follow intValue]) {
                    self.rightChangeBtn.image = [UIImage imageNamed:@"icon_colloect_pink"];
                    is_playefollow=0;
                }else{
                    self.rightChangeBtn.image = [UIImage imageNamed:@"icon_colloect_white"];
                    is_playefollow=1;
                }
                 NSLog(@"is_follow%@",detailResponse.is_follow);
                
                //设置播放器封面，封面地址和标题可以从服务端下发，封面地址请使用https 地址。
                self.playerView.coverUrl = [NSURL URLWithString:detailResponse.img_url];
                //设置播放器标题
                [self.playerView setTitle:detailResponse.title];
                
                [self.uiview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                playerViewh=0;
                UILabel *tlabele_cate_name=[[UILabel alloc] init];
                tlabele_cate_name.textAlignment=NSTextAlignmentLeft;
                tlabele_cate_name.textColor=[UIColor_ColorChange colorWithHexString:app_theme];
                tlabele_cate_name.numberOfLines=1;
                tlabele_cate_name.frame=CGRectMake(20, 0,kScreen_Width/2,40);
                 tlabele_cate_name.font = [UIFont boldSystemFontOfSize:15];
                 [tlabele_cate_name setText:detailResponse.cate_name];
                [self.uiview addSubview:tlabele_cate_name];
                
                
                UILabel *tlabele_title=[[UILabel alloc] init];
                tlabele_title.textAlignment=NSTextAlignmentRight;
                tlabele_title.textColor=[UIColor_ColorChange blackColor];
                tlabele_title.numberOfLines=1;
                tlabele_title.frame=CGRectMake(kScreen_Width/2, 0,kScreen_Width/2-20,40);
                 tlabele_title.font = [UIFont boldSystemFontOfSize:20];
                [tlabele_title setText:detailResponse.title];
                [self.uiview addSubview:tlabele_title];
                playerViewh=playerViewh+40;
                
                UIView *line1=[[UIView alloc] init ];
                line1.backgroundColor=[UIColor_ColorChange grayColor];
                line1.frame=CGRectMake(0, playerViewh , kScreen_Width,1 );
                [self.uiview addSubview:line1];
                playerViewh=playerViewh+1;
                
                
    
                if (isFreePlay) {
                     NSLog(@"isFreePlay  true");
                    if ([detailResponse.on_live isEqualToString:@"1"]) {
                        NSURL *urll = [NSURL URLWithString:detailResponse.video];
                        [self.playerView playViewPrepareWithURL:urll];
                    }else if ([detailResponse.on_live isEqualToString:@"2"]){
                        NSURL *urll = [NSURL URLWithString:detailResponse.m3u8_vod_vedio_url];
                        [self.playerView playViewPrepareWithURL:urll];
                    }
                }else{
                     NSLog(@"isFreePlay  false");
                    UILabel *tlabele_buy_num=[[UILabel alloc] init];
                    tlabele_buy_num.textAlignment=NSTextAlignmentLeft;
                    tlabele_buy_num.textColor=[UIColor_ColorChange grayColor];
                    tlabele_buy_num.numberOfLines=1;
                    tlabele_buy_num.frame=CGRectMake(20, playerViewh,kScreen_Width/3,40);
                    tlabele_buy_num.font = [UIFont boldSystemFontOfSize:15];
                    NSString *num=[detailResponse.buy_num stringByAppendingString: @"位学员学习"];
                    [tlabele_buy_num setText:num];
                    [self.uiview addSubview:tlabele_buy_num];
                    
                    
                    UILabel *tlabele_price=[[UILabel alloc] init];
                    tlabele_price.textAlignment=NSTextAlignmentRight;
                    tlabele_price.textColor=[UIColor_ColorChange colorWithHexString:app_theme];
                    tlabele_price.numberOfLines=1;
                    tlabele_price.frame=CGRectMake(kScreen_Width/3, playerViewh,kScreen_Width/3,40);
                    tlabele_price.font = [UIFont boldSystemFontOfSize:15];
                    NSString *price=[@"￥" stringByAppendingString:detailResponse.price ];
                    [tlabele_price setText:price];
                    [self.uiview addSubview:tlabele_price];
                    
                    
            
                    UIButton *btnbuy = [UIButton buttonWithType:UIButtonTypeSystem];
                    btnbuy.frame = CGRectMake(kScreen_Width-120, playerViewh+5, 100, 30);
                    [btnbuy setTitle:@"购买课程" forState:UIControlStateNormal];
                    [btnbuy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    btnbuy.backgroundColor =[UIColor_ColorChange colorWithHexString:app_theme];
                    btnbuy.layer.masksToBounds=YES;
                    btnbuy.layer.cornerRadius = 10;
                    [btnbuy addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
                    btnbuy.titleLabel.font = [UIFont boldSystemFontOfSize:20];
                    [self.uiview addSubview:btnbuy];
                    playerViewh=playerViewh+40;
                    
                    UIView *line2=[[UIView alloc] init ];
                    line2.backgroundColor=[UIColor_ColorChange grayColor];
                    line2.frame=CGRectMake(0, playerViewh , kScreen_Width,1 );
                    [self.uiview addSubview:line2];
                    playerViewh=playerViewh+1;
                    
                }
              if([detailResponse.on_live isEqualToString:@"0"]){
                  UIImageView *yubo_image=[[UIImageView alloc]init ];
                  yubo_image.image=[UIImage imageNamed:@"img_hom_hot_precourse"];
                  yubo_image.frame = CGRectMake(20, playerViewh+(80-yubo_image.image.size.height)/2, yubo_image.image.size.width, yubo_image.image.size.height);
                   [self.uiview addSubview:yubo_image];
                 
                  
                  
                  UILabel *tlabele_start_time=[[UILabel alloc] init];
                  tlabele_start_time.textAlignment=NSTextAlignmentRight;
                  tlabele_start_time.textColor=[UIColor_ColorChange grayColor];
                  tlabele_start_time.numberOfLines=1;
                  tlabele_start_time.frame=CGRectMake(kScreen_Width/3, playerViewh,kScreen_Width/3*2-10,40);
                  tlabele_start_time.font = [UIFont boldSystemFontOfSize:15];
                  NSString *time=[@"开课时间：" stringByAppendingString:detailResponse.start_time ];
                  [tlabele_start_time setText:time];
                  [self.uiview addSubview:tlabele_start_time];
                  
                  
                  UILabel *tlabele_time=[[UILabel alloc] init];
                  tlabele_time.textAlignment=NSTextAlignmentRight;
                  tlabele_time.textColor=[UIColor_ColorChange grayColor];
                  tlabele_time.numberOfLines=1;
                  tlabele_time.frame=CGRectMake(kScreen_Width/3, playerViewh+40,kScreen_Width/3*2-10,40);
                  tlabele_time.font = [UIFont boldSystemFontOfSize:15];
                  NSString *litime=[@"课程时长：" stringByAppendingString:detailResponse.class_hour ];
                  litime=[litime stringByAppendingString:@"分钟" ];
                  [tlabele_time setText:litime];
                  [self.uiview addSubview:tlabele_time];
                  
                  
                  playerViewh=playerViewh+80;
                  UIView *line5=[[UIView alloc] init ];
                  line5.backgroundColor=[UIColor_ColorChange grayColor];
                  line5.frame=CGRectMake(0, playerViewh , kScreen_Width,1 );
                  [self.uiview addSubview:line5];
                  playerViewh=playerViewh+1;
                  
                }
                
                
                
                
                
                UILabel *tlabele_jianjie=[[UILabel alloc] init];
                tlabele_jianjie.textAlignment=NSTextAlignmentLeft;
                tlabele_jianjie.textColor=[UIColor_ColorChange blackColor];
                tlabele_jianjie.numberOfLines=1;
                tlabele_jianjie.frame=CGRectMake(20, playerViewh,kScreen_Width/2,40);
                tlabele_jianjie.font = [UIFont boldSystemFontOfSize:20];
                [tlabele_jianjie setText:@"课程简介"];
                [self.uiview addSubview:tlabele_jianjie];
                 playerViewh=playerViewh+40;
                
                
                UILabel *tlabele_describe=[[UILabel alloc] init];
                tlabele_describe.textAlignment=NSTextAlignmentLeft;
                tlabele_describe.textColor=[UIColor_ColorChange grayColor];
                tlabele_describe.frame=CGRectMake(30, playerViewh,kScreen_Width/2,40);
                tlabele_describe.font = [UIFont boldSystemFontOfSize:18];
                if (detailResponse.describe) {
                     [tlabele_describe setText:detailResponse.describe];
                }
               
               [self.uiview addSubview:tlabele_describe];
                playerViewh=playerViewh+40;
                
                
                UIView *line3=[[UIView alloc] init ];
                line3.backgroundColor=[UIColor_ColorChange grayColor];
                line3.frame=CGRectMake(0, playerViewh , kScreen_Width,1 );
                [self.uiview addSubview:line3];
                playerViewh=playerViewh+1;
                
                
                UILabel *tlabele_neirong=[[UILabel alloc] init];
                tlabele_neirong.textAlignment=NSTextAlignmentLeft;
                tlabele_neirong.textColor=[UIColor_ColorChange blackColor];
                tlabele_neirong.numberOfLines=1;
                tlabele_neirong.frame=CGRectMake(20, playerViewh,kScreen_Width/2,40);
                tlabele_neirong.font = [UIFont boldSystemFontOfSize:20];
                [tlabele_neirong setText:@"课程内容"];
                [self.uiview addSubview:tlabele_neirong];
                playerViewh=playerViewh+40;
                
                
                UILabel *tlabele_content=[[UILabel alloc] init];
                tlabele_content.textAlignment=NSTextAlignmentLeft;
                tlabele_content.textColor=[UIColor_ColorChange grayColor];
                tlabele_content.frame=CGRectMake(30, playerViewh,kScreen_Width/2,40);
                tlabele_content.font = [UIFont boldSystemFontOfSize:18];
                if (detailResponse.content) {
                    [tlabele_content setText:detailResponse.content];
                }
                [tlabele_content setText:detailResponse.content];
                [self.uiview addSubview:tlabele_content];
                playerViewh=playerViewh+40;
                
                
                UIView *line4=[[UIView alloc] init ];
                line4.backgroundColor=[UIColor_ColorChange grayColor];
                line4.frame=CGRectMake(0, playerViewh , kScreen_Width,1 );
                [self.uiview addSubview:line4];
                playerViewh=playerViewh+1;
                
                
                UILabel *tlabele_xiangguan=[[UILabel alloc] init];
                tlabele_xiangguan.textAlignment=NSTextAlignmentLeft;
                tlabele_xiangguan.textColor=[UIColor_ColorChange blackColor];
                tlabele_xiangguan.numberOfLines=1;
                tlabele_xiangguan.frame=CGRectMake(20, playerViewh,kScreen_Width/2,40);
                tlabele_xiangguan.font = [UIFont boldSystemFontOfSize:20];
                [tlabele_xiangguan setText:@"相关课程"];
                [self.uiview addSubview:tlabele_xiangguan];
                playerViewh=playerViewh+40;
                
                self.uiview.frame=CGRectMake(0, 0, kScreen_Width, playerViewh);
                [self.scrollView addSubview: self.uiview ];
               
                
                self.scrollView.contentSize=CGSizeMake(kScreen_Width, playerViewh);
                [self.view addSubview:self.scrollView];
                
                
                
                [self addCollectionView];
                [self initxiangguandata];
               
               
                
                
                
            }else{
                
            }
            
            if (self.HUD) {
                [self.HUD hideAnimated:true];
            }
            [self TextButtonAction:response.msg];
            
        }else{
            
        }
        
    
        [self.scrollView.mj_header endRefreshing];
  
    }];

    
}

-(void)addCollectionView{
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc] init];
    [flowL setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0,playerViewh, kScreen_Width,kScreen_Height/3*2)collectionViewLayout:flowL];
    self.collection.delegate =self;
    self.collection.dataSource =self;
    self.collection.backgroundColor =[UIColor whiteColor];
    self.collection.delaysContentTouches = true;
    
    
    
    [self.collection registerClass:[xiangguanCollectionViewCell class] forCellWithReuseIdentifier:@"xiangguan"];
    
    
    
    
    [self.scrollView addSubview: self.collection ];
   
}


//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return relevant.count;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    
        return CGSizeMake(kScreen_Width, 45);
  
    
    
}

//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    xiangguanCollectionViewCell  *Coursecell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"xiangguan" forIndexPath:indexPath];
    
    if (relevant) {
        if (relevant[indexPath.item].title) {
            Coursecell.titlename =relevant[indexPath.item].title;
        }
        
        
        
    }
    
    return Coursecell;
}


//设置点击 Cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
    
   
        NSLog(@"id %@",relevant[indexPath.row].id);
        
        if([DEFAULTS objectForKey:@"islogin"]){
            NSUserDefaults *defaults= DEFAULTS;
            
            [defaults removeObjectForKey:@"play_url"];
            [defaults synchronize];
            [defaults setObject:relevant[indexPath.row].id forKey:@"play_url"];
            
            
            [self presentViewController:[playerViewController new] animated:YES completion:nil];
        }else{
            
            [self presentViewController:[LoginViewController new] animated:YES completion:nil];
        }
        
       
    
}



-(void)initxiangguandata{
   
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    [parameterCountry setObject:courseId forKey:@"course_id"];
    
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:relevantCourse withParams:parameterCountry withMethodType:Get autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                if (relevant) {
                    [relevant removeAllObjects ];
                }
                relevant=[relevantCourseResponse mj_objectArrayWithKeyValuesArray:response.data];
                playerViewh=playerViewh+45*relevant.count;
                self.scrollView.contentSize=CGSizeMake(kScreen_Width, playerViewh);
                [self.collection  reloadData];
                
            }}
        
        [self.collection.mj_header endRefreshing];
        
    }];
}


- (void)onBackViewClickWithAliyunVodPlayerView:(AliyunVodPlayerView*)playerView{
    //点击播放器界面的返回按钮时触发，可以用来处理界面跳转
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)aliyunVodPlayerView:(AliyunVodPlayerView*)playerView onPause:(NSTimeInterval)currentPlayTime{
    //点击播放器界面的暂停按钮时触发，可以用来添加暂定时在界面上添加其他元素，如广告图片等
    
    NSLog(@"onPause");
}
- (void)aliyunVodPlayerView:(AliyunVodPlayerView*)playerView onResume:(NSTimeInterval)currentPlayTime{
    //点击播放界面的恢复按钮时触发，可以用来处理界面上额外添加的元素隐藏等功能
    
    
}
- (void)onFinishWithAliyunVodPlayerView:(AliyunVodPlayerView*)playerView{
    //播放完成事件，与stop不同，指视频正常播放完成。
     NSLog(@"onFinish");
}
- (void)aliyunVodPlayerView:(AliyunVodPlayerView*)playerView onStop:(NSTimeInterval)currentPlayTime{
    //播放器调用stop时触发
     NSLog(@"onStop");
}
- (void)aliyunVodPlayerView:(AliyunVodPlayerView*)playerView onSeekDone:(NSTimeInterval)seekDoneTime{
    //播放器Seek完成时触发，可以用来处理界面的UI元素变化
     NSLog(@"onSeekDone");
}
- (void)aliyunVodPlayerView:(AliyunVodPlayerView*)playerView lockScreen:(BOOL)isLockScreen{
    //点击界面的锁屏按钮时触发，用来和controller交互锁定事件
    
}
- (void)aliyunVodPlayerView:(AliyunVodPlayerView*)playerView onVideoQualityChanged:(AliyunVodPlayerVideoQuality)quality{
    //当清晰度改变后触发，可以用来处理清晰度发生变化时的UI提醒
    
}
- (void)aliyunVodPlayerView:(AliyunVodPlayerView *)playerView fullScreen:(BOOL)isFullScreen{
    //当出发全屏旋转后出发，用于配合ViewController来展示横屏全屏、竖屏全屏。
    NSLog(@"isFullScreen");
  
        if (isFullScreen) {
            
            self.rightChangeBtn.frame  = CGRectMake(kScreen_Width-10- self.rightChangeBtn.image.size.width, statusBar_Height+18,  self.rightChangeBtn.image.size.width,  self.rightChangeBtn.image.size.height);
        }else{
            
            self.rightChangeBtn.frame  = CGRectMake(kScreen_Width-10- self.rightChangeBtn.image.size.width- self.rightChangeBtn.image.size.width, statusBar_Height+18,  self.rightChangeBtn.image.size.width,  self.rightChangeBtn.image.size.height);
        }
    

    
}
- (void)onCircleStartWithVodPlayerView:(AliyunVodPlayerView *)playerView{
    //开启循环播放时，循环播放开始接收的事件。
    
}




@end
