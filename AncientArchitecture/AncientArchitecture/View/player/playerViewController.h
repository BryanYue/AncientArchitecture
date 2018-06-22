//
//  playerViewController.h
//  AncientArchitecture
//
//  Created by bryan on 2018/5/13.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "BaseViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AliyunVodPlayerViewSDK/AliyunVodPlayerView.h>


@interface playerViewController : BaseViewController
@property (weak, nonatomic) AliyunVodPlayerView  * playerView;
@property (weak, nonatomic) UIImageView  * uiimage;
@property (nonatomic,strong) UIImageView   *rightimmm;
@property (nonatomic,strong) UIView     *uiview;
@property (nonatomic,strong) UIScrollView * scrollView;

@property(nonatomic,strong)UICollectionView *collection;
@end
