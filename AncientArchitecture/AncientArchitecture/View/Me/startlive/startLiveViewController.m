//
//  startLiveViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/3/24.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "startLiveViewController.h"
#import "CourseDetailResponse.h"

#define kAlivcLivePusherVCAlertTag 89976

@interface startLiveViewController ()<AlivcLivePusherNetworkDelegate,AlivcLivePusherErrorDelegate,AlivcLivePusherInfoDelegate,AlivcLivePusherBGMDelegate>
@end

@implementation startLiveViewController
NSString *pushurl;
bool ispushing=false;

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
    self.view.backgroundColor=[UIColor whiteColor];
    [self addBackButton];
    [self.topTitleLabel setText:@"直播课程"];
    [self addRightbuttonWithTitle:@"camera_id"];
    
    if (!_viewstartpause) {
        _viewstartpause = [[UIImageView alloc] init];
        _viewstartpause.frame=CGRectMake((kScreen_Width- 50)/2, kScreen_Height-100, 50,50 );

    }
   
   
    
}


-(void)rightButtonPress
{
   [self.livePusher switchCamera];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    NSUserDefaults *defaults= DEFAULTS;
    
    NSString *push_id=[defaults objectForKey:@"push_id"];
    
    if (push_id) {
        NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
        
        [parameterCountry setObject:push_id forKey:@"course_id"];
        [parameterCountry setObject:[defaults objectForKey:@"memberid"] forKey:@"memberid"];
        [self GeneralButtonAction];
        [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_getCourseDetail withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
            NSLog(@"error%zd",error.code);
            if (!error) {
                BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
                if (response.code  == 200) {
               
                    CourseDetailResponse *detailResponse =[CourseDetailResponse mj_objectWithKeyValues:response.data];
                    pushurl= detailResponse.push_vedio_url;
                    
                    if (pushurl) {
                        if (!self.previewView) {
                            _previewView =[[UIView alloc] init];
                            _previewView.backgroundColor=[UIColor clearColor];
                            _previewView.frame=CGRectMake(0, self.topView.frame.size.height, kScreen_Width,kScreen_Height-self.topView.frame.size.height );
                           
                            [self.view addSubview:_previewView];
                            [self.view addSubview:_viewstartpause];
                            _viewstartpause.userInteractionEnabled = YES;
                            [_viewstartpause addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toMessage)]];
                        }
                        
                        [self initconfing];
                        [self initpusher];
                    }else{
                        [self showAction:@"该课程数据为空，无法直播"];
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
    }else{
        [self showAction:@"该课程失效，无法直播"];
    }
    
    
    
    
    
   
    
    
    
    
    
    
    
    
    
    
   
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [self destoryPusher];
}


- (void)dealloc{
    [self destoryPusher];
}




-(void)initconfing
{
    if (!self.pushConfig) {
        self.pushConfig = [[AlivcLivePushConfig alloc] init];
        self.pushConfig.resolution = AlivcLivePushResolution540P;//默认为540P，最大支持720P，兼容V1.3.0版1080P
        self.pushConfig.fps = AlivcLivePushFPS20; //建议用户使用20fps
        self.pushConfig.qualityMode = AlivcLivePushQualityModeFluencyFirst;
        self.pushConfig.videoEncodeGop = AlivcLivePushVideoEncodeGOP_2;//默认值为2
        self.pushConfig.connectRetryInterval = 2000; // 单位为毫秒，重连时长2s
        self.pushConfig.previewMirror = false; // 关闭预览镜像
        self.pushConfig.orientation = AlivcLivePushOrientationPortrait; // Left横屏推流
        self.pushConfig.beautyOn=false;
        [self.livePusher setAudioDenoise:true];// 降噪打开
        [self.livePusher setBGMEarsBack:true];// 打开耳返
        [self.livePusher setCaptureVolume:50];;// 设置人声采集音量为50
    }
    
}

-(void)initpusher
{
    if (!self.livePusher) {
         self.livePusher = [[AlivcLivePusher alloc] initWithConfig:self.pushConfig];
        [self.livePusher setInfoDelegate:self];
        [self.livePusher setErrorDelegate:self];
        [self.livePusher setNetworkDelegate:self];
         [self.livePusher setBGMDelegate:self];
        
        [self.livePusher startPreviewAsync:_previewView];
    }else{
        [self restartPush];
    }
   
    
   
   
    
    
}


/**
 开始预览
 */
- (int)startPreview {
    
    if (!self.livePusher) {
        return -1;
    }
    int ret = 0;
  
        // 使用异步接口
    ret = [self.livePusher startPreviewAsync:self.previewView];
        
  
    return ret;
}


/**
 停止预览
 */
- (int)stopPreview {
    
    if (!self.livePusher) {
        return -1;
    }
    int ret = [self.livePusher stopPreview];
    return ret;
}


/**
 渲染第一帧回调
 
 @param pusher 推流AlivcLivePusher
 */
- (void)onFirstFramePreviewed:(AlivcLivePusher *)pusher{
     NSLog(@"onFirstFramePreviewed:" );
    dispatch_sync(dispatch_get_main_queue(), ^{
        /* Do UI work here */
        [self.topTitleLabel setText:@"直播课程(推流渲染完成)"];
    });
   
}


/**
 推流开始回调
 
 @param pusher 推流AlivcLivePusher
 */
- (void)onPushStarted:(AlivcLivePusher *)pusher{
    NSLog(@"onPushStarted:" );
    dispatch_sync(dispatch_get_main_queue(), ^{
        /* Do UI work here */
         [self.topTitleLabel setText:@"直播课程(正在推流)"];
        ispushing=true;
        _viewstartpause.image = [UIImage imageNamed:@"img_video_btn_pause"];
        
    });
    
}


/**
 推流暂停回调
 
 @param pusher 推流AlivcLivePusher
 */
- (void)onPushPauesed:(AlivcLivePusher *)pusher{
    NSLog(@"onPushPauesed:" );
    dispatch_sync(dispatch_get_main_queue(), ^{
        /* Do UI work here */
       [self.topTitleLabel setText:@"直播课程(推流暂停)"];
         ispushing=false;
         _viewstartpause.image = [UIImage imageNamed:@"img_video_btn_record"];
    });
    
}


/**
 推流恢复回调
 
 @param pusher 推流AlivcLivePusher
 */
- (void)onPushResumed:(AlivcLivePusher *)pusher{
    NSLog(@"onPushResumed:" );
    dispatch_sync(dispatch_get_main_queue(), ^{
        /* Do UI work here */
       [self.topTitleLabel setText:@"直播课程(推流恢复)"];
        ispushing=true;
         _viewstartpause.image = [UIImage imageNamed:@"img_video_btn_pause"];
    });
    
}


/**
 重新推流回调
 
 @param pusher 推流AlivcLivePusher
 */
- (void)onPushRestart:(AlivcLivePusher *)pusher{
     NSLog(@"onPushRestart:" );
    [self.topTitleLabel setText:@"直播课程(重新推流)"];
    ispushing=true;
    _viewstartpause.image = [UIImage imageNamed:@"img_video_btn_pause"];
}


-(void)toMessage{
  
    if (self.livePusher) {
        if (ispushing) {
            [self.livePusher pause];
        }else{
            [self.livePusher resumeAsync];
        }
    }
}



/**
 推流停止回调
 
 @param pusher 推流AlivcLivePusher
 */
- (void)onPushStoped:(AlivcLivePusher *)pusher{
     NSLog(@"onPushStoped:" );
    dispatch_sync(dispatch_get_main_queue(), ^{
        /* Do UI work here */
        [self.topTitleLabel setText:@"直播课程(推流停止)"];
    });
    
}






/**
 系统错误回调
 
 @param pusher 推流AlivcLivePusher
 @param error error
 */
-(void)onSystemError:(AlivcLivePusher *)pusher error:(AlivcLivePushError *)error
{
    [self showAlertViewWithErrorCode:error.errorCode
                            errorStr:error.errorDescription
                                 tag:kAlivcLivePusherVCAlertTag+11
                               title:NSLocalizedString(@"dialog_title", nil)
                             message:NSLocalizedString(@"system_error", nil)
                            delegate:self
                         cancelTitle:NSLocalizedString(@"exit", nil)
                   otherButtonTitles:NSLocalizedString(@"ok", nil),nil];
}

/**
 SDK错误回调
 
 @param pusher 推流AlivcLivePusher
 @param error error
 */
- (void)onSDKError:(AlivcLivePusher *)pusher error:(AlivcLivePushError *)error
{

    [self showAlertViewWithErrorCode:error.errorCode
                            errorStr:error.errorDescription
                                 tag:kAlivcLivePusherVCAlertTag+12
                               title:NSLocalizedString(@"dialog_title", nil)
                             message:NSLocalizedString(@"sdk_error", nil)
                            delegate:self
                         cancelTitle:NSLocalizedString(@"exit", nil)
                   otherButtonTitles:NSLocalizedString(@"ok", nil),nil];
}


-(void)onConnectFail:(AlivcLivePusher *)pusher error:(AlivcLivePushError *)error
{
    
    [self showAlertViewWithErrorCode:error.errorCode
                            errorStr:error.errorDescription
                                 tag:kAlivcLivePusherVCAlertTag+23
                               title:NSLocalizedString(@"dialog_title", nil)
                             message:NSLocalizedString(@"connect_fail", nil)
                            delegate:self
                         cancelTitle:NSLocalizedString(@"reconnect_button", nil)
                   otherButtonTitles:NSLocalizedString(@"exit", nil), nil];
    
    
}


- (void)onSendDataTimeout:(AlivcLivePusher *)pusher
{
    [self showAlertViewWithErrorCode:0
                            errorStr:nil
                                 tag:0
                               title:NSLocalizedString(@"dialog_title", nil)
                             message:NSLocalizedString(@"senddata_timeout", nil)
                            delegate:nil
                         cancelTitle:NSLocalizedString(@"ok", nil)
                   otherButtonTitles:nil];
    
}



- (void)onSendSeiMessage:(AlivcLivePusher *)pusher
{
    
    
}







/**
 网络差回调
 @param pusher 推流AlivcLivePusher
 */
-(void)onNetworkPoor:(AlivcLivePusher *)pusher
{
    
}




- (void)onPreviewStoped:(AlivcLivePusher *)pusher
{
    
}

-(void)onPreviewStarted:(AlivcLivePusher *)pusher
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        /* Do UI work here */
        [self.topTitleLabel setText:@"直播课程(推流正在初始化)"];
    });
   

 NSLog(@"push_url:%@",pushurl );
 [_livePusher startPushWithURLAsync:pushurl ];
 

}






/**
 停止推流
 */
- (int)stopPush {
    
    if (!_livePusher) {
        return -1;
    }
    
    int ret = [_livePusher stopPush];
    return ret;
}



/**
 暂停推流
 */
- (int)pausePush {
    
    if (!_livePusher) {
        return -1;
    }
    
    int ret = [_livePusher pause];
    return ret;
}


/**
 恢复推流
 */
- (int)resumePush {
    
    if (!_livePusher) {
        return -1;
    }
    
    int ret = 0;
    
  
        // 使用异步接口
        ret = [_livePusher resumeAsync];
        
  
    return ret;
}



/**
 重新推流
 */
- (int)restartPush {
    
    if (!_livePusher) {
        return -1;
    }
    
    int ret = 0;
   
        // 使用异步接口
        ret = [_livePusher restartPushAsync];
        
  
    return ret;
}



/**
 销毁推流
 */
- (void)destoryPusher {
    if (self.livePusher) {
        [self stopPreview];
        [self stopPush];
        [self.livePusher destory];
    }
    self.pushConfig = nil;
    self.livePusher = nil;
    self.previewView = nil;
}



- (void)showAlertViewWithErrorCode:(NSInteger)errorCode errorStr:(NSString *)errorStr tag:(NSInteger)tag title:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelTitle:(NSString *)cancel otherButtonTitles:(NSString *)otherTitles, ... {
    
    if (errorCode == ALIVC_LIVE_PUSHER_PARAM_ERROR) {
        errorStr = @"接口输入参数错误";
    }
    
    if (errorCode == ALIVC_LIVE_PUSHER_SEQUENCE_ERROR) {
        errorStr = @"接口调用顺序错误";
    }
    
    NSString *showMessage = [NSString stringWithFormat:@"%@: code:%lx message:%@", message, errorCode, errorStr];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:showMessage delegate:delegate cancelButtonTitle:cancel otherButtonTitles: otherTitles,nil];
        if (tag) {
            alert.tag = tag;
        }
        [alert show];
    });
}


@end
