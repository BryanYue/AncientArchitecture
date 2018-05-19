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


@interface playerViewController ()<AliyunVodPlayerViewDelegate>




@end

@implementation playerViewController



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
   self.playerView = [[AliyunVodPlayerView alloc] initWithFrame:CGRectMake(0,statusBar_Height, kScreen_Width, kScreen_Height/3) andSkin:AliyunVodPlayerViewSkinRed];
    //设置播放器代理
    [self.playerView setDelegate:self];
    //将播放器添加到需要展示的界面上
    [self.view addSubview:self.playerView];
    
    

//    [self addBackButton];
    [self addRightbutton:@"icon_colloect_white"];
    
    //网络视频，填写网络url地址
//    NSURL *url = [NSURL URLWithString:@"http://player.alicdn.com/video/aliyunmedia.mp4"];
     NSURL *urll = [NSURL URLWithString:@"rtmp://live.hkstv.hk.lxdns.com/live/hks"];
    //prepareToPlay:此方法传入的参数是NSURL类型.
  self.playerView.circlePlay = NO;
    
    
   [self.playerView playViewPrepareWithURL:urll];
//   [self.playerView setAutoPlay:YES];
    
    
   
}



-(void)addRightbutton:(NSString *)image{
    self.rightChangeBtn = [[UIImageView alloc] init];
     self.rightChangeBtn.image = [UIImage imageNamed:image];
     self.rightChangeBtn.frame  = CGRectMake(kScreen_Width-10- self.rightChangeBtn.image.size.width- self.rightChangeBtn.image.size.width, statusBar_Height+18,  self.rightChangeBtn.image.size.width,  self.rightChangeBtn.image.size.height);

    self.rightChangeBtn.userInteractionEnabled = YES;
    [self.rightChangeBtn addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightButtonPress)]];
    [self.view addSubview: self.rightChangeBtn];
    
}

-(void)rightButtonPress{
    NSLog(@"rightButtonPress");
}




-(void)initdata{
    
    NSUserDefaults *defaults= DEFAULTS;
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    [parameterCountry setObject:[defaults objectForKey:@"play_url"] forKey:@"course_id"];
    [parameterCountry setObject:[defaults objectForKey:@"memberid"] forKey:@"memberid"];
    
    
//    NSString *pathWithPhoneNum = [NSString stringWithFormat:@"%@?course_id=%@&token=%@",url_allCourse,@"2",@(jji)];
   
    [self GeneralButtonAction];
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_getCourseDetail withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                
                CourseDetailResponse *detailResponse =[CourseDetailResponse mj_objectWithKeyValues:response.data];
              
                
                
            }else{
                
            }
            
            if (self.HUD) {
                [self.HUD hideAnimated:true];
            }
            [self TextButtonAction:response.msg];
            
        }else{
            
        }
        
    
          [self showAction:@"该课程失效，无法直播"];
  
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
            self.rightChangeBtn.frame  = CGRectMake(kScreen_Width-10- self.rightChangeBtn.image.size.width- self.rightChangeBtn.image.size.width, statusBar_Height+18,  self.rightChangeBtn.image.size.width,  self.rightChangeBtn.image.size.height);
        }else{
            self.rightChangeBtn.frame  = CGRectMake(kScreen_Width-10- self.rightChangeBtn.image.size.width- self.rightChangeBtn.image.size.width, statusBar_Height+18,  self.rightChangeBtn.image.size.width,  self.rightChangeBtn.image.size.height);
        }
    

    
}
- (void)onCircleStartWithVodPlayerView:(AliyunVodPlayerView *)playerView{
    //开启循环播放时，循环播放开始接收的事件。
    
}




@end
