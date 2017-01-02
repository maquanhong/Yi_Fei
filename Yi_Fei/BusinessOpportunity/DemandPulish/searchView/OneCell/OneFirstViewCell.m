//
//  OneFirstViewCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/28.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.

#import "OneFirstViewCell.h"


@implementation OneFirstViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubView];
    }
   return self;
}

-(void)addSubView{

    _titleLabel =[[UILabel alloc] init];
    _titleLabel.font=[UIFont systemFontOfSize:14.0];
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(75);
    }];

    _typeView = [TypeListView  instanceTypeListView];
    _typeView.userInteractionEnabled = YES;
    _typeView.layer.cornerRadius = 5;
    _typeView.layer.borderWidth = 1.0;
    _typeView.layer.borderColor = BACKCOLOR.CGColor ;
    [self addSubview:_typeView];
    [_typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(30);
        make.trailing.mas_equalTo(self).offset(-10);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    [ _typeView.backView  addGestureRecognizer:tap];
}

-(void)click{
    if ([self.delegate respondsToSelector:@selector(clickViewCell:)]) {
        [self.delegate clickViewCell:self];
    }
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
