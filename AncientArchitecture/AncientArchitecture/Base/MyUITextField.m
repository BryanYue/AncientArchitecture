//
//  MyUITextField.m
//  AncientArchitecture
//
//  Created by Bryan on 2018/3/21.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "MyUITextField.h"

@implementation MyUITextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//改变文字位置
-(CGRect) textRectForBounds:(CGRect)bounds{
    CGRect iconRect=[super textRectForBounds:bounds];
    iconRect.origin.x+=10;
    return iconRect;
}

//改变编辑时文字位置
-(CGRect) editingRectForBounds:(CGRect)bounds{
    CGRect iconRect=[super editingRectForBounds:bounds];
    iconRect.origin.x+=10;
    return iconRect;
}




@end
