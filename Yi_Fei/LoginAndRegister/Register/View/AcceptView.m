

//
//  AcceptView.m
//  Yi_Fei
//
//  Created by yons on 16/12/26.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "AcceptView.h"

@interface AcceptView ()

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *contentLabel;

@end


@implementation AcceptView



- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addContainView];
    }
    return self;
}

-(void)addContainView{
    
    _selectBtn =[[BackButton alloc] init];
    [_selectBtn setImage:[UIImage imageNamed:@"未接收"] forState:UIControlStateNormal];
    [_selectBtn setImage:[UIImage imageNamed:@"接收"] forState:UIControlStateSelected];

    [self  addSubview:_selectBtn];
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [_selectBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _titleLabel =[[UILabel alloc] init];
    _titleLabel.text = NSLocalizedString(@"recive", nil);
    _titleLabel.font = [UIFont systemFontOfSize:12];
    [self  addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_selectBtn.mas_right).offset(5);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(20);
    }];
    
    _contentLabel =[[UILabel alloc] init];
    _contentLabel.text = NSLocalizedString(@"proticol", nil);
    _contentLabel.textColor = BACKCOLOR;
    _contentLabel.font = [UIFont systemFontOfSize:12];
    [self  addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_right);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(20);
    }];
}

-(void)clickBtn:(UIButton*)btn{
    btn.selected =  !btn.selected;
     if ([self.delegate respondsToSelector:@selector(clickBtn:)]) {
        [self.delegate clickView:btn];
    }
}









@end


