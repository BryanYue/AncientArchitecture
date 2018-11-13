//
//  courseController.m
//  AncientArchitecture
//
//  Created by Bryan on 2018/5/18.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "courseController.h"
#import "jijiangViewController.h"
#import "yiboViewController.h"
@interface courseController ()
@property (nonatomic, strong)  NSArray <NSString *> *menuList;
@end

@implementation courseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor whiteColor];
    self.magicView.navigationColor = [UIColor whiteColor];
    self.magicView.layoutStyle = VTLayoutStyleDivide;
    self.magicView.switchStyle = VTSwitchStyleStiff;
    self.magicView.navigationHeight = 50;
    self.magicView.againstStatusBar = NO;
    self.magicView.needPreloading = NO;
    
    [self configCustomSlider];
    
    [self generateData];
    [self.magicView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    NSMutableArray *titleList = [NSMutableArray array];
    for (NSString *menu in _menuList) {
        [titleList addObject:menu];
    }
    return titleList;
}


- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {

     NSString *itemIdentifier =[NSString stringWithFormat:@"itemIdentifier%lu",itemIndex];
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (itemIndex==0) {
            [menuItem setImage:[UIImage imageNamed:@"icon_home_live"] forState:UIControlStateNormal];
            }else{
               [menuItem setImage:[UIImage imageNamed:@"icon_course_playde"] forState:UIControlStateNormal];
            }
        [menuItem setTitleColor:RGBCOLOR(50, 50, 50) forState:UIControlStateNormal];
        [menuItem setTitleColor:RGBCOLOR(169, 37, 37) forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.f];
      
//        [menuItem setBackgroundImage:[self imageWithColor:RGBCOLOR(169, 37, 37)] forState:UIControlStateNormal];
//        [menuItem setBackgroundImage:[self imageWithColor: [UIColor_ColorChange colorWithHexString:app_theme]] forState:UIControlStateHighlighted];
      
    }
    
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    NSString *gridId =[NSString stringWithFormat:@"grid%lu",pageIndex];
    UIViewController *view= [magicView dequeueReusablePageWithIdentifier:gridId];
    if (!view) {
        switch (pageIndex) {
            case 0:
                view= [jijiangViewController new];
                break;
            case 1:
                view= [yiboViewController new];
                break;
           
        }
    }
    
    
    return view;
}



- (void)generateData {
    _menuList = @[@"即将开播", @"已播课程"];
}


//  颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (void)configCustomSlider {
//    UIImageView *sliderView = [[UIImageView alloc] init];
//    [sliderView setImage:[UIImage imageNamed:@"magic_arrow"]];
//    sliderView.contentMode = UIViewContentModeScaleToFill;
//    [self.magicView setSliderView:sliderView];
//    self.magicView.sliderHeight = 5.f;
//    self.magicView.sliderOffset = -2;
}
@end
