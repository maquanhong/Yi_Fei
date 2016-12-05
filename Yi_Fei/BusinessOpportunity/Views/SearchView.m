//
//  SearchView.m
//  Yi_Fei
//
//  Created by yons on 16/11/18.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "SearchView.h"

@interface SearchView ()

@property (nonatomic,strong) UIImageView *iconImageView;

@end


@implementation SearchView


- (instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self createSubView];
    return  self;
}


-(void)createSubView{

    
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.image = [UIImage imageNamed:@"sousuo"];
    [self addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    _textFiled = [[UITextField alloc] init];
    _textFiled.placeholder = @"输入公司货号";
    _textFiled.font = [UIFont systemFontOfSize:14];
    [self addSubview:_textFiled];
    [_textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(20);
        make.trailing.mas_equalTo(self);
    }];

    
    
}

























@end





























