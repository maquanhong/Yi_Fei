//
//  CustomerFourCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/19.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "CustomerFourCell.h"
#import <PureLayout/PureLayout.h>

@interface CustomerFourCell ()

@property (strong, nonatomic) UILabel   *titleLabel;

@end


@implementation CustomerFourCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViewConstraints];
    }
    return self;
}

- (void)addViewConstraints {
    
    _titleLabel  = [[UILabel alloc] init];
    _titleLabel.text = @"商品备注:";
    _titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    _discrible  = [[UILabel alloc] init];
    _discrible.font = [UIFont systemFontOfSize:14];
    _discrible.numberOfLines = 0;
    [self addSubview:_discrible];
    [_discrible mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_right).offset(10);
        make.top.mas_equalTo(_titleLabel.mas_top);
        make.trailing.mas_equalTo(self).offset(-10);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
    }];
}







































- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
