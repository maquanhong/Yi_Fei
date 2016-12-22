//
//  ThreeOneCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/22.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ThreeOneCell.h"




@implementation ThreeOneCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self addView];
    }
    return self;
}

-(void)addView{
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    
    _typeOne = [[ZMJTypeView alloc]init];
    _typeOne.layer.cornerRadius = 5;
    _typeOne.layer.borderWidth = 1.0;
    _typeOne.layer.borderColor = BACKCOLOR.CGColor;
    [self addSubview:_typeOne];
    [_typeOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_right).offset(10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(110, 25));
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickViewNext:)];
    [_typeOne addGestureRecognizer:tap];
    
    
    _textFiled = [[UITextField alloc]init];
    _textFiled.layer.cornerRadius = 5;
    _textFiled.layer.borderWidth = 1.0;
    _textFiled.layer.borderColor = BACKCOLOR.CGColor;
    [self addSubview:_textFiled];
    [_textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_typeOne.mas_right).offset(10);
        make.centerY.equalTo(self);
        make.trailing.equalTo(self).offset(-10);
        make.height.mas_equalTo(20);
    }];
    _textFiled.hidden = YES;
    
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
}


-(void)clickViewNext:(id)sender{

    UITapGestureRecognizer * singleTap = (UITapGestureRecognizer *)sender;
    NSInteger index = [singleTap view].tag;
    if ([self.delegate respondsToSelector:@selector(clickView:)]) {
        [self.delegate clickView:index];
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








