//
//  MemberViewCell.m
//  Yi_Fei
//
//  Created by yons on 16/11/24.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "MemberOneViewCell.h"

@interface MemberOneViewCell ()


@property (nonatomic, strong ) UILabel   *titleLable;

@property (nonatomic, strong ) UILabel   *nameLable;

@property (nonatomic, strong ) UILabel   *priceLable;

@end


@implementation MemberOneViewCell



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
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [_iconImageView addTarget:self action:@selector(clicikBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _titleLable =[[UILabel alloc] init];
    _titleLable.textColor=[UIColor blackColor];
    _titleLable.font=[UIFont systemFontOfSize:14.0];
    [_titleLable sizeToFit];
    _titleLable.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_titleLable];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];


    _priceLable =[[UILabel alloc] init];
    _priceLable.textColor=[UIColor brownColor];
    _priceLable.font=[UIFont systemFontOfSize:14.0];
    [_priceLable sizeToFit];
    _priceLable.textAlignment = NSTextAlignmentRight;
    [self addSubview:_priceLable];
    [_priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self).offset(-15);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(20);
    }];

    
    _nameLable =[[UILabel alloc] init];
    _nameLable.text = @"会费:";
    _nameLable.font=[UIFont systemFontOfSize:14.0];
    [_nameLable sizeToFit];
    _nameLable.textAlignment = NSTextAlignmentRight;
    [self addSubview:_nameLable];
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_priceLable.mas_left).offset(-5);
        make.centerY.mas_equalTo(_priceLable.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    
    
}


- (void)setDict:(NSDictionary *)dict{

    _titleLable.text = dict[@"name"];
    _priceLable.text = dict[@"price"];

}





-(void)clicikBtn:(UIButton*)sender{
    
    if ([self.delegate respondsToSelector:@selector(clickButton:index:)]) {
        
        [self.delegate clickButton:sender index:self];
    }
}



















@end





















