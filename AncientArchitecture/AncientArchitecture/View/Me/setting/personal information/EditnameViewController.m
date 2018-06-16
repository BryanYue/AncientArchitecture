//
//  EditnameViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/6/16.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "EditnameViewController.h"
#import "MyUITextField.h"
#define editdescibreNotification @"editdescibre"


@interface EditnameViewController ()
@property (retain,nonatomic)MyUITextField     *textview;
@end

@implementation EditnameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initbaseView];
    self.view.backgroundColor=[UIColor_ColorChange colorWithHexString:@"f3f3f3"];
    [self addBackButton];
    [self.topTitleLabel setText:@"个人资料"];
    
    [self addRightbuttonWithtext:@"确认"];
    
    UIView *view  =[[UIView alloc ]init];
    view.frame=CGRectMake(0,self.topView.frame.size.height, kScreen_Width,64 );
    view.backgroundColor =[UIColor whiteColor];
    
    UILabel *lablen=[[UILabel alloc]init];
    [lablen setText:@"昵称"];
    lablen.frame=CGRectMake(10,10, kScreen_Width/2,44 );
    lablen.textAlignment=NSTextAlignmentLeft;
    lablen.textColor=[UIColor blackColor];
    lablen.font = [UIFont systemFontOfSize:18];

    _textview=[[MyUITextField alloc] init];
    _textview.frame=CGRectMake(kScreen_Width/3*2,10, kScreen_Width/3-10,44 );
    NSAttributedString *attrlogin = [[NSAttributedString alloc] initWithString:@"请输入您的昵称" attributes:
                                     @{NSForegroundColorAttributeName:[UIColor grayColor],
                                       NSFontAttributeName:_textview.font
                                       }];
    _textview.attributedPlaceholder = attrlogin;
    
   
                  
                  
    [view addSubview: lablen];
    [view addSubview: _textview];
    [self.view addSubview: view];
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


-(void)rightButtonPress
{
    [self hide];
    if (_textview.text.length==0) {
        [self showAction:@"请输入内容"];
        return;
    }
    NSUserDefaults *defaults= DEFAULTS;
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    [parameterCountry setObject:[defaults objectForKey:@"memberid"] forKey:@"memberid"];
    [parameterCountry setObject:@"2" forKey:@"type"];
    [parameterCountry setObject:_textview.text forKey:@"user_name"];
    
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_editName withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                NSLog(@"%@",response.data);
                
               
                [[NSNotificationCenter defaultCenter] postNotificationName:editdescibreNotification object:self userInfo:@{@"name":_textview.text}];
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
                
                
            }else{
                
                [self TextButtonAction:response.msg];
            }
            
            if (self.HUD) {
                [self.HUD hideAnimated:true];
            }
            
            
            
            
            
        }else{
            if (self.HUD) {
                [self.HUD hideAnimated:true];
            }
            [self TextButtonAction:error.domain];
        }
        
    }];
    
    
    
    
    
}

-(void)hide{
    if (_textview) {
        [_textview resignFirstResponder];
    }
    
    
}

@end
