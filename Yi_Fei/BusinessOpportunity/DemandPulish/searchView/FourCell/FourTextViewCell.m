

//
//  FourTextViewCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/29.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "FourTextViewCell.h"

@implementation FourTextViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubViews];
    }
    return self;
}

-(void)addSubViews{

        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"商品简介";
        _titleLabel.font = [UIFont systemFontOfSize:14];
      _titleLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self).offset(5);
            make.top.mas_equalTo(self.mas_top).offset(10);
            make.size.mas_equalTo(CGSizeMake(75, 20));
        }];
        

    _textView = [[UITextView alloc] init];
    _textView.layer.cornerRadius = 5;
    _textView.layer.borderWidth = 1.0;
    _textView.layer.borderColor = BACKCOLOR.CGColor;
    _textView.font = [UIFont systemFontOfSize:14];
    [self addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_right).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
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
