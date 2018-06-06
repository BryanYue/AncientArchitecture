//
//  CustomCollectionViewCell.m
//  AncientArchitecture
//
//  Created by bryan on 2018/6/6.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *title =[[UIImageView alloc]init];
        title.image=[UIImage imageNamed:@"img_hom_hot_precourse"];
        title.frame = CGRectMake(30, 33, title.image.size.width, title.image.size.height);
        [self addSubview: title];
        
        
        UIButton *enterButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreen_Width-80,26, 60,40)];
        [enterButton setTitle:@"查看" forState:UIControlStateNormal];
        [enterButton setTitleColor:[UIColor_ColorChange colorWithHexString:@"952e3a"] forState:UIControlStateNormal];
        [enterButton.layer setBorderWidth:1.0];
        [enterButton.layer setBorderColor:[UIColor_ColorChange colorWithHexString:@"952e3a"].CGColor];
        enterButton.backgroundColor =[UIColor clearColor];
        enterButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [self  addSubview:enterButton];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


-(void)setTitle:(NSString *)title{
    
    if (!self.Customtitle) {
        self.Customtitle=[[UILabel alloc] init];
        self.Customtitle.userInteractionEnabled = YES;
    }
    self.Customtitle.frame = CGRectMake(70, 20, kScreen_Width-120, 30);
    self.Customtitle.textAlignment = NSTextAlignmentLeft;
    self.Customtitle.textColor = [UIColor blackColor];
     self.Customtime.font = [UIFont boldSystemFontOfSize:20];
    [self.Customtitle setText: title];
    [self addSubview:self.Customtitle];
}
-(void)setTime:(NSString *)time{
    if (!self.Customtime) {
        self.Customtime=[[UILabel alloc] init];
        self.Customtime.userInteractionEnabled = YES;
    }
    self.Customtime.frame = CGRectMake(70, 43, kScreen_Width-120, 30);
    self.Customtime.textAlignment = NSTextAlignmentLeft;
    self.Customtime.textColor = [UIColor grayColor];
    self.Customtime.font = [UIFont boldSystemFontOfSize:16];
    [self.Customtime setText: time];
    [self addSubview:self.Customtime];
}

@end
