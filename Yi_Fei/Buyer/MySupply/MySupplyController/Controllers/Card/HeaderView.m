//
//  HeaderView.m
//  Yi_Fei
//
//  Created by yons on 16/12/17.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "HeaderView.h"



@implementation HeaderView


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self addContentView];
    }
    return self;
}

-(void)addContentView{

    _backImageView  = [[UIImageView alloc] init];
    [_backImageView sizeToFit];
    [self addSubview:_backImageView];
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.trailing.equalTo(self);
       make.leading.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);;
    }];
    
    
    _backView  = [[UIView alloc] init];
    _backView.backgroundColor =  [UIColor colorWithWhite:0.f alpha:0.7];
    [_backView sizeToFit];
    [self addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self);
        make.leading.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];


    _iconImageView  = [[UIImageView alloc] init];
    [_iconImageView sizeToFit];
    [self addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.mas_equalTo(self.mas_centerY).offset(-10);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    _nameLabel  = [[UILabel alloc] init];
    _nameLabel.textColor = [UIColor whiteColor];
    [_nameLabel sizeToFit];
    _nameLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_iconImageView.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    _titleLabel  = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_titleLabel sizeToFit];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
        make.top.equalTo(_nameLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    
}

















@end



















