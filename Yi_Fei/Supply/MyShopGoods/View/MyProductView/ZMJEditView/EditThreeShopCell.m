//
//  EditThreeShopCell.m
//  Yi_Fei
//
//  Created by yons on 16/11/11.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "EditThreeShopCell.h"

@implementation EditThreeShopCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}


-(void)addView{
  
    for (NSInteger i = 0; i < 3; i++) {
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        backView.frame = CGRectMake(0,45 * i, WIDTH, 1);
        [self addSubview:backView];
    }
    
    _oneLabel = [[UILabel alloc] init];
    _oneLabel.text = @"货币类型";
  _oneLabel.font = [UIFont systemFontOfSize:14];
    _oneLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_oneLabel];
    [_oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(15);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 25));
    }];
    
    _typeOneView = [[ZMJTypeView alloc] init];
    _typeOneView.layer.cornerRadius = 5;
    _typeOneView.layer.borderWidth = 1.0;
    _typeOneView.tag = 1300;
    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTypeView:)];
    [_typeOneView addGestureRecognizer:tapOne];
    
    _typeOneView.layer.borderColor = BACKCOLOR.CGColor;
    [self addSubview:_typeOneView];
    [_typeOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_oneLabel.mas_right).offset(15);
        make.centerY.mas_equalTo(_oneLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(110, 25));
    }];
    

    _twoLabel = [[UILabel alloc] init];
    _twoLabel.text = @"价格条款";
    _twoLabel.font = [UIFont systemFontOfSize:14];
    _twoLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_twoLabel];
    [_twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_oneLabel);
        make.top.mas_equalTo(_oneLabel.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(60, 25));
    }];
    
    
    _typeTwoView = [[ZMJTypeView alloc] init];
    _typeTwoView.layer.cornerRadius = 5;
    _typeTwoView.layer.borderWidth = 1.0;
    _typeTwoView.layer.borderColor = BACKCOLOR.CGColor;
    [self addSubview:_typeTwoView];
    [_typeTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_twoLabel.mas_right).offset(15);
        make.centerY.mas_equalTo(_twoLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(110, 25));
    }];
    _typeTwoView.tag = 1301;
    UITapGestureRecognizer *tapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTypeView:)];
    [_typeTwoView addGestureRecognizer:tapTwo];
    
    
    _textFThree = [[UITextField alloc] init];
    _textFThree.layer.cornerRadius = 7;
    _textFThree.layer.borderWidth = 1.0;
    _textFThree.layer.borderColor = BACKCOLOR.CGColor;
    _textFThree.placeholder = @"请输入码头地址";
    _textFThree.textAlignment = NSTextAlignmentCenter;
    _textFThree.font = [UIFont systemFontOfSize:14];
    [self addSubview:_textFThree];
    [_textFThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_typeTwoView.mas_right).offset(10);
        make.centerY.mas_equalTo(_typeTwoView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
    _textFThree.tag = 1302;
    _textFThree.hidden = YES;
}

-(void)clickTypeView:(id)sender{
    UITapGestureRecognizer * singleTap = (UITapGestureRecognizer *)sender;
    NSInteger tag = [singleTap view].tag;
    if ([self.delegate respondsToSelector:@selector(clickViewTag:)]) {
        [self.delegate clickViewTag:tag];
    }
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}













@end
















