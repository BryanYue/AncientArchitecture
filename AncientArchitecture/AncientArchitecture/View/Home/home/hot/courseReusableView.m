//
//  courseReusableView.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/18.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "courseReusableView.h"

@implementation courseReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        
        
        if (!self.courseresbtn) {
            self.courseresbtn=[[UIButton alloc] init];
            self.courseresbtn.userInteractionEnabled = YES;
        }
        
        self.courseresbtn.frame = CGRectMake(kScreen_Width/3, 20, kScreen_Width/3, 40);
        [self.courseresbtn setImage:[UIImage imageNamed:@"icon_teacher_black"] forState:UIControlStateNormal];
        [self.courseresbtn setTitle: @"分类课程" forState:UIControlStateNormal];
        [self.courseresbtn setTitleColor:[UIColor_ColorChange grayColor] forState:UIControlStateNormal];
        self.courseresbtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.courseresbtn.backgroundColor=[UIColor clearColor];
        self.courseresbtn.imageEdgeInsets = UIEdgeInsetsMake(0,-20,0,0);
        
        [self addSubview:self.courseresbtn];
        
        UIView *line3=[[UIView alloc] init ];
        line3.backgroundColor=[UIColor_ColorChange blackColor];
        line3.frame=CGRectMake(0, 20+self.courseresbtn.frame.size.height/2 , kScreen_Width/3,1 );
        [self addSubview:line3];
        
        UIView *line4=[[UIView alloc] init ];
        line4.backgroundColor=[UIColor_ColorChange blackColor];
        line4.frame=CGRectMake(kScreen_Width/3*2, 20+self.courseresbtn.frame.size.height/2 , kScreen_Width/3,1 );
        [self addSubview:line4];
        
        
        
        
        
        
        
        
    }
    
    
    
    
    return self;
}
@end
