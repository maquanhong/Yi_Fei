//
//  SevenCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/14.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "SevenCell.h"

@interface SevenCell ()

@property (nonatomic,strong) UILabel *industryType;

@end

@implementation SevenCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    
    _industryType = [[UILabel alloc] init];
    _industryType.text = @"行业类型";
    _industryType.font = [UIFont systemFontOfSize:14];
    [self addSubview:_industryType];
    [_industryType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(10);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    _typeOneView = [[ZMJTypeView alloc] init];
    _typeOneView.nameLabel.text = @"大型机械及设备";
    _typeOneView.layer.cornerRadius = 5;
    _typeOneView.layer.borderWidth = 1.0;
    _typeOneView.layer.borderColor = BACKCOLOR.CGColor;
    [self addSubview:_typeOneView];
     _typeOneView.tag = 5600;
    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTypeView:)];
    [_typeOneView addGestureRecognizer:tapOne];
    
    
    _typeTwoView = [[ZMJTypeView alloc] init];
    _typeTwoView.nameLabel.text = @"动力、电力设备";
    _typeTwoView.layer.cornerRadius = 5;
    _typeTwoView.layer.borderWidth = 1.0;
    _typeTwoView.layer.borderColor = BACKCOLOR.CGColor;
    [self addSubview:_typeTwoView];
    _typeTwoView.tag = 5601;
    UITapGestureRecognizer *tapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTypeView:)];
    [_typeTwoView addGestureRecognizer:tapTwo];
    
    
    [_typeOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_industryType.mas_right).offset(10);
        make.top.mas_equalTo(self).offset(10);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(_typeTwoView);
    }];
    
    [_typeTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_typeOneView.mas_right).offset(10);
        make.trailing.mas_equalTo(self).offset(-10);
        make.centerY.equalTo(_typeOneView);
        make.height.mas_equalTo(25);
    }];
    
    
    _typeThreeView = [[ZMJTypeView alloc] init];
    _typeThreeView.nameLabel.text = @"动力设备";
    _typeThreeView.layer.cornerRadius = 5;
    _typeThreeView.layer.borderWidth = 1.0;
    _typeThreeView.layer.borderColor = BACKCOLOR.CGColor;
    [self addSubview:_typeThreeView];
    _typeThreeView.tag = 5602;
    UITapGestureRecognizer *tapThree = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTypeView:)];
    [_typeThreeView addGestureRecognizer:tapThree];
    
    
    _otherText = [[UITextField alloc] init];
    _otherText.layer.cornerRadius = 5;
    _otherText.layer.borderWidth = 1.0;
    _otherText.layer.borderColor = BACKCOLOR.CGColor;
    _otherText.font = [UIFont systemFontOfSize:14];
    _otherText.placeholder = @"其他";
    [self addSubview:_otherText];
  
    [_typeThreeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_typeOneView);
        make.top.equalTo(_typeOneView.mas_bottom).offset(5);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(_otherText);
    }];
    
    [_otherText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_typeThreeView.mas_right).offset(10);
        make.centerY.equalTo(_typeThreeView);
        make.height.mas_equalTo(25);
        make.trailing.equalTo(self).offset(-10);
    }];
    

    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self);
        make.trailing.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(1);
    }];
}





-(void)clickTypeView:(id)sender{
    UITapGestureRecognizer * singleTap = (UITapGestureRecognizer *)sender;
    NSInteger tag = [singleTap view].tag;
    if ([self.delegate respondsToSelector:@selector(clickViewnumber:)]) {
        [self.delegate clickViewnumber:tag];
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
