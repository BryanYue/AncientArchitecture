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

#define weixinloginNotification @"weixinlogin"

@interface AppDelegate ()<WXApiDelegate>
    
    
    
@end

@implementation AppDelegate
    
    
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];
    
    
   
    
    HomeViewController *home =[[HomeViewController alloc] init];
    
    self.window.rootViewController = home;
    // Override point for customization after application launch.
    
    //初始化Bugly
    [Bugly startWithAppId:@"b698bd0225"];
    [WXApi registerApp:@"wx884bd8452e6e9112"];
    return YES;
}
    
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
    {
        [WXApi handleOpenURL:url delegate:self];
        
        return YES;
    }
    
    
- (void)onResp:(BaseResp *)resp{
    // 向微信请求授权后,得到响应结果
    
    SendAuthResp *aresp = (SendAuthResp *)resp;
    if(aresp.errCode== 0 && [aresp.state isEqualToString:@"App"])
    {
        NSString *code = aresp.code;
        [self getWeiXinOpenId:code];
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
