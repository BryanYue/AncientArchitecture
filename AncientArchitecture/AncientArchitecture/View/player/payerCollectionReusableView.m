//
//  payerCollectionReusableView.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/20.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "payerCollectionReusableView.h"

@implementation payerCollectionReusableView


-(void)setUiview:(UIView *)uiview{
    self.uiview =uiview ;
    
    [self addSubview:self.uiview];
}



@end

