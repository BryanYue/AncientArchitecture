//
//  BaseViewController.h
//  AncientArchitecture
//
//  Created by bryan on 2018/3/18.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

@interface BaseViewController : UIViewController

@property (nonatomic,strong)    UILabel  *topTitleLabel;
@property (nonatomic,strong)    UIView   *topView;       //顶部的view
@property (retain,nonatomic)UIButton     *backButton;
// 设置右边的按钮
@property (retain,nonatomic)UIButton     *rightChangeBtn;

//-(void)isSkidSideway;//是否侧滑返回 0不侧滑   1侧滑
//导航按钮
-(void)addBackButton;//返回按钮戴尖头图片

-(void)initbaseView;
@property (nonatomic,strong)MBProgressHUD  *HUD;

-(void)GeneralButtonAction;
-(void)TextButtonAction:(NSString *)string;


-(void)showAction:(NSString *)string;
-(void)showUITextFieldAction:(NSString *)string;
-(void)Alertdo:(NSString *)string;

-(void)dimissAlert:(NSTimer *)timer;

-(void)rightButtonPress;
-(void)addRightbuttonWithTitle:(NSString *)string;
@end
