//
//  bannerCollectionViewCell.m
//  AncientArchitecture
//
//  Created by bryan on 2018/6/6.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "bannerCollectionViewCell.h"

@implementation bannerCollectionViewCell


- (void)setImageName:(NSString *)imageName
{
    
    if (!self.imageview) {
        self.imageview=[[UIImageView alloc]init];
        self.imageview.userInteractionEnabled = YES;
    }
    self.imageview.frame=CGRectMake(0, 0,kScreen_Width,224 );
    [self.imageview setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.imageview.contentMode =  UIViewContentModeScaleAspectFill;
    self.imageview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.imageview.clipsToBounds  = YES;
    [self addSubview:self.imageview];
    

    [self.imageview yy_setImageWithURL:[NSURL URLWithString:imageName]
                      placeholder:nil
                        options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation
                        progress:nil
                        transform:^UIImage *(UIImage *image, NSURL *url) {
                            image = [image yy_imageByResizeToSize:CGSizeMake(kScreen_Width, 224) contentMode:UIViewContentModeScaleToFill];
//                            return [image yy_imageByRoundCornerRadius:10];
                            return  image;
                        }
                       completion:nil];
    
  
    
}

@end
