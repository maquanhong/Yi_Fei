//
//  CardTwoCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/17.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "CardTwoCell.h"

@interface CardTwoCell ()

@property (nonatomic,strong) UIImageView *iconImageView;

@property (nonatomic,strong) UILabel *typeLabel;

@end

@implementation CardTwoCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

   if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addContentView];
    }
    return self;
}

-(void)addContentView{
    
    _iconImageView  = [[UIImageView alloc] init];
    _iconImageView.image = [UIImage imageNamed:@"leixing_icon"];
    
    [_iconImageView sizeToFit];
    [self addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(15);
        make.top.equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _typeLabel  = [[UILabel alloc] init];
    _typeLabel.text = @"行业类型";
    _typeLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_typeLabel];
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.mas_right).offset(10);
        make.centerY.equalTo(_iconImageView);
        make.height.mas_equalTo(20);
    }];
    
    _typeOne  = [[industryView alloc] init];
    _typeOne.layer.cornerRadius = 5;
    _typeOne.layer.borderWidth = 1.0;
    _typeOne.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:_typeOne];
    
    
    _typeTwo  = [[industryView alloc] init];
    _typeTwo.layer.cornerRadius = 5;
    _typeTwo.layer.borderWidth = 1.0;
    _typeTwo.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:_typeTwo];
    
    
    _typeThree  = [[industryView alloc] init];
    _typeThree.layer.cornerRadius = 5;
    _typeThree.layer.borderWidth = 1.0;
    _typeThree.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:_typeThree];
    
    _typeFour  = [[industryView alloc] init];
    _typeFour.layer.cornerRadius = 5;
    _typeFour.layer.borderWidth = 1.0;
    _typeFour.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:_typeFour];
    
    
    
    [_typeOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_iconImageView);
        make.top.equalTo(_iconImageView.mas_bottom).offset(20);
        make.height.mas_equalTo(25);
        make.right.mas_equalTo(_typeTwo.mas_left).offset(-10);
        make.width.equalTo(_typeTwo);
    }];
    

    
    [_typeTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_typeOne.mas_right).offset(10);
        make.centerY.equalTo(_typeOne);
        make.trailing.equalTo(self).offset(-10);
        make.height.mas_equalTo(25);
        make.width.equalTo(_typeOne);
    }];
    
    
    
    [_typeThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_typeOne);
        make.right.mas_equalTo(_typeFour.mas_left).offset(-10);
        make.top.equalTo(_typeOne.mas_bottom).offset(20);
        make.height.mas_equalTo(25);
        make.width.equalTo(_typeFour);
    }];
    
    
    
    [_typeFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_typeThree.mas_right).offset(10);
        make.centerY.equalTo(_typeThree);
        make.trailing.equalTo(self).offset(-10);
        make.height.mas_equalTo(25);
        make.width.equalTo(_typeThree);
    }];
    
    





}
























@end












