//
//  UserInfoView.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/23.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "UserInfoView.h"
#import "PureLayout.h"

@interface UserInfoView()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation UserInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
  
        [self addViewConstraints];
    }
    return self;
}

- (void)addViewConstraints {

    
    _backgImageView  = [[UIImageView alloc] init];
    [self addSubview:_backgImageView];
    [_backgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    _backView  = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor colorWithRed:0.0 / 255.0 green:0.0 / 255.0 blue:0.0 / 255.0 alpha:0.2];
    [_backgImageView addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_backgImageView);
        make.trailing.equalTo(_backgImageView);
        make.bottom.mas_equalTo(_backgImageView.mas_bottom);
        make.top.mas_equalTo(_backgImageView.mas_top);
    }];

    
    _logoImageView  = [[UIImageView alloc] init];
    [_backView addSubview:_logoImageView];
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(20);
        make.leading.equalTo(self).offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    

    _titleLabel  = [[UILabel alloc] init];
    _titleLabel.text = @"账户";
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    [_backView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_backView.mas_centerX);
        make.top.mas_equalTo(_backView.mas_top).offset(20);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(50);
    }];
    

    
    _nameLabel  = [[UILabel alloc] init];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = [UIFont systemFontOfSize:18];
    [_backView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_logoImageView.mas_centerY);
        make.left.mas_equalTo(_logoImageView.mas_right).offset(20);
        make.height.mas_equalTo(25);
    }];
    
    
    _levelLabel  = [[UILabel alloc] init];
    _levelLabel.textColor = [UIColor whiteColor];
    _levelLabel.font = [UIFont systemFontOfSize:14];
    [_backView addSubview:_levelLabel];
    [_levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_logoImageView.mas_bottom);
        make.left.mas_equalTo(_logoImageView.mas_right).offset(20);
        make.height.mas_equalTo(25);
    }];
    
}






























@end










