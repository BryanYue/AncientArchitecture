//
//  UIColor+ColorChange.h
//  AncientArchitecture
//
//  Created by bryan on 2018/3/17.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor_ColorChange : UIColor

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexStrings: (NSString *)color;
@end
