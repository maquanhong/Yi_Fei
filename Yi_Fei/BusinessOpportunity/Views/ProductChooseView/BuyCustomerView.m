//
//  BuyCustomerView.m
//  Yi_Fei
//
//  Created by yons on 16/11/18.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "BuyCustomerView.h"

@interface BuyCustomerView ()

@property(nonatomic,strong)UIImageView *listImageView;

@property(nonatomic,strong)UIView *lineView;

@end


@implementation BuyCustomerView


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
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.trailing.mas_equalTo(self).offset(-22);
        make.height.mas_equalTo(25);
    }];
    
    
    _listImageView = [[UIImageView alloc] init];
    _listImageView.image= [UIImage imageNamed:@"xiala"];
    [self addSubview:_listImageView];
    [_listImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).offset(2);
        make.trailing.mas_equalTo(self).offset(-5);
        make.size.mas_equalTo(CGSizeMake(11, 8));
    }];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = BACKCOLOR;
    [self addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_right);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(_listImageView.mas_left).offset(-5);
        make.height.mas_equalTo(self.mas_height);
    }];

    
}






























@end
