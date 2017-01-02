//
//  BUYTypeView.m
//  YiFei
//
//  Created by yons on 16/8/26.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "BUYTypeView.h"
#import "UIView+Layout.h"
#import "BUYTitleButton.h"

@interface BUYTypeView ()

@property (nonatomic,strong) UILabel *typeLabel;

@property (nonatomic,strong) UIView *lineOne;
@property (nonatomic,strong) UIView *lineTwo;
@property (nonatomic,strong) UIView *lineThree;

@end

@implementation BUYTypeView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self addViews];
    }
    return self;
}

-(void)addViews{

   _typeLabel = [[UILabel alloc] init];
    _typeLabel.textColor = [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1.0];
    _typeLabel.text = @"行业类型";
    _typeLabel.textAlignment = NSTextAlignmentCenter;
    _typeLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_typeLabel];
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.bottom.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_top);
        make.width.mas_equalTo(80);
    }];
   
    _lineOne = [[UIView alloc] init];
    _lineOne.backgroundColor = [UIColor grayColor];
    [self addSubview:_lineOne];
    [_lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_typeLabel.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.top.mas_equalTo(self.mas_top);
        make.width.mas_equalTo(1.0);
    }];
    
    _lineTwo = [[UIView alloc] init];
    _lineTwo.backgroundColor = [UIColor grayColor];
    [self addSubview:_lineTwo];
    [_lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lineOne.mas_right);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.trailing.mas_equalTo(self);
        make.height.mas_equalTo(0.6);
    }];
    
    CGFloat width = self.frame.size.width / 2;
     _lineThree= [[UIView alloc] init];
    _lineThree.backgroundColor = [UIColor grayColor];
    [self addSubview:_lineThree];
    [_lineThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.top.mas_equalTo(self.mas_top);
        make.width.mas_equalTo(1.0);
        make.centerX.mas_equalTo(width + 40);
    }];
    
    _typeOne = [[TypeView alloc] init];
    _typeOne.titleLabel.text = @"照明设备";
    [self addSubview:_typeOne];
    
    _typeTwo = [[TypeView alloc] init];
    _typeTwo.titleLabel.text = @"照明应用系统";
    [self addSubview:_typeTwo];
    
    _typeThree = [[TypeView alloc] init];
    _typeThree.titleLabel.text = @"装饰照明";
    [self addSubview:_typeThree];
    
    _typeFour = [[TypeView alloc] init];
    _typeFour.titleLabel.text = @"灯罩/灯柱";
    [self addSubview:_typeFour];
    
    [_typeOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_typeLabel.mas_right).offset(2);
        make.top.equalTo(self);
        make.bottom.mas_equalTo(self.mas_centerY).offset(-2);
        make.width.equalTo(_typeTwo);
    }];
    _typeOne.tag = 1465;
    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTypeView:)];
    [_typeOne addGestureRecognizer:tapOne];
    
    
    [_typeTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_typeOne.mas_right).offset(3);
        make.top.equalTo(self);
        make.trailing.equalTo(self);
        make.bottom.mas_equalTo(self.mas_centerY).offset(-2);
        make.width.equalTo(_typeOne);
    }];
    
    _typeTwo.tag = 1467;
    UITapGestureRecognizer *tapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTypeView:)];
    [_typeTwo addGestureRecognizer:tapTwo];
    
    
    [_typeThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_typeLabel.mas_right).offset(2);
        make.top.mas_equalTo(self.mas_centerY).offset(2);
        make.bottom.equalTo(self);
        make.width.equalTo(_typeFour);
    }];
    
    _typeThree.tag = 1468;
    UITapGestureRecognizer *tapThree = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTypeView:)];
    [_typeThree addGestureRecognizer:tapThree];
    
    
    
    
    [_typeFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_typeThree.mas_right).offset(3);
        make.top.equalTo(self.mas_centerY).offset(2);
        make.bottom.mas_equalTo(self);
        make.trailing.equalTo(self);
        make.width.equalTo(_typeThree);
    }];
    
    _typeFour.tag = 1467;
    UITapGestureRecognizer *tapFour = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTypeView:)];
    [_typeFour addGestureRecognizer:tapFour];
    
    

}


-(void)clickTypeView:(id)sender{
    
    UITapGestureRecognizer * singleTap = (UITapGestureRecognizer *)sender;
    NSInteger tag = [singleTap view].tag;
    if ([self.delegate respondsToSelector:@selector(clickViewTag:)]) {
        [self.delegate clickViewTag:tag];
    }
}











@end










