//
//  EditDescibreViewController.m
//  AncientArchitecture
//
//  Created by Bryan on 2018/3/30.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "EditDescibreViewController.h"
#define editdescibreNotification @"editdescibre"

@interface EditDescibreViewController ()
@property (retain,nonatomic)UITextView     *textfild;
@end

@implementation EditDescibreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initview];
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


-(void)initview
{
    [self initbaseView];
    self.view.backgroundColor=[UIColor whiteColor];
    [self addBackButton];
    [self.topTitleLabel setText:@"个人资料"];
    
    [self addRightbuttonWithtext:@"确认"];
    
    UILabel *lable=[UILabel new];
    [lable setText:@"个人简介"];
    lable.frame=CGRectMake(14,self.topView.frame.size.height+30, 80,20 );
    lable.textAlignment=NSTextAlignmentLeft;
    lable.textColor=[UIColor blackColor];
    lable.font = [UIFont systemFontOfSize:18];
   
    [self.view addSubview:lable];
    
    
    NSUserDefaults *defaults =DEFAULTS;
    
    _textfild=[UITextView new];
    _textfild.text= [defaults objectForKey:@"descibre"];;
    _textfild.frame=CGRectMake(10, self.topView.frame.size.height+60, kScreen_Width-20, kScreen_Height/3);
    _textfild.textAlignment = NSTextAlignmentCenter;
    _textfild.font =  [UIFont systemFontOfSize:18];
    _textfild.textColor=[UIColor blackColor];
    // 设置文本对齐方式
    _textfild.textAlignment = NSTextAlignmentLeft;
    // 设置自动纠错方式
    _textfild.autocorrectionType = UITextAutocorrectionTypeNo;
    //外框
    _textfild.layer.borderColor = [UIColor blackColor].CGColor;
    _textfild.layer.borderWidth = 1;
    _textfild.layer.cornerRadius =5;
    [self.view addSubview:_textfild];
}

-(void)rightButtonPress
{
    [self hide];
    if (_textfild.text.length==0) {
        [self showAction:@"请输入内容"];
        return;
    }
    NSUserDefaults *defaults= DEFAULTS;
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    [parameterCountry setObject:[defaults objectForKey:@"memberid"] forKey:@"memberid"];
    [parameterCountry setObject:_textfild.text forKey:@"descibre"];
    
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_editDescibre withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                NSLog(@"%@",response.data);
                
                [defaults setObject:_textfild.text forKey:@"descibre"];
                [[NSNotificationCenter defaultCenter] postNotificationName:editdescibreNotification object:self userInfo:@{@"editdescibre":_textfild.text}];
                
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
    if (_textfild) {
        [_textfild resignFirstResponder];
    }
    
   
}





@end
