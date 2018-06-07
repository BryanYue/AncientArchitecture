//
//  AppDelegate.m
//  AncientArchitecture
//
//  Created by bryan on 2018/3/11.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "WXApi.h"
#import <AFNetworking.h>
#import "LaunchIntroductionView.h"
#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>
#import <Bugly/Bugly.h>
#define weixinloginNotification @"weixinlogin"
#define weixinpayNotification @"weixinpay"
@interface AppDelegate ()<WXApiDelegate>
    
    
    
@end

@implementation AppDelegate
    
    
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
   
    
    
   
    
    HomeViewController *home =[[HomeViewController alloc] init];
    self.window.rootViewController = home;
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    
    //初始化Bugly
    [Bugly startWithAppId:@"b698bd0225"];
    [WXApi registerApp:@"wx884bd8452e6e9112"];
    
    
    
    //启动基本SDK
    [[PgyManager sharedPgyManager] startManagerWithAppId:@"f5bc49c0c1f23243dddd6938c32f20d5"];
    //启动更新检查SDK
    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:@"f5bc49c0c1f23243dddd6938c32f20d5"];
    
    
    LaunchIntroductionView *launch=[LaunchIntroductionView sharedWithImages:@[@"img_launch_1",
                                               @"img_launch_2",
                                               @"img_launch_3",
                                               @"img_launch_4",
                                               @"img_launch_5"]
                                 buttonImage:@"login" buttonFrame:CGRectMake(kScreen_width/2 - 551/4, kScreen_height - 150, 551/2, 45)];
    launch.currentColor = [UIColor grayColor];
    launch.nomalColor = [UIColor_ColorChange colorWithHexString:app_theme];;
   
//   [SDImageCache sharedImageCache].config.maxCacheSize = 1024 * 1024 * 500;    // 50M
    
    return YES;
}


-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (self.allowRotation) {//如果设置了allowRotation属性，支持全屏
        return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskPortrait;//默认全局不支持横屏
}



-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
    {
        [WXApi handleOpenURL:url delegate:self];
        
        return YES;
    }
    
    
- (void)onResp:(BaseResp *)resp{
    // 向微信请求授权后,得到响应结果
    
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *aresp = (SendAuthResp *)resp;
        if(aresp.errCode== 0 && [aresp.state isEqualToString:@"App"])
        {
            NSString *code = aresp.code;
            [self getWeiXinOpenId:code];
        }
    }
   
    
    
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                // 这里别用返回的状态来确定是否正真支付成功了，这样是不对的，我们必须拿着存到本地的traderID去服务器再次check，这样和服务器收到的异步回调结果匹配之后才能确认是否真的已经支付成功了
               
                // 二次确认
             [[NSNotificationCenter defaultCenter] postNotificationName:weixinpayNotification object:self userInfo:@{@"weixinpay":[NSString stringWithFormat:@"%d", true]}];
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                 [[NSNotificationCenter defaultCenter] postNotificationName:weixinpayNotification object:self userInfo:@{@"weixinpay":[NSString stringWithFormat:@"%d", false]}];
                break;
        }
    }

}
    
    //通过code获取access_token，openid，unionid
- (void)getWeiXinOpenId:(NSString *)code{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WXPatient_App_ID,WXPatient_App_Secret,code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data){
                NSDictionary *accessDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSString *accessToken = [accessDict objectForKey:WX_ACCESS_TOKEN];
                NSString *openID = [accessDict objectForKey:WX_OPEN_ID];
                NSString *refreshToken = [accessDict objectForKey:WX_REFRESH_TOKEN];
                
                NSLog(@"请求access的accessToken = %@", accessToken);
                NSLog(@"请求access的openID = %@", openID);
                NSLog(@"请求access的refreshToken = %@", refreshToken);
                // 本地持久化，以便access_token的使用、刷新或者持续
                NSUserDefaults *defaults =DEFAULTS;
                [defaults setObject:accessToken forKey:@"WX_ACCESS_TOKEN"];
                [defaults setObject:openID forKey:@"WX_OPEN_ID"];
                [defaults setObject:refreshToken forKey:@"WX_REFRESH_TOKEN"];
                [defaults synchronize];
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:weixinloginNotification object:self userInfo:@{@"weixinLogin":[NSString stringWithFormat:@"%d", true]}];
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName:weixinloginNotification object:self userInfo:@{@"weixinLogin":[NSString stringWithFormat:@"%d", false]}];
            }
        });
    });
    
}
    
    
    
    
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}
    
    
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
    
    
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}
    
    
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
    
    
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
    
    
    @end
