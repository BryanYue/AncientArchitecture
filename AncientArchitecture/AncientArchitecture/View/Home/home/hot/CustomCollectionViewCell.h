//
//  CustomCollectionViewCell.h
//  AncientArchitecture
//
//  Created by bryan on 2018/6/6.
//  Copyright © 2018年 通感科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)    UILabel *Customtitle;
@property (nonatomic,strong)    UILabel *Customtime;


@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *time;


@end
