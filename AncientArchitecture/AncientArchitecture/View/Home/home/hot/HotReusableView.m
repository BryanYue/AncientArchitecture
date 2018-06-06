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
        
        
        
            
        self.headViewController =[[headViewController alloc]init] ;
            
        [self addSubview:self.headViewController.view];
            
      
       
        
        
    }
    
    
    
    
    return self;
}





@end
