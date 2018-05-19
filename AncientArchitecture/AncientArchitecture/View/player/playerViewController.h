//
//  playerViewController.h
//  AncientArchitecture
//
//  Created by bryan on 2018/5/13.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "BaseViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AliyunPlayerSDK/AliyunPlayerSDK.h>
#import <AliyunVodPlayerViewSDK/AliyunVodPlayerViewSDK.h>

@interface playerViewController : BaseViewController
@property (nonatomic, strong) AliyunVodPlayerView  * playerView;

@property (nonatomic,strong) UIImageView     *rightChangeBtn;
@end
