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
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:nil completed:^(UIImage *image, NSError *error,SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            
        }
        
    }];
    
    
    [self addSubview:self.imageview];
}

@end
