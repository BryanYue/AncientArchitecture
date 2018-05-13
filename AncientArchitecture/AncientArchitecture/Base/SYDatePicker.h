//
//  SYDatePicker.h
//  AncientArchitecture
//
//  Created by Bryan on 2018/4/8.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYDatePickerDelegate <NSObject>

@optional
//当UIDatePicker值变化时所用到的代理
- (void)picker:(UIDatePicker *)picker ValueChanged:(NSDate *)date;

@end

@interface SYDatePicker : UIView

@property  (weak, nonatomic) id<SYDatePickerDelegate> delegate;

@property  (strong, nonatomic) UIDatePicker *picker;

- (void)showInView:(UIView *)view withFrame:(CGRect)frame andDatePickerMode:(UIDatePickerMode)mode;

- (void)dismiss;

- (void)valueChanged:(UIDatePicker *)picker;

@end
