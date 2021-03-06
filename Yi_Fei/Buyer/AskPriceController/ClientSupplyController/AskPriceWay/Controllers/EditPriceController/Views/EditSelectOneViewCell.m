//
//  EditSelectOneViewCell.m
//  Yi_Fei
//
//  Created by ZMJ on 16/12/19.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "EditSelectOneViewCell.h"

@implementation EditSelectOneViewCell


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
    
    _typeLabel = [[UILabel alloc] init];
    _typeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_typeLabel];
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.mas_equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    
    _typeOne = [[ZMJTypeView alloc] init];
    _typeOne.layer.cornerRadius = 5;
    _typeOne.layer.borderWidth = 1.0;
    _typeOne.layer.borderColor = BACKCOLOR.CGColor;
    [self addSubview:_typeOne];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTypeView)];
    [_typeOne addGestureRecognizer:tap];
    
    _textFiled = [[UITextField alloc] init];
    _textFiled.layer.cornerRadius = 5;
    _textFiled.layer.borderWidth = 1.0;
    _textFiled.layer.borderColor = BACKCOLOR.CGColor;
    [self addSubview:_textFiled];
    _textFiled.hidden = YES;
    
    [_typeOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.mas_equalTo(_typeLabel.mas_right).offset(10);
        make.right.mas_equalTo(_textFiled.mas_left).offset(-10);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(_textFiled);
    }];
    
    [_textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.mas_equalTo(_typeOne.mas_right).offset(10);
        make.trailing.mas_equalTo(self).offset(-10);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(_typeOne);
    }];
    
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.leading.mas_equalTo(self);
        make.trailing.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
}


-(void)clickTypeView{
    if ([self.delegate respondsToSelector:@selector(clickTwoView:)]) {
        [self.delegate clickTwoView:_typeOne];
    }
}














@end
