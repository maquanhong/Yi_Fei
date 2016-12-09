//
//  ZMJAddGoodsTwoView.m
//  Yi_Fei
//
//  Created by yons on 16/11/9.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ZMJAddGoodsTwoView.h"


@implementation ZMJAddGoodsTwoView


- (instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self createSubView];
    return  self;
}


-(void)createSubView
{
    NSArray *array = @[@"商品颜色",@"商品价格",@"货币类型",@"价格条款"];
    for (NSInteger i = 0; i < array.count; i++) {
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 46* i + 10, 60, 20)];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.text = array[i];
    [self addSubview:_nameLabel];
    UIView *lineV=[[UIView alloc] initWithFrame:CGRectMake(0, 46* i + 43, WIDTH, 1)];
    lineV.backgroundColor=[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self addSubview:lineV];
        
}

    _textFOne = [[UITextField alloc]  initWithFrame:CGRectMake(80, 10,WIDTH - 100 , 20)];
    _textFOne.font = [UIFont systemFontOfSize:14];
    _textFOne.placeholder = @"例如黄/绿/蓝";
    _textFOne.tag = 2000 ;
    [self addSubview:_textFOne];
    
    _textFTwo = [[UITextField alloc]  initWithFrame:CGRectMake(80, 57,WIDTH - 100 , 20)];
    _textFTwo.font = [UIFont systemFontOfSize:14];
    _textFTwo.placeholder = @"请填写商品价格(数字)";
    _textFTwo.tag = 2001 ;
    [self addSubview:_textFTwo];
    
    
    _typeOneView = [[ZMJTypeView alloc] init];
    _typeOneView.layer.cornerRadius = 5;
    _typeOneView.layer.borderWidth = 1.0;
    _typeOneView.tag = 10000;
    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTypeView:)];
    [_typeOneView addGestureRecognizer:tapOne];
    
     _typeOneView.layer.borderColor = BACKCOLOR.CGColor;
    [self addSubview:_typeOneView];
    [_typeOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(80);
        make.top.mas_equalTo(self.mas_top).offset(97.5);
        make.size.mas_equalTo(CGSizeMake(110, 25));
    }];

    _typeTwoView = [[ZMJTypeView alloc] init];
    _typeTwoView.layer.cornerRadius = 5;
    _typeTwoView.layer.borderWidth = 1.0;
    _typeTwoView.layer.borderColor = BACKCOLOR.CGColor;
    [self addSubview:_typeTwoView];
    [_typeTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(80);
        make.top.mas_equalTo(self.mas_top).offset(145);
        make.size.mas_equalTo(CGSizeMake(110, 25));
    }];
    _typeTwoView.tag = 10001;
    UITapGestureRecognizer *tapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTypeView:)];
    [_typeTwoView addGestureRecognizer:tapTwo];
    
    _textFThree = [[UITextField alloc] init];
    _textFThree.layer.cornerRadius = 5;
    _textFThree.layer.borderWidth = 1.0;
    _textFThree.layer.borderColor = BACKCOLOR.CGColor;
    _textFThree.placeholder = @"请输入码头地址";
    _textFThree.textAlignment = NSTextAlignmentCenter;
    _textFThree.font = [UIFont systemFontOfSize:14];
    [self addSubview:_textFThree];
    [_textFThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_typeTwoView.mas_right).offset(10);
        make.centerY.mas_equalTo(_typeTwoView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];

    
    
    
    
    
    
    
    
    
}

-(void)clickTypeView:(id)sender{

  UITapGestureRecognizer * singleTap = (UITapGestureRecognizer *)sender;
    NSInteger tag = [singleTap view].tag;
    if ([self.delegate respondsToSelector:@selector(clickViewTag:)]) {
        [self.delegate clickViewTag:tag];
    }
}






@end

























