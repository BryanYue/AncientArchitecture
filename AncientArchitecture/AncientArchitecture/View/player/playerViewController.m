//
//  playerViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/13.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "playerViewController.h"
#import <AliyunPlayerSDK/AlivcMediaPlayer.h>


@interface playerViewController ()<UIAlertViewDelegate>


@end

@implementation playerViewController
NSString *URLSTRING;
NSString *kReachabilityChangedNotification = @"kNetworkReachabilityChangedNotification";
AliVcMediaPlayer* mediaPlayer;
UIView *contentView;


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




-(void)initview{
    contentView =[[UIView alloc] init];
    contentView.frame =CGRectMake(0, statusBar_Height, kScreen_Width,kScreen_Height/3 );
    //创建播放器
    mediaPlayer = [[AliVcMediaPlayer alloc] init];
    //创建播放器视图，其中contentView为UIView实例，自己根据业务需求创建一个视图即可
    /*self.mediaPlayer:NSObject类型，需要UIView来展示播放界面。
     self.contentView：承载mediaPlayer图像的UIView类。
     self.contentView = [[UIView alloc] init];
     [self.view addSubview:self.contentView];
     */
    
    [mediaPlayer create:contentView];
    
    
    [self.view addSubview:contentView];
    
    [self initbaseView];
    [self addBackButton];
    //设置播放类型，0为点播、1为直播，默认使用自动
    mediaPlayer.mediaType = MediaType_AUTO;
    //设置超时时间，单位为毫秒
    mediaPlayer.timeout = 25000;
    //缓冲区超过设置值时开始丢帧，单位为毫秒。直播时设置，点播设置无效。范围：500～100000
    mediaPlayer.dropBufferDuration = 8000;
    mediaPlayer.circlePlay = YES;
    
    //通知
    [self addPlayerObserver];
    
    //网络视频，填写网络url地址
    NSURL *url = [NSURL URLWithString:@"http://player.alicdn.com/video/aliyunmedia.mp4"];
    //prepareToPlay:此方法传入的参数是NSURL类型.
    AliVcMovieErrorCode err = [mediaPlayer prepareToPlay:url];
     NSLog(@"play error code is %d",(int)err);
    
    [mediaPlayer play];
    
}


#pragma mark - receive
 //一、播放器初始化视频文件完成通知，调用prepareToPlay函数，会发送该通知，代表视频文件已经准备完成，此时可以在这个通知中获取到视频的相关信息，如视频分辨率，视频时长等
- (void)OnVideoPrepared:(NSNotification *)notification{
//    self.isRunTime = YES;
    NSInteger duration = mediaPlayer.duration/1000;
    if (duration <= 0) {
        duration = 0;
    }else{
        duration = (mediaPlayer.duration+500)/1000;
    }
    
//    self.progressSlider.maximumValue = duration;
    
    if (mediaPlayer.currentPosition <= 0) {
//        self.progressSlider.value = 0;
    }else{
//        self.progressSlider.value = (self.mediaPlayer.currentPosition+500)/1000;
    }
    
//    self.rightTimeLabel.text = [self getMMSSFromSS:[NSString stringWithFormat:@"%f",duration*1000.0f]];
    
//    [self.showMessageView addTextString:NSLocalizedString(@"onVideoPrepared",nil)];
}





- (void)OnVideoFinish:(NSNotification *)notification{
    [self TextButtonAction: @"OnVideoFinish"];
    
}
//四、播放器Seek完成后发送该通知。
- (void)OnSeekDone:(NSNotification *)notification{
//    self.isRunTime = YES;
   [self TextButtonAction: @"OnSeekDone"];
    
}
//五、播放器开始缓冲视频时发送该通知，当播放网络文件时，网络状态不佳或者调用seekTo时，此通知告诉用户网络下载数据已经开始缓冲。
- (void)OnStartCache:(NSNotification *)notification{
   [self TextButtonAction: @"OnStartCache"];
    
}
//六、播放器结束缓冲视频时发送该通知，当数据已经缓冲完，告诉用户已经缓冲结束，来更新相关UI显示。
- (void)OnEndCache:(NSNotification *)notification{
   [self TextButtonAction: @"OnEndCache"];
    
}
//七、播放器主动调用Stop功能时触发。
- (void)onVideoStop:(NSNotification *)notification{
  [self TextButtonAction: @"onVideoStop"];
    
}
//九、播放器开启循环播放功能，开始循环播放时发送的通知。
- (void)onCircleStart:(NSNotification *)notification{
   [self TextButtonAction: @"OnVideoFinish"];
}

  //八、播放器状态首帧显示后发送的通知。
- (void)onVideoFirstFrame :(NSNotification *)notification{
    [self TextButtonAction: @"onVideoFirstFrame"];
    
}

- (void)OnVideoError:(NSNotification *)notification{
    NSDictionary* userInfo = [notification userInfo];
    NSString* errorMsg = [userInfo objectForKey:@"errorMsg"];
    NSNumber* errorCodeNumber = [userInfo objectForKey:@"error"];
    NSLog(@"%@-%@",errorMsg,errorCodeNumber);
    [self TextButtonAction:errorMsg];
   
}


#pragma mark - add NSNotification
-(void)addPlayerObserver
{
    //一、播放器初始化视频文件完成通知，调用prepareToPlay函数，会发送该通知，代表视频文件已经准备完成，此时可以在这个通知中获取到视频的相关信息，如视频分辨率，视频时长等
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OnVideoPrepared:)
                                                 name:AliVcMediaPlayerLoadDidPreparedNotification object:mediaPlayer];
    //二、播放完成通知。视频正常播放完成时触发。
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OnVideoFinish:)
                                                 name:AliVcMediaPlayerPlaybackDidFinishNotification object:mediaPlayer];
    //三、播放器播放失败发送该通知，并在该通知中可以获取到错误码。
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OnVideoError:)
                                                 name:AliVcMediaPlayerPlaybackErrorNotification object:mediaPlayer];
    //四、播放器Seek完成后发送该通知。
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OnSeekDone:)
                                                 name:AliVcMediaPlayerSeekingDidFinishNotification object:mediaPlayer];
    //五、播放器开始缓冲视频时发送该通知，当播放网络文件时，网络状态不佳或者调用seekTo时，此通知告诉用户网络下载数据已经开始缓冲。
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OnStartCache:)
                                                 name:AliVcMediaPlayerStartCachingNotification object:mediaPlayer];
    //六、播放器结束缓冲视频时发送该通知，当数据已经缓冲完，告诉用户已经缓冲结束，来更新相关UI显示。
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OnEndCache:)
                                                 name:AliVcMediaPlayerEndCachingNotification object:mediaPlayer];
    //七、播放器主动调用Stop功能时触发。
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onVideoStop:)
                                                 name:AliVcMediaPlayerPlaybackStopNotification object:mediaPlayer];
    //八、播放器状态首帧显示后发送的通知。
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onVideoFirstFrame:)
                                                 name:AliVcMediaPlayerFirstFrameNotification object:mediaPlayer];
    //九、播放器开启循环播放功能，开始循环播放时发送的通知。
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onCircleStart:)
                                                 name:AliVcMediaPlayerCircleStartNotification object:mediaPlayer];
//    //十、直播答题接收的SEI数据消息，收到SEI通知后就可以展示SEI对应的题目了。
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(onSeiData:)
//                                                 name:AliVcMediaPlayerSeiDataNotification object:self.mediaPlayer];
    
    
    
}

#pragma mark - remove NSNotification
-(void)removePlayerObserver
{
   
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AliVcMediaPlayerLoadDidPreparedNotification object:mediaPlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AliVcMediaPlayerPlaybackErrorNotification object:mediaPlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AliVcMediaPlayerPlaybackDidFinishNotification object:mediaPlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AliVcMediaPlayerSeekingDidFinishNotification object:mediaPlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AliVcMediaPlayerStartCachingNotification object:mediaPlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AliVcMediaPlayerEndCachingNotification object:mediaPlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AliVcMediaPlayerPlaybackStopNotification object:mediaPlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AliVcMediaPlayerFirstFrameNotification object:mediaPlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AliVcMediaPlayerCircleStartNotification object:mediaPlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}





@end
