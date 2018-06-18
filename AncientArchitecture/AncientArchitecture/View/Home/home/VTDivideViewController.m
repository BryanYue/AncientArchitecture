//
//  VTDivideViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/12.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "VTDivideViewController.h"
#import "HotViewController.h"
#import "CourseViewController.h"
#import "courseController.h"
#import "xianchangViewController.h"
#import "yingluViewController.h"
@interface VTDivideViewController ()
@property (nonatomic, strong)  NSArray <NSString *> *menuList;
@end

@implementation VTDivideViewController



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
    
    [self generateTestData];
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
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:RGBCOLOR(50, 50, 50) forState:UIControlStateNormal];
        [menuItem setTitleColor:RGBCOLOR(169, 37, 37) forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.f];
    
    }
   
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    NSString *gridId =[NSString stringWithFormat:@"grid%lu",pageIndex];
    UIViewController *view= [magicView dequeueReusablePageWithIdentifier:gridId];
    if (!view) {
        switch (pageIndex) {
            case 0:
                view= [[HotViewController alloc] init];
                break;
            case 1:
                view= [[courseController alloc] init];
                break;
            case 2:
                view= [[xianchangViewController alloc] init];
                break;
            case 3:
                view= [[yingluViewController alloc] init];
                break;
                
        }
    }

   
    return view;
}



- (void)generateTestData {
    _menuList = @[@"热门", @"课程",
                  @"现场", @"引路人"];
}




- (void)configCustomSlider {
    UIImageView *sliderView = [[UIImageView alloc] init];
    [sliderView setImage:[UIImage imageNamed:@"icon_ring_reddark"]];
    sliderView.contentMode = UIViewContentModeScaleAspectFit;
    [self.magicView setSliderView:sliderView];
    self.magicView.sliderHeight = 5.f;
    self.magicView.sliderOffset = -2;
}
@end
