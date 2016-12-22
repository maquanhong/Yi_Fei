//
//  SectionTwoCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/22.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "SectionTwoCell.h"

@implementation SectionTwoCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self addView];
    }
    return self;
}

-(void)addView{
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    
    _numberLabel = [[UILabel alloc]init];
    _numberLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_right).offset(5);
        make.bottom.mas_equalTo(_titleLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    
    _typeOne  = [[TypeViewTextFiled alloc]init];
    _typeOne.layer.cornerRadius = 5;
    _typeOne.layer.borderWidth = 1.0;
    _typeOne.layer.borderColor = BACKCOLOR.CGColor;
    [self addSubview:_typeOne];
    [_typeOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_numberLabel.mas_right).offset(5);
        make.centerY.mas_equalTo(_numberLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    
    
    
    _sizeLabel = [[UILabel alloc]init];
    _sizeLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_sizeLabel];
    [_sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_right).offset(5);
        make.top.mas_equalTo(_titleLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    
    _typeTwo  = [[TypeViewTextFiled alloc]init];
    _typeTwo.layer.cornerRadius = 5;
    _typeTwo.layer.borderWidth = 1.0;
    _typeTwo.layer.borderColor = BACKCOLOR.CGColor;
    [self addSubview:_typeTwo];
    [_typeTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_sizeLabel.mas_right).offset(5);
        make.centerY.mas_equalTo(_sizeLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    
   _typeThree  = [[TypeViewTextFiled alloc]init];
    _typeThree.layer.cornerRadius = 5;
    _typeThree.layer.borderWidth = 1.0;
    _typeThree.layer.borderColor = BACKCOLOR.CGColor;
    [self addSubview:_typeThree];
    [_typeThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self).offset(-5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    _heightLabel = [[UILabel alloc]init];
    _heightLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_heightLabel];
    [_heightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_typeThree.mas_left).offset(-5);
        make.centerY.mas_equalTo(_typeThree.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    
    
    
    
    
    
    
   
    
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
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
