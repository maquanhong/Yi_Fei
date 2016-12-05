//
//  IconTitleTableViewCell.m
//  YiFei
//
//  Created by maquanhong on 10/23/16.
//  Copyright © 2016 yous. All rights reserved.
//

#import "SendDataViewCell.h"


@interface SendDataViewCell ()

@property (nonatomic, strong) TapButton  *iconImageView;
@property (nonatomic, strong ) UILabel      *titleLable;

@property (nonatomic, strong) TapButton  *chooseBtn;
@property (nonatomic, strong ) UILabel      *emailLable;


@end



@implementation SendDataViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViewConstraints];
    }
    return self;
}

- (void)addViewConstraints {
    
    
    _iconImageView=[[TapButton alloc] init];
[_iconImageView setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
[_iconImageView setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    [self addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    _iconImageView.tag = 1500;
    [_iconImageView addTarget:self action:@selector(clickOneBtn:) forControlEvents:UIControlEventTouchUpInside];

    _titleLable =[[UILabel alloc] init];
    _titleLable.text =  @"蓝牙发送";
    _titleLable.textColor=[UIColor blackColor];
    _titleLable.font=[UIFont systemFontOfSize:14.0];
    [_titleLable sizeToFit];
    _titleLable.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_titleLable];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_iconImageView).offset(15);
        make.centerY.mas_equalTo(_iconImageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    _chooseBtn =[[TapButton alloc] init];
    [_chooseBtn setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [_chooseBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    [self addSubview:_chooseBtn];
    [_chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_iconImageView);
        make.top.mas_equalTo(_iconImageView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    _chooseBtn.tag = 1501;
    [_chooseBtn addTarget:self action:@selector(clickTwoBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _emailLable =[[UILabel alloc] init];
    _emailLable.text =  @"Email发送";
    _emailLable.textColor=[UIColor blackColor];
    _emailLable.font=[UIFont systemFontOfSize:14.0];
    [_emailLable sizeToFit];
    _emailLable.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_emailLable];
    [_emailLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_chooseBtn).offset(15);
        make.centerY.mas_equalTo(_chooseBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
}



-(void)clickOneBtn:(UIButton*)sender{
    sender.selected = !sender.selected;
    UIButton *btn =  [self viewWithTag:1501];
    btn.selected = NO;
    if ([self.delegate respondsToSelector:@selector(clickBloothBtn:)]) {
        [self.delegate clickBloothBtn:sender.tag];
    }
}


-(void)clickTwoBtn:(UIButton*)sender{
      sender.selected = !sender.selected;
    UIButton *btn =  [self viewWithTag:1500];
      btn.selected = NO;
    if ([self.delegate respondsToSelector:@selector(clickEmailBtn:)]) {
        [self.delegate clickEmailBtn:sender.tag];
    }
}


@end





















