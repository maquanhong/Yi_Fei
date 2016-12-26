//
//  LogonView.m
//  Yi_Fei
//
//  Created by yons on 16/12/24.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "LogonView.h"

@implementation LogonView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
    [self addContainView];
    }
    return self;
}



-(void)addContainView{

    _logoImage = [[UIImageView alloc] init];
    [self addSubview:_logoImage];
    [_logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.mas_equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];


    _textFiled = [[UITextField alloc] init];
    _textFiled.font = [UIFont systemFontOfSize:14];
    [self addSubview:_textFiled];
    [_textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_logoImage.mas_right).offset(10);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(20);
        make.trailing.mas_equalTo(self).offset(-10);
    }];

}


































@end
