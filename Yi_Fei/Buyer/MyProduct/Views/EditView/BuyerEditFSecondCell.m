//
//  BuyerEditFSecondCell.m
//  Yi_Fei
//
//  Created by yons on 16/11/24.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "BuyerEditFSecondCell.h"

@interface BuyerEditFSecondCell ()

@property(nonatomic,strong)UIImageView *iconImageView;

@property(nonatomic,strong)UILabel *paramLabel;

@property(nonatomic,strong)UILabel *englishLabel;

@property(nonatomic,strong)UIView *line;

@property(nonatomic,strong)UILabel *contentLabel;

@end



@implementation BuyerEditFSecondCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addView];
    }
    return self;
}


-(void)addView{
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 10 ;
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(10);
        make.trailing.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
    }];
    
    _iconImageView= [[UIImageView alloc] init];
    _iconImageView.image = [UIImage imageNamed:@"kehu_icon"];
    [backView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(backView).offset(10);
        make.top.mas_equalTo(backView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _paramLabel = [[UILabel alloc] init];
    _paramLabel.text = @"商品介绍";
    [backView addSubview:_paramLabel];
    [_paramLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(_iconImageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    
    _englishLabel = [[UILabel alloc] init];
    _englishLabel.text = @"Introduce";
    _englishLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:_englishLabel];
    [_englishLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_paramLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(_paramLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor grayColor];
    [backView addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(backView);
        make.trailing.mas_equalTo(backView);
        make.top.mas_equalTo(_iconImageView.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(backView).offset(10);
        make.top.mas_equalTo(_line.mas_bottom).offset(10);
        make.trailing.mas_equalTo(backView).offset(-10);
    }];
    
    
}




@end
















