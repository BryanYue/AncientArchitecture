//
//  startLiveViewController.h
//  AncientArchitecture
//
//  Created by bryan on 2018/3/24.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "BaseViewController.h"
#import <AlivcLivePusher/AlivcLivePusherHeader.h>


@interface startLiveViewController : BaseViewController

@property (nonatomic, strong) AlivcLivePusher *livePusher;
@property (nonatomic, strong) AlivcLivePushConfig *pushConfig;
@property (nonatomic, strong) UIView *previewView;


@end
