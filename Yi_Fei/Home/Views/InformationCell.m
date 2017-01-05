//
//  InformationCell.m
//  Yi_Fei
//
//  Created by yons on 16/11/22.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "InformationCell.h"

@interface InformationCell ()


@end


@implementation InformationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createLayoutView];
    }
    return self;
}


-(void)createLayoutView
{
     _iconImage =[[UIImageView alloc] init];
    _iconImage.image = [UIImage imageNamed:@"形状"];
    [self addSubview:_iconImage];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(15);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    _tagImage =[[UIImageView alloc] init];
    _tagImage.image = [UIImage imageNamed:@"yuan"];
    [self addSubview:_tagImage];
    [_tagImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_iconImage.mas_right);
        make.centerY.mas_equalTo(_iconImage.mas_top);
        make.size.mas_equalTo(CGSizeMake(8, 8));
    }];
    
    _certainLabel=[[UILabel alloc] init];
    _certainLabel.font=[UIFont systemFontOfSize:14.0];
//    _certainLabel.text = @"未读";
    [_certainLabel sizeToFit];
    [self addSubview:_certainLabel];
    [_certainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.trailing.mas_equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    
    
    _titleLabel=[[UILabel alloc] init];
    _titleLabel.font=[UIFont systemFontOfSize:18.0];
    [_titleLabel sizeToFit];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImage.mas_right).offset(20);
        make.top.mas_equalTo(_iconImage.mas_top);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(_certainLabel.mas_left).offset(-15);
    }];
    
    
    _detailLabel=[[UILabel alloc] init];
    _detailLabel.font=[UIFont systemFontOfSize:14.0];
    _detailLabel.textColor = [UIColor grayColor];
    [_detailLabel sizeToFit];
    [self addSubview:_detailLabel];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_titleLabel);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.trailing.mas_equalTo(_titleLabel);
    }];

    
}































- (void)awakeFromNib {
    [super awakeFromNib];
 
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}























@end
















