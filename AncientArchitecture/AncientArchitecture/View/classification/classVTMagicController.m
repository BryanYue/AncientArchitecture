//
//  classVTMagicController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/19.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "classVTMagicController.h"
#import "CourseDetailResponse.h"
#import "CategoryResponse.h"
#import "CourseResponse.h"
#import "CateCourseDetaiViewController.h"
@interface classVTMagicController ()
@property (nonatomic, strong) VTMagicController *magicController;
@property (nonatomic, strong)  NSArray <NSString *> *menuList;
@property (nonatomic, strong)  NSArray <NSString *> *classidList;

@property (nonatomic,strong)    UILabel  *topTitleLabel;
@property (nonatomic,strong)    UIView   *topView;       //顶部的view
@property (nonatomic,strong)UIButton     *backButton;
@end

@implementation classVTMagicController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:self.magicController];
    [self.view addSubview:_magicController.view];
    [self.view setNeedsUpdateConstraints];
    
//    self.edgesForExtendedLayout = UIRectEdgeAll;
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.magicView.navigationColor = [UIColor whiteColor];
//    self.magicView.layoutStyle = VTLayoutStyleDivide;
//    self.magicView.switchStyle = VTSwitchStyleStiff;
//    self.magicView.navigationHeight = 50;
//    self.magicView.againstStatusBar = NO;
//    self.magicView.needPreloading = NO;
 
    
     [self configCustomSlider];
    [self generateData];
   
    
    [self initbaseView];
    [self addBackButton];
    
    NSString *title =[DEFAULTS objectForKey:@"classification_title"];
    
    
    
    
    [self.topTitleLabel setText:title];
}

-(void)initbaseView{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //自定义标题栏
    _topView=[[UIView alloc] init];
    _topView.frame=CGRectMake(0, 0, kScreen_Width, 44+statusBar_Height);
    _topView.backgroundColor=[UIColor_ColorChange colorWithHexString:app_theme ];
    
    _topTitleLabel=[[UILabel alloc] init];
    _topTitleLabel.frame=CGRectMake(50, statusBar_Height, kScreen_Width-100, 44);
    _topTitleLabel.backgroundColor=[UIColor clearColor];
    _topTitleLabel.textAlignment=NSTextAlignmentCenter;
    _topTitleLabel.textColor=[UIColor whiteColor];
    _topTitleLabel.font = [UIFont systemFontOfSize:18];
    [_topView addSubview:_topTitleLabel];
    [self.view addSubview:_topView];
}
-(void)addBackButton{
    UIImageView *backImageView = [[UIImageView alloc] init];
    backImageView.image = [UIImage imageNamed:@"nav_icon_back"];
    backImageView.frame = CGRectMake(10, statusBar_Height+18-backImageView.image.size.height/2, backImageView.image.size.width, backImageView.image.size.height);
    [_topView addSubview:backImageView];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setFrame:CGRectMake(0, statusBar_Height, 80, 44)];
    [_backButton addTarget:self action:@selector(backButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:_backButton];
}


-(void)backButtonPress{
    [self dismissViewControllerAnimated:YES completion:nil];
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


- (void)generateData {
    NSString *nid =[DEFAULTS objectForKey:@"classification_id"];
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_getCategory withParams:nil withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                NSLog(@"%@",response.data);
                
                
                NSMutableArray<CategoryResponse *> *Category=[CategoryResponse mj_objectArrayWithKeyValuesArray:response.data];
                
                NSMutableArray<NSString *> *vause=[[NSMutableArray alloc] init];
                NSMutableArray<NSString *> *idvause=[[NSMutableArray alloc] init];
                for (int i=0; i<Category.count; i++) {
                    NSLog(@"Category: id%@",Category[i].id);
                    if ([nid isEqualToString:Category[i].id]) {
                        NSMutableArray<CategoryResponse *> *Course=[CourseResponse mj_objectArrayWithKeyValuesArray:Category[i].subcat];
                        
                        NSLog(@"CourseResponse:%lu",Course.count);
                        
                        if (Course.count>0) {
                            for (int j=0; j<Course.count; j++) {
                                if (Course[j].name) {
                                    [vause addObject: Course[j].name];
                                    [idvause addObject: Course[j].id];
                                    NSLog(@"Course: name%@",Course[j].name);
                                    NSLog(@"Course: id%@",Course[j].id);
                                }
                                
                            }
                            
                        }
                    }
                }
                self.menuList = vause.copy;
                self.classidList = idvause.copy;
                 [_magicController.magicView reloadData];
                
            }
            
            
            
            
        }else{
            
            
        }
        
    }];

}









- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    NSMutableArray *titleList = [NSMutableArray array];
    for (NSString *menu in self.menuList) {
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
      NSLog(@"magicView:%lu",pageIndex);
    UIViewController *view= [magicView dequeueReusablePageWithIdentifier:gridId];
    
    if (!view) {
        CateCourseDetaiViewController  *tempview= [[CateCourseDetaiViewController alloc] init];
        tempview.CateCourseDetaiid=self.classidList[pageIndex];
        view=tempview;
    }
  
    
   
    
    return view;
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
        _magicController.magicView.againstStatusBar = false;
        _magicController.magicView.sliderExtension = 10.0;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
        _magicController.magicView.needPreloading=NO;
        _magicController.view.frame=CGRectMake(0, 44+statusBar_Height, kScreen_Width, kScreen_Height-44+statusBar_Height);

       
    }
    return _magicController;
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
