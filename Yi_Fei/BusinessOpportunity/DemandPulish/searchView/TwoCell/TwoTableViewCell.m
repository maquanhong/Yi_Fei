
//
//  TwoTableViewCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/29.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "TwoTableViewCell.h"

@implementation TwoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubViews];
    }
    return self;
}


-(void)addSubViews{

    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"行业类型";
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(5);
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(75, 20));
    }];
  
    _typeOne = [[ZMJTypeView alloc] init];;
    _typeOne.layer.borderWidth = 1.0;
    _typeOne.nameLabel.text = @"大型机械及设备";
    _typeOne.layer.borderColor = COLOR.CGColor;
    _typeOne.layer.cornerRadius = 5;
    [self addSubview:_typeOne];
    _typeOne.tag = 19000;
    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
    [_typeOne addGestureRecognizer:tapOne];
    
    
    
    _typeTwo = [[ZMJTypeView alloc] init];;
    _typeTwo.layer.borderWidth = 1.0;
    _typeTwo.nameLabel.text = @"动力、电力设备";
    _typeTwo.layer.borderColor = COLOR.CGColor;
    _typeTwo.layer.cornerRadius = 5;
    [self addSubview:_typeTwo];
    
    
    [_typeOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_titleLabel.mas_centerY);
        make.left.mas_equalTo(_titleLabel.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.equalTo(_typeTwo);
    }];
    
    [_typeTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_titleLabel.mas_centerY);
        make.left.mas_equalTo(_typeOne.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.trailing.mas_equalTo(self).offset(-10);
        make.width.equalTo(_typeOne);
    }];
    _typeTwo.tag = 19001;
    UITapGestureRecognizer *tapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
    [_typeTwo addGestureRecognizer:tapTwo];
    
    
    _typeThree = [[ZMJTypeView alloc] init];;
    _typeThree.layer.borderWidth = 1.0;
    _typeThree.nameLabel.text = @"动力设备";
    _typeThree.layer.borderColor = COLOR.CGColor;
    _typeThree.layer.cornerRadius = 5;
    [self addSubview:_typeThree];
    _typeThree.tag = 19002;
    UITapGestureRecognizer *tapThree = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
    [_typeThree addGestureRecognizer:tapThree];
    
    
    _typeFour = [[ZMJTypeView alloc] init];;
    _typeFour.layer.borderWidth = 1.0;
    _typeFour.layer.borderColor = COLOR.CGColor;
    _typeFour.layer.cornerRadius = 5;
    [self addSubview:_typeFour];
    _typeFour.tag = 19003;
    UITapGestureRecognizer *tapFour = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
    [_typeFour addGestureRecognizer:tapFour];
    
    [_typeThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_typeOne.mas_bottom).offset(10);
        make.leading.mas_equalTo(_typeOne);
        make.height.mas_equalTo(30);
        make.width.equalTo(_typeFour);
    }];
    
    [_typeFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_typeThree.mas_centerY);
        make.left.mas_equalTo(_typeThree.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.trailing.mas_equalTo(self).offset(-10);
        make.width.equalTo(_typeThree);
    }];

}


-(void)clickView:(id)sender{

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
