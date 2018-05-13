//
//  HotReusableView.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/12.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "HotReusableView.h"

@implementation HotReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        
        
        
            
            _titleLab = [[UILabel alloc]init];
            
            _titleLab.frame =CGRectMake(0,0, self.frame.size.width,self.frame.size.height);
            
            _titleLab.textAlignment =NSTextAlignmentCenter;
            
            _titleLab.backgroundColor = [UIColor redColor];
            
            [self addSubview:_titleLab];
            
        
        
        
        
    }
    
    
    
    
    return self;
}




@end
