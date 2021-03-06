//
//  TeacheCourseViewCollectionViewCell.m
//  AncientArchitecture
//
//  Created by bryan on 2018/4/10.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "TeacheCourseViewCollectionViewCell.h"

@implementation TeacheCourseViewCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setImageName:(NSString *)imageName
{
    
    if (!self.imageview) {
        self.imageview=[UIImageView new];
        self.imageview.userInteractionEnabled = YES;
    }
    self.imageview.frame=CGRectMake(10, 25,kScreen_Width-20,177 );
    [self.imageview setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.imageview.contentMode =  UIViewContentModeScaleAspectFill;
    self.imageview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.imageview.clipsToBounds  = YES;
 
    [self.imageview yy_setImageWithURL:[NSURL URLWithString:imageName]
                                  placeholder:nil
                                      options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation
                                     progress:nil
                                    transform:^UIImage *(UIImage *image, NSURL *url) {
                                        image = [image yy_imageByResizeToSize:CGSizeMake(kScreen_Width-20, 177) contentMode:UIViewContentModeScaleToFill];
                                        //                            return [image yy_imageByRoundCornerRadius:10];
                                        return  image;
                                    }
                                   completion:nil];
    
    [self addSubview:self.imageview];
}


- (void)setHeadimageName:(NSString *)headimageName
{
    if (!self.headimageview) {
        self.headimageview=[UIImageView new];
        self.headimageview.userInteractionEnabled = YES;
    }
    self.headimageview.frame=CGRectMake(10,222,30,30 );
    [self.headimageview setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.headimageview.contentMode =  UIViewContentModeScaleAspectFill;
    self.headimageview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.headimageview.clipsToBounds  = YES;

    
    [self.headimageview yy_setImageWithURL:[NSURL URLWithString:headimageName]
                                  placeholder:nil
                                      options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation
                                     progress:nil
                                    transform:^UIImage *(UIImage *image, NSURL *url) {
                                        image = [image yy_imageByResizeToSize:CGSizeMake(30, 30) contentMode:UIViewContentModeScaleToFill];
                                        //                            return [image yy_imageByRoundCornerRadius:10];
                                        return  image;
                                    }
                                     completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
                                         self.headimageview.layer.cornerRadius=self.headimageview.frame.size.width/2;//裁成圆角
                                         self.headimageview.layer.masksToBounds=YES;//隐藏裁剪掉的部分
                                }];
    
    [self addSubview:self.headimageview];
}


- (void)setTimename:(NSString *)timename
{
    if (!self.timeLbl) {
        self.timeLbl=[[UILabel alloc] init];
        self.timeLbl.userInteractionEnabled = YES;
    }
    self.timeLbl.frame = CGRectMake(kScreen_Width/2-10, 240, kScreen_Width /2, 20);
    self.timeLbl.textAlignment = NSTextAlignmentRight;
    self.timeLbl.font = [UIFont systemFontOfSize:12];
    self.timeLbl.textColor = [UIColor grayColor];
    [self.timeLbl setText: timename];
    [self addSubview:self.timeLbl];
    
}


- (void)setTitlename:(NSString *)titlename
{
    if (!self.titleLbl) {
        self.titleLbl=[[UILabel alloc] init];
        self.titleLbl.userInteractionEnabled = YES;
    }
    self.titleLbl.frame = CGRectMake(kScreen_Width/2-10, 215, kScreen_Width /2, 20);
    self.titleLbl.textAlignment = NSTextAlignmentRight;
    self.titleLbl.font = [UIFont systemFontOfSize:15];
    self.titleLbl.textColor = [UIColor blackColor];
    [self.titleLbl setText:titlename];
    [self addSubview:self.titleLbl];
}

- (void)setTeachername:(NSString *)teachername
{
    if (!self.teacherLbl) {
        self.teacherLbl=[[UILabel alloc] init];
        self.teacherLbl.userInteractionEnabled = YES;
    }
    
    self.teacherLbl.frame = CGRectMake(47, 227, kScreen_Width /4, 20);
    self.teacherLbl.textAlignment = NSTextAlignmentLeft;
    self.teacherLbl.font = [UIFont systemFontOfSize:12];

    self.teacherLbl.textColor = [UIColor blackColor];
    [self.teacherLbl setText: teachername];
    [self addSubview:self.teacherLbl];
}

-(void)setClassificationname:(NSString *)classificationname
{
    if (!self.classification) {
         self.classification =[[UILabel alloc] init];
         self.classification.userInteractionEnabled = YES;
        
    }
    
    self.classification.frame = CGRectMake(kScreen_Width/3, 240, kScreen_Width /4, 20);
    self.classification.textAlignment = NSTextAlignmentRight;
    self.classification.font = [UIFont systemFontOfSize:12];
    self.classification.textColor = [UIColor_ColorChange colorWithHexString:app_theme];
    [self.classification setText: classificationname];
    [self addSubview:self.classification];
    
    
}






@end
