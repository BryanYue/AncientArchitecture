//
//  TeacherUICollectionViewCell.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/13.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "TeacherUICollectionViewCell.h"

@implementation TeacherUICollectionViewCell


- (void)setHeadimageName:(NSString *)headimageName
{
    if (!self.headimageview) {
        self.headimageview=[UIImageView new];
        self.headimageview.userInteractionEnabled = YES;
    }
    self.headimageview.frame=CGRectMake(10,50,kScreen_Width/3,kScreen_Width/3 );
    [self.headimageview setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.headimageview.contentMode =  UIViewContentModeScaleAspectFill;
    self.headimageview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.headimageview.clipsToBounds  = YES;
    [self.headimageview sd_setImageWithURL:[NSURL URLWithString:headimageName] placeholderImage:nil completed:^(UIImage *image, NSError *error,SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            NSLog(@"%@", error);
            [self.headimageview setImage:[UIImage imageNamed:@"tab_icon_me_nor"]];
        }
        self.headimageview.layer.cornerRadius=self.headimageview.frame.size.width/2;//裁成圆角
        self.headimageview.layer.masksToBounds=YES;//隐藏裁剪掉的部分
        
        
        
    }];
    
    
    [self addSubview:self.headimageview];
}


- (void)setTeachername:(NSString *)teachername
{
    if (!self.teacherLbl) {
        self.teacherLbl=[[UILabel alloc] init];
        self.teacherLbl.userInteractionEnabled = YES;
    }
    
    self.teacherLbl.frame = CGRectMake(kScreen_Width/3+20, 25, kScreen_Width/3*2-10, 30);
    self.teacherLbl.textAlignment = NSTextAlignmentLeft;
    self.teacherLbl.textColor = [UIColor blackColor];
   
    [self.teacherLbl setText: teachername];
    [self addSubview:self.teacherLbl];
}

- (void)setTitlename:(NSString *)titlename
{
    if (!self.titleLbl) {
        self.titleLbl=[[UILabel alloc] init];
        self.titleLbl.userInteractionEnabled = YES;
    }
    self.titleLbl.frame = CGRectMake(kScreen_Width/3+20, 85, kScreen_Width/3*2-10, 30);
    self.titleLbl.textAlignment = NSTextAlignmentLeft;
    self.titleLbl.textColor = [UIColor grayColor];
     NSString *s =[NSString stringWithFormat:@"主讲课程: %@",titlename];
    [self.titleLbl setText:s];
    [self addSubview:self.titleLbl];
}




- (void)setTimename:(NSString *)timename
{
    if (!self.timeLbl) {
        self.timeLbl=[[UILabel alloc] init];
        self.timeLbl.userInteractionEnabled = YES;
    }
    self.timeLbl.frame = CGRectMake(kScreen_Width/3+20, 114, kScreen_Width/3*2-10, 30);
    self.timeLbl.textAlignment = NSTextAlignmentLeft;
    self.timeLbl.textColor = [UIColor grayColor];
    NSString *s =[NSString stringWithFormat:@"从业时间: %@",timename];
    [self.timeLbl setText: s];
    [self addSubview:self.timeLbl];
    
}


- (void)setImageName:(NSString *)imageName
{
    if (!self.imageview) {
        self.imageview=[[UILabel alloc] init];
        self.imageview.userInteractionEnabled = YES;
    }
    self.imageview.frame = CGRectMake(kScreen_Width/3+20, 145, kScreen_Width/3*2-10, 30);
    self.imageview.textAlignment = NSTextAlignmentLeft;
    self.imageview.textColor = [UIColor grayColor];
    NSString *s =[NSString stringWithFormat:@"讲师格言: %@",imageName];
    [self.imageview setText: s];
    [self addSubview:self.imageview];
}

@end
