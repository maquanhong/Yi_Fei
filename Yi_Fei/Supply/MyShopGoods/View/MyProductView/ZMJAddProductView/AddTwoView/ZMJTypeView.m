//
//  ZMJTypeView.m
//  Yi_Fei
//
//  Created by yons on 16/11/9.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ZMJTypeView.h"

@interface ZMJTypeView ()

@property(nonatomic,strong)UIImageView *listImageView;

@property(nonatomic,strong)UIView *lineView;

@end

@implementation ZMJTypeView


- (instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self createSubView];
    return  self;
}

-(void)createSubView{

    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textColor = BACKCOLOR;
    [self addSubview:_nameLabel];
 


    _listImageView = [[UIImageView alloc] init];
    _listImageView.image= [UIImage imageNamed:@"xiala"];
    [self addSubview:_listImageView];
 
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = BACKCOLOR;
    [self addSubview:_lineView];
  
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
















