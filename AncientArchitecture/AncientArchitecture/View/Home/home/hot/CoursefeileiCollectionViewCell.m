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
    self.imageview.frame=CGRectMake(10, 15,kScreen_Width-20,110 );
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



