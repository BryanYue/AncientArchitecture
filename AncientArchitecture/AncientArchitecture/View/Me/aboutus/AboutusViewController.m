//
//  AboutusViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/6/16.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "AboutusViewController.h"
#import "aboutus.h"

@interface AboutusViewController ()
@property (nonatomic,weak) UILabel *web;
@end

@implementation AboutusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initbaseView];
    self.view.backgroundColor=[UIColor whiteColor];
    [self addBackButton];
    [self.topTitleLabel setText:@"关于我们"];
    
   
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:aboutUs withParams:nil withMethodType:Get autoShowError:true andBlock:^(id data, NSError *error) {
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
              
                
            aboutus *data =[aboutus mj_objectWithKeyValues:response.data];
                  NSLog(@"%@",data.content);
                
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[data.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                
            
        
                if (!_web) {
                    UILabel *webview = [[UILabel alloc] init];
                    [self.view addSubview:webview];
                    self.web = webview;
                }
                 _web.textAlignment=NSTextAlignmentLeft;
                _web.attributedText=attrStr;
                
                _web.numberOfLines=0;//行数设为0，表示不限制行数
                _web.font =[UIFont systemFontOfSize:20];

                //根据label的内容和label的font为label设置frame，100为label的长度
                CGRect txRect = [_web.text boundingRectWithSize:CGSizeMake(kScreen_Width, [UIScreen mainScreen].bounds.size.height*10) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_web.font} context:nil];
                _web.frame=CGRectMake(20, self.topView.frame.size.height, txRect.size.width-20, txRect.size.height+20);//重新为label设置frame
                
                [self.view addSubview: _web];
            }
            
            
            
        }
        
    }];
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





@end
