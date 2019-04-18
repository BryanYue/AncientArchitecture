//
//  BuyViewController.m
//  AncientArchitecture
//
//  Created by 岳敏俊 on 2019/3/15.
//  Copyright © 2019 通感科技. All rights reserved.
//

#import "BuyViewController.h"
#import <StoreKit/StoreKit.h>
#import "SingleSelectedCell.h"

#define loginNotification @"loginstatus"


@interface BuyViewController ()<SKPaymentTransactionObserver,SKProductsRequestDelegate,UITableViewDelegate, UITableViewDataSource>{
     NSInteger selectRow;
}


@property (nonatomic, strong) IBOutlet UITableView *tableView;



@property (nonatomic, copy) NSArray *dataId; //
@property (nonatomic, copy) NSArray *dataPrice; //
@end

@implementation BuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [self initview];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)initview{
    [self initbaseView];
    self.view.backgroundColor=[UIColor whiteColor];
    [self addBackButton];
    [self.topTitleLabel setText:@"充值"];
    
    
    
    self.dataId = @[@"com.feiwuzhi.AncientArchitectures0001",@"com.feiwuzhi.AncientArchitectures0012",@"com.feiwuzhi.AncientArchitectures0098",
                    @"com.feiwuzhi.AncientArchitectures0198",@"com.feiwuzhi.AncientArchitectures0298",@"com.feiwuzhi.AncientArchitectures0388",
                    @"com.feiwuzhi.AncientArchitectures0518",@"com.feiwuzhi.AncientArchitectures0618"];
    
    self.dataPrice=@[@"1彩钻",@"12彩钻",@"98彩钻",@"198彩钻",@"298彩钻",@"388彩钻",@"518彩钻",@"688彩钻"];
    
    
    
    [self.view addSubview:self.tableView];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    selectRow = 0;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kScreen_Width/2-80, kScreen_Height-self.tableView.frame.origin.y-self.topView.frame.size.height-statusBar_Height, 160, 40)];
   
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"充值" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor =[UIColor_ColorChange colorWithHexString:app_theme];
    
    
    [self.view addSubview:btn];
    
//    [_tableView reloadData];
    


}
-(void)btnAction:(UIButton *)sender{
    NSLog(@"selectRow == %ld",selectRow);
    
    NSLog(@"selectRow == %@",_dataId[selectRow]);
   
    
       if ([SKPaymentQueue canMakePayments]) {
            //允许应用内付费购买
            [self requestProductData:_dataId[selectRow]];
            [self GeneralButtonAction];
    
        }else {
            //用户禁止应用内付费购买.
            [self TextButtonAction:@"用户禁止应用内付费购买"];
        }
}


// MARK: - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataPrice.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SingleSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lblTitle.text = self.dataPrice[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"cell.frame === %f",cell.frame.size.width);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectRow = indexPath.row;
    NSLog(@"selectRow == %ld",selectRow);
}

// MARK: - 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        //  20, self.topView.frame.size.height, txRect.size.width-20, txRect.size.height+20
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(20,self.topView.frame.size.height+statusBar_Height, kScreen_Width-40,kScreen_Height-statusBar_Height-200) style:UITableViewStyleGrouped];
        _tableView.backgroundColor =[UIColor whiteColor];
        [_tableView registerClass:[SingleSelectedCell class] forCellReuseIdentifier:@"cellID"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}









- (void)dealloc
{
     [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}




//去苹果服务器请求商品
- (void)requestProductData:(NSString *)type{
    NSLog(@"-------------请求对应的产品信息----------------");
    
    
    
    NSArray *product = [[NSArray alloc] initWithObjects:type,nil];
    
    NSSet *nsset = [NSSet setWithArray:product];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    [request start];
    
}


//收到产品返回信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSLog(@"--------------收到产品反馈消息---------------------");
    NSArray *product = response.products;
    if([product count] == 0){
        
        NSLog(@"--------------没有商品------------------");
        return;
    }
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%lu",(unsigned long)[product count]);
    
    
    SKProduct *p = nil;
    for (SKProduct *pro in product) {
        NSLog(@"%@", [pro description]);
        NSLog(@"%@", [pro localizedTitle]);
        NSLog(@"%@", [pro localizedDescription]);
        NSLog(@"%@", [pro price]);
        NSLog(@"%@", [pro productIdentifier]);
        
       
        p = pro;
        
    }
    
    SKPayment *payment = [SKPayment paymentWithProduct:p];
    
    NSLog(@"发送购买请求");
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}



//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    
    NSLog(@"------------------错误-----------------:%@", error);
     [self TextButtonAction: error.domain];
    if (self.HUD) {
        [self.HUD hideAnimated:true];
    }
}

- (void)requestDidFinish:(SKRequest *)request{
    
    NSLog(@"------------反馈信息结束-----------------");
}


//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction{
    for(SKPaymentTransaction *tran in transaction){
        
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:{
                NSLog(@"------------交易完成------------");
                
               
                // 发送到苹果服务器验证凭证
                //从沙盒中获取交易凭证并且拼接成请求体数据
                NSURL *receiptUrl=[[NSBundle mainBundle] appStoreReceiptURL];
                NSData *receiptData=[NSData dataWithContentsOfURL:receiptUrl];
                
                NSString *str = [[NSString alloc] initWithData:receiptData encoding:NSUTF8StringEncoding];
                NSLog(@"------------%@",str);
                NSString *receiptString=[receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];//转化为base64字符串
                
                NSString *bodyString = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", receiptString];//拼接请求数据
                NSLog(@"------------------------%@",bodyString);
//                [bodyString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
               
                //                NSString *receiptString=[receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];//转化为base64字符串
                //
                //                NSString *bodyString = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", receiptString];//拼接请求数据
                //                NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
                
                NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
                [parameterCountry setObject: [DEFAULTS objectForKey:@"memberid"] forKey:@"member_id"];
                [parameterCountry setObject: bodyString forKey:@"receipt_data"];
                
                [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:rechargeMoney withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
                   
                    if (!error) {
                        BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
                        if (response.code  == 200) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:loginNotification object:self userInfo:@{@"isLogin":[NSString stringWithFormat:@"%d", true]}];

                            if (self.HUD) {
                                [self.HUD hideAnimated:true];
                            }
                              [self TextButtonAction: @"交易完成"];
                           
                            
                        }else{
                            if (self.HUD) {
                                [self.HUD hideAnimated:true];
                            }
                            [self TextButtonAction:response.msg];
                        }
                    } else {
                        
                        if (self.HUD) {
                            [self.HUD hideAnimated:true];
                        }
                        [self TextButtonAction:error.domain];
                        
                    }}];
                
                
                
                
                
                
                
                
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            }
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"------------商品添加进列表------------");
                
                break;
            case SKPaymentTransactionStateRestored:{
                NSLog(@"------------已经购买过商品------------");
                
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                 [self TextButtonAction: @"已经购买过商品"];
                if (self.HUD) {
                    [self.HUD hideAnimated:true];
                }
            }
                break;
            case SKPaymentTransactionStateFailed:{
                NSLog(@"------------交易失败------------");
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                  [self TextButtonAction: @"交易失败"];
                if (self.HUD) {
                    [self.HUD hideAnimated:true];
                }
            }
                break;
            default:
                
                break;
        }
    }
}

//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"------------------------交易结束------------------------");
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}



@end
