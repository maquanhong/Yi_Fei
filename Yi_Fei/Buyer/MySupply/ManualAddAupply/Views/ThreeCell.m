
//
//  ThreeCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/14.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ThreeCell.h"

@interface ThreeCell ()

@property (nonatomic,strong) UILabel *positionLabel;


@end


@implementation ThreeCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    
    _positionLabel = [[UILabel alloc] init];
    _positionLabel.text = @"担任职位";
    _positionLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_positionLabel];
    [_positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(10);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    

    _typeOneView = [[ZMJTypeView alloc] init];
    _typeOneView.layer.cornerRadius = 5;
    _typeOneView.layer.borderWidth = 1.0;
    _typeOneView.layer.borderColor = BACKCOLOR.CGColor;
    [self addSubview:_typeOneView];
    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTypeView)];
    [_typeOneView addGestureRecognizer:tapOne];
    
    _textFiled = [[UITextField alloc] init];
    _textFiled.layer.cornerRadius = 5;
    _textFiled.layer.borderWidth = 1.0;
    _textFiled.layer.borderColor = BACKCOLOR.CGColor;
    _textFiled.placeholder = @"自定义";
    [self addSubview:_textFiled];
    [_textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_typeOneView.mas_right).offset(10);
        make.centerY.mas_equalTo(self);
        make.trailing.mas_equalTo(self).offset(-10);
        make.height.mas_equalTo(25);
    }];
    
    [_typeOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_positionLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(25);
        make.width.equalTo(_textFiled);
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


-(void)clickTypeView{
    if ([self.delegate respondsToSelector:@selector(clickViewTag)]) {
        [self.delegate clickViewTag];
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


























