//
//  postPpreviewViewController.m
//  AncientArchitecture
//
//  Created by bryan on 2018/3/24.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import "postPpreviewViewController.h"
#import "THDatePickerView.h"
#import "CategoryResponse.h"
#import "CourseResponse.h"
#import "SYDatePicker.h"
#import <TZImagePickerController.h>

@interface postPpreviewViewController ()<SYDatePickerDelegate,THDatePickerViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@end

@implementation postPpreviewViewController
UIImageView *Courseimage;
UILabel *Coursename;
UILabel *Coursesort;
UILabel *Coursetime;
UILabel *Courseduration;
UILabel *Courseprize;
UILabel *CourseIntroduction;
UILabel *Coursecontent;
UILabel *Coursepeople;
THDatePickerView *dateView;
NSMutableDictionary *list;
NSMutableDictionary *map;

NSArray *areas;
NSString *selectedAreas;
NSString *pid;
NSString *name;
NSString *url;
NSString *timeString;
NSString *timehm;
UIPickerView *pickview;
SYDatePicker *picker;
UIView *toolView;
int Coursetab;


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

-(void)initview{
    [self initbaseView];
    self.view.backgroundColor=[UIColor whiteColor];
    [self addBackButton];
    [self.topTitleLabel setText:@"发布预播"];
    
    
   
    
   
    
    
    
    
    
    
    
    
    
    UIScrollView * scrollView = [UIScrollView new];
    
    scrollView.frame=CGRectMake(0, self.topView.frame.size.height, kScreen_Width,kScreen_Height-self.topView.frame.size.height );
                                 
    UIView *headline=[UIView new];
    headline.frame=CGRectMake(0,0,kScreen_Width,6);
    headline.backgroundColor =[UIColor_ColorChange colorWithHexString:@"f3f3f3"];
    [scrollView addSubview:headline];
   
    
    
    
    
    float height=6;
    NSArray<NSString *> *titletext=@[@"课程名称",@"课程分类",@"开课时间",@"课程时长",@"课程价格",@"课程封面",@"课程简介",@"课程内容",@"适合人群"];
    for (int i=0; i<titletext.count; i++) {
        UIView *view=[UIView new];
        view.backgroundColor=[UIColor clearColor];
        
        UILabel *lable=[UILabel new];
        [lable setText:titletext[i]];
        lable.textAlignment=NSTextAlignmentCenter;
        lable.textColor=[UIColor blackColor];
        lable.font = [UIFont boldSystemFontOfSize:18];
        
        UIView *line=[UIView new];
        line.backgroundColor=[UIColor_ColorChange colorWithHexString:@"f3f3f3"];
      
        
        if (i>5) {
             view.frame=CGRectMake(0, 46*i+270+(i-6)*40, kScreen_Width,46+40 );
             line.frame=CGRectMake(0, view.frame.size.height-1 , kScreen_Width,1 );
              lable.frame=CGRectMake(10, 0, 80,45 );
//             view.frame=CGRectMake(0, 46*i+270, kScreen_Width,91 );
        }else if(i==5){
            view.frame=CGRectMake(0, 46*i, kScreen_Width,271 );
            line.frame=CGRectMake(0, view.frame.size.height-1 , kScreen_Width,1 );
              lable.frame=CGRectMake(10, 0, 80,45 );
        }else{
             view.frame=CGRectMake(0, 46*i, kScreen_Width,46 );
            line.frame=CGRectMake(0, 45, kScreen_Width,1 );
              lable.frame=CGRectMake(10, 0, 80,45 );
        }
        [view addSubview:lable];
        [view addSubview:line];
        
       
        
        switch (i) {
            case 0:
                Coursename=[UILabel new];
                Coursename.textAlignment=NSTextAlignmentRight;
                Coursename.textColor=[UIColor_ColorChange colorWithHexString:@"666666"];
                Coursename.frame=CGRectMake(kScreen_Width-10-kScreen_Width/2, 0, kScreen_Width/2,view.frame.size.height-1 );
                [view addSubview:Coursename];
                [Coursename setText:@"点击设置课程名称"];
                break;
                
            case 1:
                Coursesort=[UILabel new];
                Coursesort.textAlignment=NSTextAlignmentRight;
                Coursesort.textColor=[UIColor_ColorChange colorWithHexString:@"666666"];
                Coursesort.frame=CGRectMake(kScreen_Width-10-kScreen_Width/2, 0, kScreen_Width/2,view.frame.size.height-1 );
                [view addSubview:Coursesort];
                [Coursesort setText:@"点击选择课程分类"];
                break;
                
            case 2:
                
                Coursetime=[UILabel new];
                Coursetime.textAlignment=NSTextAlignmentRight;
                Coursetime.textColor=[UIColor_ColorChange colorWithHexString:@"666666"];
                Coursetime.frame=CGRectMake(kScreen_Width-10-kScreen_Width/2, 0, kScreen_Width/2,view.frame.size.height-1 );
                [view addSubview:Coursetime];
                [Coursetime setText:@"点击选择开课时间"];
                break;
            case 3:
                Courseduration=[UILabel new];
                Courseduration.textAlignment=NSTextAlignmentRight;
                Courseduration.textColor=[UIColor_ColorChange colorWithHexString:@"666666"];
                Courseduration.frame=CGRectMake(kScreen_Width-10-kScreen_Width/2, 0, kScreen_Width/2,view.frame.size.height-1 );
                [view addSubview:Courseduration];
                [Courseduration setText:@"点击选择课程时长"];
                
                break;
            case 4:
                Courseprize=[UILabel new];
                Courseprize.textAlignment=NSTextAlignmentRight;
                Courseprize.textColor=[UIColor_ColorChange colorWithHexString:@"666666"];
                Courseprize.frame=CGRectMake(kScreen_Width-10-kScreen_Width/2, 0, kScreen_Width/2,view.frame.size.height-1 );
                [view addSubview:Courseprize];
                [Courseprize setText:@"点击设置课程价格"];
                
                
                break;
            case 5:
                
              
                
                Courseimage=[UIImageView new];
                Courseimage.frame=CGRectMake(10, 55,view.frame.size.width-20,view.frame.size.height-20 );
                [view addSubview:Courseimage];
                [Courseimage setImage:[UIImage imageNamed:@"img_add_image"]];
                [Courseimage setContentScaleFactor:[[UIScreen mainScreen] scale]];
                Courseimage.contentMode =  UIViewContentModeScaleAspectFill;
                Courseimage.autoresizingMask = UIViewAutoresizingFlexibleHeight;
                Courseimage.clipsToBounds  = YES;
                break;
                
                
            case 6:
               
                CourseIntroduction =[UILabel new];
                CourseIntroduction.textAlignment=NSTextAlignmentLeft;
                CourseIntroduction.textColor=[UIColor_ColorChange colorWithHexString:@"666666"];
                CourseIntroduction.frame=CGRectMake(10, 46, kScreen_Width-20,40 );
                [CourseIntroduction setText:@"点击设置课程简介"];
                [view addSubview:CourseIntroduction];
              
                break;
            case 7:
                Coursecontent =[UILabel new];
                Coursecontent.textAlignment=NSTextAlignmentLeft;
                Coursecontent.textColor=[UIColor_ColorChange colorWithHexString:@"666666"];
                Coursecontent.frame=CGRectMake(10, 46, kScreen_Width-20,40 );
                [Coursecontent setText:@"点击设置课程内容"];
                [view addSubview:Coursecontent];
                
               
                break;
            case 8:
                Coursepeople =[UILabel new];
                Coursepeople.textAlignment=NSTextAlignmentLeft;
                Coursepeople.textColor=[UIColor_ColorChange colorWithHexString:@"666666"];
                Coursepeople.frame=CGRectMake(10, 46, kScreen_Width-20,40 );
                [Coursepeople setText:@"点击设置适合人群"];
                [view addSubview:Coursepeople];

                
                break;
            default:
                break;
        }
        
        view.userInteractionEnabled = YES;
        [view setTag:i];
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(to:)]];
        
        [scrollView addSubview:view];
        height=height+view.frame.size.height;
    }
    UIButton *btnlogin = [UIButton buttonWithType:UIButtonTypeSystem];
    btnlogin.frame = CGRectMake(40, height+50, kScreen_Width/10*8, 40);
    [btnlogin setTitle:@"提交" forState:UIControlStateNormal];
    btnlogin.backgroundColor =[UIColor_ColorChange colorWithHexString:app_theme];
    btnlogin.layer.masksToBounds=YES;
    btnlogin.layer.cornerRadius = 20;
    [btnlogin setTintColor:[UIColor whiteColor]];
    [btnlogin addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    btnlogin.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    
    [scrollView addSubview:btnlogin];
    height=height+btnlogin.frame.size.height+100;
    
     scrollView.contentSize=CGSizeMake(kScreen_Width, height);
     [self.view addSubview:scrollView];
    
    
   
    [self initcategroy];
   
}

-(void)to:(id)sender
{
    if (dateView) {
         [dateView removeFromSuperview];
    }
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    NSLog (@"%zd",[tapRecognizer.view tag]);
    Coursetab=(int)[tapRecognizer.view tag];
    switch ([tapRecognizer.view tag]) {
        case 0:
            
            [self showUITextFieldAction:@"设置课程名称"];
            
            break;
        case 1:
            
            if (list) {
                toolView = [[UIView alloc] init];
                toolView.frame = CGRectMake(0, kScreen_Height/3*2, kScreen_Width, kScreen_Height/3);
                toolView.backgroundColor=[UIColor whiteColor];
                
                pickview =[UIPickerView new];
                pickview.frame =CGRectMake(0, 44, kScreen_Width, kScreen_Height/3-44);
                pickview.delegate =self;
                pickview.dataSource=self;
                [toolView addSubview:pickview];
              
                
                UIView *view =[UIView new];
                view.frame = CGRectMake(0, 0, kScreen_Width, 44);
                view.backgroundColor=[UIColor grayColor];
                
                UIButton *saveBtn = [[UIButton alloc] init];
                saveBtn.frame = CGRectMake(kScreen_Width - 50, 2, 40, 40);
                [saveBtn setTitle: @"确定" forState:UIControlStateNormal];
                [saveBtn setTitleColor:[UIColor_ColorChange whiteColor] forState:UIControlStateNormal];
                [saveBtn addTarget:self action:@selector(saveBtn) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:saveBtn];
                
                UIButton *cancelBtn = [[UIButton alloc] init];
                cancelBtn.frame = CGRectMake(10, 2, 40, 40);
                [cancelBtn setTitle: @"取消" forState:UIControlStateNormal];
                [cancelBtn setTitleColor:[UIColor_ColorChange whiteColor] forState:UIControlStateNormal];
                [cancelBtn addTarget:self action:@selector(cancelBtn) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:cancelBtn];
                
                
                UILabel *titleLbl = [[UILabel alloc] init];
                titleLbl.frame = CGRectMake(60, 2, kScreen_Width - 120, 40);
                titleLbl.textAlignment = NSTextAlignmentCenter;
                titleLbl.textColor = [UIColor whiteColor];
                [view addSubview:titleLbl];
                [toolView addSubview:view];
              
                
                [self.view addSubview:toolView];
               
              
            }else{
                [self showAction:@"课程分类数据加载中，请重新点击选择！"];
            }
           
            
            
            break;
        case 2:
            if (!dateView) {
                dateView = [[THDatePickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300)];
                [dateView setTag:2000];
                dateView.delegate = self;
                dateView.title = @"请选择时间";
            }
           
            [self.view addSubview:dateView];
            
            [self timerBrnClick];
            
            break;
        case 3:
            if (!picker) {
                 picker= [SYDatePicker new];
            }
            [picker showInView:self.view withFrame:CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300) andDatePickerMode:UIDatePickerModeTime];
            picker.delegate = self;
            
            break;
        case 4:
            [self showUITextFieldAction:@"请设置价格"];
            
            
            break;
        case 5:
            [self checkimage];
            
            
            break;
        case 6:
             [self showUITextFieldAction:@"请设置课程简介"];
            break;
        case 7:
             [self showUITextFieldAction:@"请设置课程内容"];
            break;
        case 8:
             [self showUITextFieldAction:@"请设置适合人群"];
            break;
        default:
            break;
    }
}


-(void)Alertdo:(NSString *)string
{
    [super Alertdo:string];
    switch (Coursetab) {
        case 0:
             [Coursename setText:string];
            break;
        case 1:
           
            break;
            
        case 2:
            
            break;
            
        case 4:
             [Courseprize setText:string];
            break;
        case 6:
            [CourseIntroduction setText:string];
            break;
        case 7:
             [Coursecontent setText:string];
            break;
        case 8:
            [Coursepeople setText:string];
            break;
        default:
            break;
    }
    
}
-(void)checkimage
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickerVc.title =@"图片";
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        NSLog(@"%zd",photos.count);
        NSData *imageData = UIImageJPEGRepresentation(photos[0], 1.0);
        NSString *encodedString = [imageData base64Encoding];
        NSLog(@"%zd",encodedString);
        
        NSUserDefaults *defaults= DEFAULTS;
        NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
        [parameterCountry setObject:[defaults objectForKey:@"memberid"] forKey:@"memberid"];
        [parameterCountry setObject:encodedString forKey:@"photo_data"];
        
        [self GeneralButtonAction];
        [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_uploadImg withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
            NSLog(@"error%zd",error.code);
            if (!error) {
                BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
                if (response.code  == 200) {
                    NSLog(@"%@",response.data);
                    
                    
                    if (self.HUD) {
                        [self.HUD hideAnimated:true];
                    }
                    
                    [self TextButtonAction:response.msg];
                    
                    NSDictionary *data =response.data;
                    url=[data objectForKey:@"headimgurl"];
                    
                    [Courseimage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil completed:^(UIImage *image, NSError *error,SDImageCacheType cacheType, NSURL *imageURL) {
                        if (error) {
                            NSLog(@"%@", error);
                            [Courseimage setImage:[UIImage imageNamed:@"tab_icon_me_nor"]];
                        }
                      
                        
                    }];
                    
                    
                    
                }else{
                    if (self.HUD) {
                        [self.HUD hideAnimated:true];
                    }
                    [self TextButtonAction:response.msg];
                    
                }
            }else{
                if (self.HUD) {
                    [self.HUD hideAnimated:true];
                }
                [self TextButtonAction:error.domain];
            }
            
        }];
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}















// 显示
- (void)timerBrnClick
{
  
    
    [UIView animateWithDuration:0.3 animations:^{
        dateView.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300);
        [dateView show];
    }];
}








#pragma mark - THDatePickerViewDelegate
/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    NSLog(@"保存点击%@",timer);
    [Coursetime setText:timer];
    
    NSDateFormatter *formatter_ = [[NSDateFormatter alloc] init];
    formatter_.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *createDate = [formatter_ dateFromString:timer];
    
    NSLog(@"date:%@",createDate);
    NSTimeInterval a=[createDate timeIntervalSince1970]; // *1000 是精确到毫秒，不乘就是精确到秒
    timeString = [NSString stringWithFormat:@"%.0f", a]; //转为字符型
    NSLog(@"时间戳:%@",timeString); //时间戳的值
    
    [UIView animateWithDuration:0.3 animations:^{
        dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
        
        [dateView removeFromSuperview];
    }];
    
}

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate {
    NSLog(@"取消点击");
   
    [UIView animateWithDuration:0.3 animations:^{
        dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
        
         [dateView removeFromSuperview];
    }];
}


//获取课程分类
-(void)initcategroy
{
   
   
    
    [self GeneralButtonAction];
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_getCategory withParams:nil withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
            NSLog(@"error%zd",error.code);
            if (!error) {
                BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
                if (response.code  == 200) {
                    NSLog(@"%@",response.data);
                   list =[NSMutableDictionary new];
                    map =[NSMutableDictionary new];
                    
                    NSMutableArray<CategoryResponse *> *Category=[CategoryResponse mj_objectArrayWithKeyValuesArray:response.data];
                    NSLog(@"CategoryResponse:%lu",Category.count);
                    
                    for (int i=0; i<Category.count; i++) {
                         NSLog(@"category_name:%@",Category[i].name);
                        
                        NSMutableArray<CourseResponse *> *Course=[CourseResponse mj_objectArrayWithKeyValuesArray:Category[i].subcat];
                        
                        NSLog(@"CourseResponse:%lu",Course.count);
                        NSMutableArray<NSString *> *vause=[NSMutableArray new];
                        if (Course.count>0) {
                            for (int j=0; j<Course.count; j++) {
                                [vause addObject: Course[j].name];
                                NSLog(@"course_name:%@",Course[j].name);
                    
                                NSLog(@"course_name:%@",Course[j].id);
                                [map setValue:Course[j].id forKey:Course[j].name];
                            }
                            
                            [list setValue:vause forKey:Category[i].name];
                        }else{
//                            [vause addObject: @"无子类"];
                          [list setValue:vause forKey:Category[i].name];
                        }

                    }
                    areas=[[list allKeys]sortedArrayUsingSelector:@selector(compare:)];
                    selectedAreas=[areas objectAtIndex:0];
                   
                }
                
                if (self.HUD) {
                    [self.HUD hideAnimated:true];
                }
                [self TextButtonAction:response.msg];
                
            }else{
                if (self.HUD) {
                    [self.HUD hideAnimated:true];
                }
                [self TextButtonAction:error.domain];
            }
            
        }];
    
    
}


//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件包含的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 2; // 返回2表明该控件只包含2列
}

//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法返回teams.count，表明teams包含多少个元素，该控件就包含多少行
    
    if (component == 0) {
        return areas.count;
    }else{
        return [[list objectForKey:selectedAreas]count];
    }
}


// UIPickerViewDelegate中定义的方法，该方法返回的NSString将作为UIPickerView
// 中指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法根据row参数返回teams中的元素，row参数代表列表项的编号，
    // 因此该方法表示第几个列表项，就使用teams中的第几个元素
    
    if (component == 0) {
        return [areas objectAtIndex:row];
    }else{
        NSArray *tmp = component == 0 ? areas: [list objectForKey:selectedAreas];
         NSLog(@"row%@", [tmp objectAtIndex:row]);
        pid=[map objectForKey:[tmp objectAtIndex:row]];
        name=[tmp objectAtIndex:row];
        NSLog(@"pid%@", pid);
        return  [tmp objectAtIndex:row];
    }
    
    
}

// 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0) {
        selectedAreas = [areas objectAtIndex:row];
        [pickview reloadComponent:1];
        
        
        NSArray *tmp = component == 0 ? areas: [list objectForKey:selectedAreas];
    
        NSLog(@"component == 0:%@", [tmp objectAtIndex:row]);
    }else{
        NSArray *tmp = component == 0 ? areas: [list objectForKey:selectedAreas];
        
        NSLog(@"pickerView:%@", [tmp objectAtIndex:row]);
    }
    
   
}


// UIPickerViewDelegate中定义的方法，该方法返回的NSString将作为
// UIPickerView中指定列的宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView
   widthForComponent:(NSInteger)component
{
    // 如果是第一列，宽度为90
    if(component == 0) {
        return kScreen_Width/2;
    }
    return kScreen_Width/2; // 如果是其他列（只有第二列），宽度为210
}

- (void)picker:(UIDatePicker *)picker ValueChanged:(NSDate *)date{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    fm.dateFormat = @"HH";
    NSLog(@"Courseduration%@", [fm stringFromDate:date]);
    int i =[[fm stringFromDate:date] intValue]*60;
    fm.dateFormat = @"mm";
    NSLog(@"Courseduration%@", [fm stringFromDate:date]);
    i=i+[[fm stringFromDate:date] intValue];
    timehm =[NSString stringWithFormat:@"%d",i];
    fm.dateFormat = @"HH:mm";
     [Courseduration setText:[fm stringFromDate:date]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [picker dismiss];
}


-(void)saveBtn{
      NSLog(@"saveBtnClick:");
    
     [Coursesort setText:name];
    
    [UIView animateWithDuration:0.3 animations:^{
        toolView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
        
        [toolView removeFromSuperview];
    }];
    
}

-(void)cancelBtn{
     NSLog(@"cancelBtnClick:");
    [UIView animateWithDuration:0.3 animations:^{
        toolView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
        
        [toolView removeFromSuperview];
    }];
}

-(void)login{
    NSLog(@"login:");
    Coursetab=100;
     NSLog(@"Coursename%@", Coursename.text);
     NSLog(@"Courseduration%@", Courseduration.text);
   

    
    if ([Coursename.text isEqualToString:@"点击设置课程名称"]) {
        [self showAction:@"请输入课程名称"];
        return;
    }
    if ([Coursesort.text isEqualToString:@"点击选择课程分类"]) {
        [self showAction:@"请选择课程分类"];
        return;
    }
    
    if ([Coursetime.text isEqualToString:@"点击选择开课时间"]) {
        [self showAction:@"请选择开课时间"];
        return;
    }
    
    if ([Courseduration.text isEqualToString:@"点击选择课程时长"]) {
        [self showAction:@"请选择课程时长"];
        return;
    }
    
    
    if ([Courseprize.text isEqualToString:@"点击设置课程价格"]) {
        [self showAction:@"请输入课程价格"];
        return;
    }
    
    if (!url) {
        [self showAction:@"请添加课程图片"];
        return;
    }
    
    if ([CourseIntroduction.text isEqualToString:@"点击设置课程简介"]) {
        [self showAction:@"请设置课程简介"];
        return;
    }
    
    if ([Coursecontent.text isEqualToString:@"点击选择课程内容"]) {
        [self showAction:@"请设置课程内容"];
        return;
    }
    
    if ([Coursepeople.text isEqualToString:@"点击设置适合人群"]) {
        [self showAction:@"请设置适合人群"];
        return;
    }
    

    NSUserDefaults *defaults= DEFAULTS;
    NSMutableDictionary *parameterCountry = [NSMutableDictionary dictionary];
    [parameterCountry setObject:[defaults objectForKey:@"memberid"] forKey:@"memberid"];
    [parameterCountry setObject:pid forKey:@"cate_id"];
    
    [parameterCountry setObject:Coursename.text forKey:@"course_name"];
    [parameterCountry setObject:url forKey:@"course_img"];
    [parameterCountry setObject:CourseIntroduction.text forKey:@"course_desc"];
    [parameterCountry setObject:Coursecontent.text forKey:@"course_content"];
    [parameterCountry setObject:timeString forKey:@"start_time"];
    [parameterCountry setObject:timehm forKey:@"class_hour"];
    [parameterCountry setObject:Courseprize.text forKey:@"price"];
    [parameterCountry setObject:Coursepeople.text forKey:@"fit_person"];
    [self GeneralButtonAction];
    [[MyHttpClient sharedJsonClient]requestJsonDataWithPath:url_creatCourse withParams:parameterCountry withMethodType:Post autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"error%zd",error.code);
        if (!error) {
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:data];
            if (response.code  == 200) {
                NSLog(@"%@",response.data);
                
                if (self.HUD) {
                    [self.HUD hideAnimated:true];
                }
                [self TextButtonAction:response.msg];
               
              [self dismissViewControllerAnimated:YES completion:nil];
            }else{
               
                if (self.HUD) {
                    [self.HUD hideAnimated:true];
                }
                [self TextButtonAction:response.msg];
                
            }
            
            
        }else{
            if (self.HUD) {
                [self.HUD hideAnimated:true];
            }
            [self TextButtonAction:error.domain];
        }
        
    }];
    
}





@end
