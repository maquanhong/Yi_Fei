//
//  OnlyTitleTableViewCell.m
//  YiFei
//
//  Created by maquanhong on 10/23/16.
//  Copyright © 2016 yous. All rights reserved.
//

#import "OnlyTitleTableViewCell.h"
#import "PureLayout.h"
#import "Macro.h"
@interface OnlyTitleTableViewCell ()

@property (strong, nonatomic) UILabel   *titleLabel;

@end

@implementation OnlyTitleTableViewCell

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




@end
