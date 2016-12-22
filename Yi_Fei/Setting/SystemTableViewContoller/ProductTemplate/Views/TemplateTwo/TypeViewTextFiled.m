

//
//  TypeViewTextFiled.m
//  Yi_Fei
//
//  Created by yons on 16/12/22.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "TypeViewTextFiled.h"

@interface TypeViewTextFiled ()

@property(nonatomic,strong)UIImageView *listImageView;

@property(nonatomic,strong)UIView *lineView;

@end


@implementation TypeViewTextFiled


- (instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self createSubView];
    return  self;
}

-(void)createSubView{
    
    _textFiled = [[UITextField alloc] init];
    _textFiled.textAlignment = NSTextAlignmentCenter;
    _textFiled.font = [UIFont systemFontOfSize:14];
    _textFiled.textColor = BACKCOLOR;
    [self addSubview:_textFiled];
    
    
    
    _listImageView = [[UIImageView alloc] init];
    _listImageView.image= [UIImage imageNamed:@"xiala"];
    [self addSubview:_listImageView];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = BACKCOLOR;
    [self addSubview:_lineView];
    
    
    [_textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(_lineView.mas_left).offset(5);
        make.height.mas_equalTo(25);
    }];
    
    [_listImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).offset(2);
        make.trailing.mas_equalTo(self).offset(-3);
        make.size.mas_equalTo(CGSizeMake(10, 8));
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self).offset(-15);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(self.mas_height);
    }];
}





@end
