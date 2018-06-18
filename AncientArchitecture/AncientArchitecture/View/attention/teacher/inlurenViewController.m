//
//  inlurenViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/5/15.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "inlurenViewController.h"
#import "TeacherResponse.h"
@interface inlurenViewController ()

@end

@implementation inlurenViewController
UIImageView *inluren_image;
UILabel * tinluren_name;
UILabel * tinluren_speaker;
UILabel * tinluren_longevity;
UILabel * tinluren_motto;
UILabel * tinluren_descibre;
UIScrollView * yinluscrollView;
float h;
int is_follow;
UIImageView *rightImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initview];
    [self initdata];
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
-(void)initdata
{
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    if ([DEFAULTS objectForKey:@"memberid"]) {
        [parameterCountry setObject:[DEFAULTS objectForKey:@"memberid"] forKey:@"memberid"];
    }
    
    [parameterCountry setObject:[DEFAULTS objectForKey:@"attteacher_id"] forKey:@"teacher_id"];
    
    
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_getTeacher withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                NSLog(@"%@",response.data);
                
              
                TeacherResponse *yiluren =[TeacherResponse mj_objectWithKeyValues:response.data];
                
                if (yiluren.photo) {
                
                    [inluren_image yy_setImageWithURL:[NSURL URLWithString:yiluren.photo]
                                                  placeholder:nil
                                                      options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation
                                                     progress:nil
                                                    transform:^UIImage *(UIImage *image, NSURL *url) {
                                                        image = [image yy_imageByResizeToSize:CGSizeMake(kScreen_Width,yinluscrollView.frame.size.height/5*3) contentMode:UIViewContentModeScaleToFill];
                                                        //                            return [image yy_imageByRoundCornerRadius:10];
                                                        return  image;
                                                    }
                                                   completion:nil];
                }
                
                if (yiluren.name) {
                    [tinluren_name setText: yiluren.name ];
                }
                
                if (yiluren.speaker_content) {
        
                    NSString *s=[@"主讲课程:" stringByAppendingString: yiluren.speaker_content];
                    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:s];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(5, yiluren.speaker_content.length)];
                     tinluren_speaker.attributedText=string;
                }
                
                
                if (yiluren.longevity) {
                    
                    NSString *s=[@"从业时间:" stringByAppendingString: yiluren.longevity];
                    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:s];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(5, yiluren.longevity.length)];
                    tinluren_longevity.attributedText=string;
                }
                
                if (yiluren.teacher_motto) {
                    
                    NSString *s=[@"讲师格言:" stringByAppendingString: yiluren.teacher_motto];
                    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:s];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(5, yiluren.teacher_motto.length)];
                    tinluren_motto.attributedText=string;
                }
                if (yiluren.descibre) {
                     [tinluren_descibre setText: yiluren.descibre ];
                    tinluren_descibre.numberOfLines=0;//行数设为0，表示不限制行数
                    //根据label的内容和label的font为label设置frame，100为label的长度
                    CGRect txRect = [tinluren_descibre.text boundingRectWithSize:CGSizeMake(kScreen_Width, [UIScreen mainScreen].bounds.size.height*10) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:tinluren_descibre.font} context:nil];
                    tinluren_descibre.frame=CGRectMake(20, h, txRect.size.width, txRect.size.height+20);//重新为label设置frame
                    h=h+tinluren_descibre.frame.size.height;
                    yinluscrollView.contentSize=CGSizeMake(kScreen_Width-40, h);
                    [self.view addSubview:yinluscrollView];
                }
                
                
                if ((int)1==[yiluren.is_follow intValue]) {
                   rightImageView.image = [UIImage imageNamed:@"icon_colloect_pink"];
                    is_follow=0;
                }else{
                    rightImageView.image = [UIImage imageNamed:@"icon_colloect_white"];
                    is_follow=1;
                }
               

              
            }
            
            
            
        }
        
    }];
}

-(void) initview
{
    [self initbaseView];
    self.view.backgroundColor=[UIColor whiteColor];
    [self addBackButton];
    [self.topTitleLabel setText:@"引路人"];
    
    h=0;
    yinluscrollView = [UIScrollView new];
    yinluscrollView.frame=CGRectMake(0, self.topView.frame.size.height, kScreen_Width,kScreen_Height-self.topView.frame.size.height );
    
    
    inluren_image=[[UIImageView alloc]init ];
    inluren_image.frame=CGRectMake(0, 0,kScreen_Width,yinluscrollView.frame.size.height/5*3 );
    [yinluscrollView addSubview:inluren_image];
    
    [inluren_image setContentScaleFactor:[[UIScreen mainScreen] scale]];
    inluren_image.contentMode =  UIViewContentModeScaleAspectFill;
    inluren_image.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    inluren_image.clipsToBounds  = YES;
    h=h+inluren_image.frame.size.height;
    
    tinluren_name=[[UILabel alloc] init];
    tinluren_name.textAlignment=NSTextAlignmentLeft;
    tinluren_name.textColor=[UIColor blackColor];
    tinluren_name.frame=CGRectMake(20, h,kScreen_Width,yinluscrollView.frame.size.height/ 3/3);
    [yinluscrollView addSubview:tinluren_name];
    h=h+tinluren_name.frame.size.height;
    
    UIView *line1=[[UIView alloc] init ];
    line1.backgroundColor=[UIColor_ColorChange colorWithHexString:app_theme];
    line1.frame=CGRectMake(0, h , kScreen_Width,1 );
    [yinluscrollView addSubview:line1];
    h=h+line1.frame.size.height;
    
    tinluren_speaker=[[UILabel alloc] init];
    tinluren_speaker.textAlignment=NSTextAlignmentLeft;
    tinluren_speaker.textColor=[UIColor blackColor];
    tinluren_speaker.numberOfLines=1;
    tinluren_speaker.frame=CGRectMake(20, h,kScreen_Width-20,yinluscrollView.frame.size.height/ 3/4);
    [yinluscrollView addSubview:tinluren_speaker];
     h=h+tinluren_speaker.frame.size.height;
    
    tinluren_longevity=[[UILabel alloc] init];
    tinluren_longevity.textAlignment=NSTextAlignmentLeft;
    tinluren_longevity.textColor=[UIColor blackColor];
    tinluren_longevity.numberOfLines=1;
    tinluren_longevity.frame=CGRectMake(20, h,kScreen_Width,yinluscrollView.frame.size.height/ 3/4);
    [yinluscrollView addSubview:tinluren_longevity];
      h=h+tinluren_longevity.frame.size.height;
    
    tinluren_motto=[[UILabel alloc] init];
    tinluren_motto.textAlignment=NSTextAlignmentLeft;
    tinluren_motto.textColor=[UIColor blackColor];
    tinluren_motto.numberOfLines=1;
    tinluren_motto.frame=CGRectMake(20, h,kScreen_Width,yinluscrollView.frame.size.height/ 3/4);
    [yinluscrollView addSubview:tinluren_motto];
    h=h+tinluren_motto.frame.size.height;
    
    
    
    UILabel *tinluren_jianjie=[[UILabel alloc] init];
    tinluren_jianjie.textAlignment=NSTextAlignmentLeft;
    tinluren_jianjie.textColor=[UIColor blackColor];
    tinluren_jianjie.frame=CGRectMake(20, h,kScreen_Width,yinluscrollView.frame.size.height/ 3/3);
    [yinluscrollView addSubview:tinluren_jianjie];
    h=h+tinluren_jianjie.frame.size.height;
     [tinluren_jianjie setText: @"讲师简介" ];
    
    
    CGRect txRect = [tinluren_jianjie.text boundingRectWithSize:CGSizeMake(kScreen_Width, [UIScreen mainScreen].bounds.size.height*10) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:tinluren_jianjie.font} context:nil];
    UIView *line2=[[UIView alloc] init ];
    line2.backgroundColor=[UIColor_ColorChange colorWithHexString:app_theme];
    line2.frame=CGRectMake(0, h , 20+txRect.size.width,1 );
    [yinluscrollView addSubview:line2];
    h=h+line2.frame.size.height;
    
    
    tinluren_descibre=[[UILabel alloc] init];
    tinluren_descibre.textAlignment=NSTextAlignmentLeft;
    tinluren_descibre.textColor=[UIColor grayColor];
    tinluren_descibre.frame=CGRectMake(20, h,kScreen_Width,0);
    [yinluscrollView addSubview:tinluren_descibre];
    
    [self addRightbutton:@"icon_colloect_white"];
   
}

-(void)addRightbutton:(NSString *)image{
    rightImageView = [[UIImageView alloc] init];
    rightImageView.image = [UIImage imageNamed:image];
    rightImageView.frame  = CGRectMake(kScreen_Width-10-rightImageView.image.size.width, statusBar_Height+18-rightImageView.image.size.height/2, rightImageView.image.size.width, rightImageView.image.size.height);
    [self.topView addSubview:rightImageView];
    
    self.rightChangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightChangeBtn setFrame:CGRectMake(kScreen_Width-20-rightImageView.image.size.width, statusBar_Height, 80, rightImageView.image.size.height)];
    [self.rightChangeBtn addTarget:self action:@selector(rightButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.rightChangeBtn];
    
}





-(void)rightButtonPress{
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    [parameterCountry setObject:[DEFAULTS objectForKey:@"memberid"] forKey:@"memberid"];
    [parameterCountry setObject:[DEFAULTS objectForKey:@"attteacher_id"] forKey:@"teacher_id"];
     [parameterCountry setObject:@(is_follow) forKey:@"type"];
    
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_teacherCollect withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                NSLog(@"%@",response.data);
                 rightImageView.image = [UIImage imageNamed:is_follow==0?@"icon_colloect_white":@"icon_colloect_pink"];
                is_follow=is_follow==1?0:1;
               
                
            }else{
                [self TextButtonAction:response.msg];

            }
        }else{
             [self TextButtonAction:error.domain];
        }
        
    }];
}











@end
