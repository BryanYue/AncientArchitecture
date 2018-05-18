//
//  teacherCollectionViewCell.h
//  AncientArchitecture
//
//  Created by Bryan on 2018/5/18.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface teacherCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)    UILabel *teachername;
@property (nonatomic,strong)    UIButton *teachernum;
@property (nonatomic,strong)    UIImageView *teacherimageview;


@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *name;
@end
