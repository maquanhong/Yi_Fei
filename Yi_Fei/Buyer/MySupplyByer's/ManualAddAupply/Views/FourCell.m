//
//  FourCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/14.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.

#import "FourCell.h"

@interface FourCell ()

@property (nonatomic,strong) UILabel * phoneNumber;

@end

@implementation FourCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    
    _phoneNumber = [[UILabel alloc] init];
    _phoneNumber.text = @"联系电话";
    _phoneNumber.font = [UIFont systemFontOfSize:14];
    [self addSubview:_phoneNumber];
    [_phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(10);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    _phoneText = [[UITextField alloc] init];
    [self addSubview:_phoneText];
    [_phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_phoneNumber.mas_right).offset(5);
        make.centerY.mas_equalTo(self);
        make.trailing.mas_equalTo(self).offset(-10);
        make.height.mas_equalTo( 30);
    }];
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self);
        make.trailing.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
}
























- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
























