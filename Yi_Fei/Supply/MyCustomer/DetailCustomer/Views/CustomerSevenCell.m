//
//  CustomerSevenCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/19.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "CustomerSevenCell.h"

@interface CustomerSevenCell ()



@end

@implementation CustomerSevenCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViewConstraints];
    }
    return self;
}

- (void)addViewConstraints {

    _titleLabel  = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    _contentLabel  = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    
}













@end












