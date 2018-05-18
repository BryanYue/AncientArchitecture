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
    
    self.teachername.frame = CGRectMake(0, self.teacherimageview.frame.size.height, 200, 30);
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
    
    self.teachernum.frame = CGRectMake(0, 260, 200, 40);
    [self.teachernum setImage:[UIImage imageNamed:@"icon_colloect_white"] forState:UIControlStateNormal];
    [self.teachernum setTitle: num forState:UIControlStateNormal];
    [self.teachernum setTitleColor:[UIColor_ColorChange whiteColor] forState:UIControlStateNormal];
    self.teachernum.titleLabel.font = [UIFont boldSystemFontOfSize:25];
    self.teachernum.backgroundColor=[UIColor grayColor];
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
    [self.teacherimageview sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:nil completed:^(UIImage *image, NSError *error,SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            NSLog(@"%@", error);
            [self.teacherimageview setImage:[UIImage imageNamed:@"tab_icon_me_nor"]];
        }
        
        
        
        
    }];
    
    
    [self addSubview:self.teacherimageview];
}

@end
