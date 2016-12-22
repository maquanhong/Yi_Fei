//
//  SectionOneCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/22.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "SectionOneCell.h"

@implementation SectionOneCell


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
    
    _textFiled = [[UITextField alloc]init];
    _textFiled.font = [UIFont systemFontOfSize:14];
    _textFiled.placeholder = @"填写数字";
    [self addSubview:_textFiled];
   
    
    
    _typeOne  = [[ZMJTypeView alloc]init];
    _typeOne.layer.cornerRadius = 5;
    _typeOne.layer.borderWidth = 1.0;
    _typeOne.layer.borderColor = BACKCOLOR.CGColor;
    [self addSubview:_typeOne];
    [_typeOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self).offset(-5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc ] initWithTarget:self action:@selector(clickTypeView:)];
    [_typeOne addGestureRecognizer:tap];
    
    _nextLabel = [[UILabel alloc]init];
    _nextLabel.text = @"单位";
    _nextLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_nextLabel];
    [_nextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_typeOne.mas_left).offset(-5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    
    [_textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(_nextLabel.mas_left).offset(-10);
        make.height.mas_equalTo(20);
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



-(void)clickTypeView:(id)sender{
  UITapGestureRecognizer * singleTap = (UITapGestureRecognizer *)sender;
    NSInteger index = [singleTap view].tag;
    if ([self.delegate respondsToSelector:@selector(clickView:)]) {
        [self.delegate clickView:index];
    }
}




















@end
