//
//  CoursefeileiCollectionViewCell.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/12.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "CoursefeileiCollectionViewCell.h"

@implementation CoursefeileiCollectionViewCell



- (void)setImageName:(NSString *)imageName
{
    
    if (!self.imageview) {
        self.imageview=[UIImageView new];
        self.imageview.userInteractionEnabled = YES;
    }
    self.imageview.frame=CGRectMake(10, 0,kScreen_Width-20,120 );
    [self.imageview setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.imageview.contentMode =  UIViewContentModeScaleAspectFill;
    self.imageview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.imageview.clipsToBounds  = YES;
  
    
    [self.imageview yy_setImageWithURL:[NSURL URLWithString:imageName]
                                  placeholder:nil
                                      options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation
                                     progress:nil
                                    transform:^UIImage *(UIImage *image, NSURL *url) {
                                        image = [image yy_imageByResizeToSize:CGSizeMake(kScreen_Width-20,120) contentMode:UIViewContentModeScaleToFill];
                                        //                            return [image yy_imageByRoundCornerRadius:10];
                                        return  image;
                                    }
                                   completion:nil];
    
    
    
    [self addSubview:self.imageview];
}

@end



