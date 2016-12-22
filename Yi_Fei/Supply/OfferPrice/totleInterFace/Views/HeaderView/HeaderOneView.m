//
//  HeaderOneView.m
//  Yi_Fei
//
//  Created by yons on 16/12/21.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "HeaderOneView.h"

@interface HeaderOneView ()

@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UILabel *wayLabel;

@property (nonatomic,strong) UILabel *offerPrice;

@property (nonatomic,strong) ZMJTypeView *typeOne;

@end

@implementation HeaderOneView



- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self addcontents];
    }
    return self;
}

-(void)addcontents{
    
    
    
    _nameLabel =[[UILabel alloc] init];
    _nameLabel.text = @"客户";
    [_nameLabel sizeToFit];;
    _nameLabel.font=[UIFont systemFontOfSize:14.0];
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(10);
        make.top.equalTo(self.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    _titleLabel =[[UILabel alloc] init];
    [_titleLabel sizeToFit];;
    _titleLabel.font=[UIFont systemFontOfSize:18.0];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(10);
        make.height.mas_equalTo( 20);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    _wayLabel =[[UILabel alloc] init];
    _wayLabel.text = @"报价方式";
    [_wayLabel sizeToFit];;
    _wayLabel.font=[UIFont systemFontOfSize:14.0];
    [self addSubview:_wayLabel];
    [_wayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_nameLabel);
        make.top.equalTo(lineView.mas_top).offset(10);
        make.height.mas_equalTo( 20);
    }];
    
    
    _typeOne = [[ZMJTypeView alloc] init];
    _typeOne.layer.cornerRadius = 5;
    _typeOne.layer.borderWidth = 1.0;
    _typeOne.layer.borderColor = BACKCOLOR.CGColor;
    _typeOne.nameLabel.text = @"预留报价";
    [self addSubview:_typeOne];
    
    
    _typeTwo = [[ZMJTypeView alloc] init];
    _typeTwo.layer.cornerRadius = 5;
    _typeTwo.layer.borderWidth = 1.0;
    _typeTwo.layer.borderColor = BACKCOLOR.CGColor;
    _typeTwo.nameLabel.text = @"请选择预留时间";
    [self addSubview:_typeTwo];

   
    [_typeOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_wayLabel.mas_right).offset(10);
        make.centerY.equalTo(_wayLabel);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo((WIDTH - 140) / 2);
    }];
    
    [_typeTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_typeOne.mas_right).offset(10);
        make.centerY.equalTo(_typeOne);
        make.height.mas_equalTo(25);
        make.trailing.mas_equalTo(self).offset(-10);
        make.width.mas_equalTo((WIDTH - 140) / 2);
    }];
   
    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ckickPicker)];
    [_typeTwo addGestureRecognizer:tapOne];
    
}



-(void)ckickPicker{
    if ([self.delegate respondsToSelector:@selector(clickPiceDate)]) {
        [self.delegate clickPiceDate];
    }
}











































@end
