//
//  MemberFirstCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/12.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "MemberFirstCell.h"


@interface MemberFirstCell ()

@property (nonatomic,strong)TapButton *selectBtn;

@property (nonatomic,strong)UILabel *nameLableOne;

@property (nonatomic,strong)UILabel *nameLableTwo;



@end


@implementation MemberFirstCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViewConstraints];
    }
    return self;
}

-(void)addViewConstraints{
    
    _selectBtn=[[TapButton alloc] init];
    [_selectBtn setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [_selectBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    [self addSubview:_selectBtn];
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [_selectBtn addTarget:self action:@selector(clicikBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _nameLableOne = [[UILabel alloc] init];
    _nameLableOne.text = @"终身会员";
    _nameLableOne.font = [UIFont systemFontOfSize:14];
    [self addSubview:_nameLableOne];
    [_nameLableOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_selectBtn.mas_right).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(20);
    }];
    
    _typeView = [[ZMJTypeView alloc] init];
    _typeView.layer.cornerRadius = 5;
    _typeView.layer.borderWidth = 1.0;
    _typeView.layer.borderColor = BACKCOLOR.CGColor;
    _typeView.nameLabel.text = @"11.99元";
    [self addSubview:_typeView];
    [_typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.trailing.mas_equalTo(self).offset(-20);
        make.size.mas_equalTo(CGSizeMake(110, 25));
    }];
    
    _nameLableTwo = [[UILabel alloc] init];
    _nameLableTwo.text = @"会费:";
  _nameLableTwo.font=[UIFont systemFontOfSize:14.0];
    [self addSubview:_nameLableTwo];
    [_nameLableTwo mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.mas_equalTo(_typeView.mas_left).offset(-5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(20);
    }];
}


-(void)clicikBtn:(UIButton*)sender{
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(clickButton:index:)]) {
        
        [self.delegate clickButton:sender index:self];
    }
}


































@end













