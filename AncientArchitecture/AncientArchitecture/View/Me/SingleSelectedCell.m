//
//  SingleSelectedCell.m
//  AncientArchitecture
//
//  Created by 岳敏俊 on 2019/3/27.
//  Copyright © 2019 通感科技. All rights reserved.
//

#import "SingleSelectedCell.h"

@implementation SingleSelectedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    if(selected){
        self.lblTitle.textColor = [UIColor orangeColor];
        self.imgIfSelect.image = [UIImage imageNamed:@"selected_btn"];
    }else{
        self.lblTitle.textColor = [UIColor blackColor];
        self.imgIfSelect.image = [UIImage imageNamed:@"unSelect_btn"];
    }
}




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.lblTitle = [[UILabel alloc] init];
    [self.contentView addSubview:self.lblTitle];
    
    self.imgIfSelect = [[UIImageView alloc] init];
    self.imgIfSelect.image = [UIImage imageNamed:@"unSelect_btn"];
    [self.contentView addSubview:self.imgIfSelect];
    NSLog(@"self.bounds.size.width1 == %f",self.frame.size.width);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.lblTitle.frame = CGRectMake(10,0,self.bounds.size.width-80,50);
    self.imgIfSelect.frame = CGRectMake(self.bounds.size.width - 30, 10, 20, 20);
    NSLog(@"self.bounds.size.width2 == %f",self.frame.size.width);
}


@end
