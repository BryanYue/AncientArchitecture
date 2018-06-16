//
//  xiangguanCollectionViewCell.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/20.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "xiangguanCollectionViewCell.h"

@implementation xiangguanCollectionViewCell


- (void)setTitlename:(NSString *)titlename
{
    
    if (!self.title) {
        self.title=[[UILabel alloc] init];
        self.title.userInteractionEnabled = YES;
        
        self.title.textAlignment=NSTextAlignmentLeft;
        self.title.textColor=[UIColor_ColorChange grayColor];
        self.title.numberOfLines=1;
        self.title.frame=CGRectMake(20,0,kScreen_Width,30);
        self.title.font = [UIFont systemFontOfSize:15];
    }
  
   
    [self.title setText:titlename];
    [self addSubview: self.title];
}
@end
