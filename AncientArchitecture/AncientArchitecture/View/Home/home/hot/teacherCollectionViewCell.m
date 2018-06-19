//
//  teacherCollectionViewCell.m
//  AncientArchitecture
//
//  Created by Bryan on 2018/5/18.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "teacherCollectionViewCell.h"

@implementation teacherCollectionViewCell

- (void)setName:(NSString *)name
{
    if (!self.teachername) {
        self.teachername=[[UILabel alloc] init];
        self.teachername.userInteractionEnabled = YES;
    }
    
    self.teachername.frame = CGRectMake(0, 168, 100, 30);
    self.teachername.textAlignment = NSTextAlignmentCenter;
    self.teachername.textColor = [UIColor blackColor];
    
    [self.teachername setText: name];
    [self addSubview:self.teachername];
}

- (void)setNum:(NSString *)num
{
    if (!self.teachernum) {
        self.teachernum=[[UIButton alloc] init];
        self.teachernum.userInteractionEnabled = YES;
    }
    
    self.teachernum.frame = CGRectMake(0, 220, 200, 40);
    [self.teachernum setImage:[UIImage imageNamed:@"icon_colloect_white"] forState:UIControlStateNormal];
    [self.teachernum setTitle: num forState:UIControlStateNormal];
    [self.teachernum setTitleColor:[UIColor_ColorChange whiteColor] forState:UIControlStateNormal];
    self.teachernum.titleLabel.font = [UIFont systemFontOfSize:25];
    self.teachernum.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    self.teachernum.imageEdgeInsets = UIEdgeInsetsMake(0,-20,0,0);
    [self addSubview:self.teachernum];
}



-(void)setImageName:(NSString *)imageName{
    
    if (!self.teacherimageview) {
        self.teacherimageview=[[UIImageView alloc] init];
        self.teacherimageview.userInteractionEnabled = YES;
    }
    self.teacherimageview.frame=CGRectMake(0,0,200,260 );
    [self.teacherimageview setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.teacherimageview.contentMode =  UIViewContentModeScaleAspectFill;
    self.teacherimageview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.teacherimageview.clipsToBounds  = YES;
    
    
    [self.teacherimageview yy_setImageWithURL:[NSURL URLWithString:imageName]
                           placeholder:nil
                               options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation
                              progress:nil
                             transform:^UIImage *(UIImage *image, NSURL *url) {
//                                 image = [image yy_imageByResizeToSize:CGSizeMake(200, 260) contentMode:UIViewContentModeScaleToFill];
                                 //                            return [image yy_imageByRoundCornerRadius:10];
                                 return  image;
                             }
                            completion:nil];
    
    
    
    
    
    
    [self addSubview:self.teacherimageview];
}

@end
