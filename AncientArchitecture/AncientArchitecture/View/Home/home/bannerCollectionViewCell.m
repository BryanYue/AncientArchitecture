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
    
    if (!_imageview) {
        _imageview=[[UIImageView alloc]init];
        _imageview.userInteractionEnabled = YES;
    }
    _imageview.frame=CGRectMake(0, 0,kScreen_Width,224 );
    [_imageview setContentScaleFactor:[[UIScreen mainScreen] scale]];
    _imageview.contentMode =  UIViewContentModeScaleAspectFill;
    _imageview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _imageview.clipsToBounds  = YES;
    [self addSubview:_imageview];
    

    
  
    
    
    
    
    
    
    
    [_imageview yy_setImageWithURL:[NSURL URLWithString:imageName]
                      placeholder:nil
                        options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation
                        progress:nil
                        transform:^UIImage *(UIImage *image, NSURL *url) {
                          
//                            return [image yy_imageByRoundCornerRadius:10];
                            return  [image yy_imageByResizeToSize:CGSizeMake(kScreen_Width, 224) contentMode:UIViewContentModeScaleToFill];;
                        }
                       completion:nil];
    
  
    
}

@end
