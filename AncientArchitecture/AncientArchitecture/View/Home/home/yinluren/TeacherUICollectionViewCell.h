//
//  TeacherUICollectionViewCell.h
//  AncientArchitecture
//
//  Created by bryan on 2018/5/13.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherUICollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)    UILabel *imageview;
@property (nonatomic,strong)    UILabel *titleLbl;
@property (nonatomic,strong)    UIImageView *headimageview;
@property (nonatomic,strong)    UILabel *timeLbl;
@property (nonatomic,strong)    UILabel *teacherLbl;

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *headimageName;
@property (nonatomic, copy) NSString *titlename;
@property (nonatomic, copy) NSString *teachername;
@property (nonatomic, copy) NSString *timename;
@end
