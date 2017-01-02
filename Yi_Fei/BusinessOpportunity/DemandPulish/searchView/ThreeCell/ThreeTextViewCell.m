
//
//  ThreeTableViewCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/29.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ThreeTextViewCell.h"

@implementation ThreeTextViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubViews];
    }
    return self;
}

-(void)addSubViews{

    _priceLabel = [[UILabel alloc] init];
    _priceLabel.text = @"价格区间";
    _priceLabel.font = [UIFont systemFontOfSize:14];
    _priceLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(75, 20));
    }];

    _textViewOne = [[UITextView alloc] init];
    _textViewOne.layer.cornerRadius = 5;
     _textViewOne.layer.borderColor = BACKCOLOR.CGColor;
     _textViewOne.layer.borderWidth = 1.0;
     _textViewOne.layer.masksToBounds = YES;
     _textViewOne.font = [UIFont systemFontOfSize:14];
    [self addSubview:_textViewOne];

    _view = [[UIView alloc] init];
    _view.backgroundColor = BACKCOLOR;
    [self addSubview:_view];

    
    _textViewTwo = [[UITextView alloc] init];
    _textViewTwo.layer.cornerRadius = 5;
    _textViewTwo.layer.borderColor = BACKCOLOR.CGColor;
    _textViewTwo.layer.borderWidth = 1.0;
    _textViewTwo.layer.masksToBounds = YES;
    _textViewTwo.font = [UIFont systemFontOfSize:14];
    [self addSubview:_textViewTwo];
    
    
    [_textViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_priceLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(30);
        make.width.equalTo(_textViewTwo);
    }];
    
    [_textViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_view.mas_right).offset(3);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(30);
        make.trailing.mas_equalTo(self).offset(-10);
        make.width.equalTo(_textViewOne);
    }];
    
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_textViewOne.mas_right).offset(3);
        make.right.mas_equalTo(_textViewTwo.mas_left).offset(-3);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(10, 1));
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
