//
//  courseViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/13.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "courseViewController.h"
#import "buylistViewController.h"
#import "yuboViewController.h"

@interface courseViewController ()
@property (nonatomic, strong) VTMagicController *magicController;
@property (nonatomic, strong)  NSArray <NSString *> *menuList;
@end

@implementation courseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:self.magicController];
    [self.view addSubview:_magicController.view];
    [self.view setNeedsUpdateConstraints];
    if (_menuList) {
        _menuList=nil;
    }
    [self generateTestData];
    [_magicController.magicView reloadData];
    
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
                view= [buylistViewController new];
                break;
            case 1:
                view= [yuboViewController new];
                break;
                
                
        }
    }
    
    
    return view;
}


- (void)generateTestData {
    NSString *isteacher=[DEFAULTS objectForKey:@"is_teacher"];
    NSLog(@"isteacher: %@" ,isteacher);
    if ([@"1" isEqualToString:isteacher]) {
         _menuList = @[@"购买课程",@"预播课程"];
    }else{
         _menuList = @[@"购买课程"];
    }
   
}


- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.view.translatesAutoresizingMaskIntoConstraints = NO;
        _magicController.magicView.navigationColor = [UIColor whiteColor];
        _magicController.magicView.sliderColor = RGBCOLOR(169, 37, 37);
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.layoutStyle = VTLayoutStyleDivide;
        _magicController.magicView.navigationHeight = 50;
        _magicController.magicView.againstStatusBar = NO;
        _magicController.magicView.sliderExtension = 10.0;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
    }
    return _magicController;
}


@end
