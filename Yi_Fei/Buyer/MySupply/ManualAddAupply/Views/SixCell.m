//
//  SixCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/14.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "SixCell.h"

@interface SixCell ()

@property (nonatomic,strong) UILabel *companyLabel;


@end


@implementation SixCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    
    _companyLabel = [[UILabel alloc] init];
    _companyLabel.text = @"公司地址";
    _companyLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_companyLabel];
    [_companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(10);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    _typeOneView = [[ZMJTypeView alloc] init];
    _typeOneView.layer.cornerRadius = 5;
    _typeOneView.layer.borderWidth = 1.0;
    _typeOneView.layer.borderColor = BACKCOLOR.CGColor;
    _typeOneView.nameLabel.text = @"中国";
    _typeOneView.tag = 5500;
    [self addSubview:_typeOneView];
    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTypeView:)];
    [_typeOneView addGestureRecognizer:tapOne];
    
    _typeTwoView = [[ZMJTypeView alloc] init];
    _typeTwoView.layer.cornerRadius = 5;
    _typeTwoView.layer.borderWidth = 1.0;
    _typeTwoView.layer.borderColor = BACKCOLOR.CGColor;
    _typeTwoView.tag = 5501;
    _typeTwoView.nameLabel.text = @"北京";
    [self addSubview:_typeTwoView];
    UITapGestureRecognizer *tapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTypeView:)];
    [_typeTwoView addGestureRecognizer:tapTwo];
    
    
    [_typeOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_companyLabel.mas_right).offset(10);
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
    _typeThreeView.layer.cornerRadius = 5;
    _typeThreeView.layer.borderWidth = 1.0;
    _typeThreeView.layer.borderColor = BACKCOLOR.CGColor;
    _typeThreeView.tag = 5502;
    _typeThreeView.nameLabel.text = @"东城";
    [self addSubview:_typeThreeView];
    UITapGestureRecognizer *tapThree = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTypeView:)];
    [_typeThreeView addGestureRecognizer:tapThree];
    
    
    _typeFourView = [[ZMJTypeView alloc] init];
    _typeFourView.layer.cornerRadius = 5;
    _typeFourView.layer.borderWidth = 1.0;
    _typeFourView.layer.borderColor = BACKCOLOR.CGColor;
    _typeFourView.tag = 5503;
    [self addSubview:_typeFourView];
    UITapGestureRecognizer *tapFour = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTypeView:)];
    [_typeFourView addGestureRecognizer:tapFour];
    
    
    [_typeThreeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_typeOneView);
        make.top.equalTo(_typeOneView.mas_bottom).offset(5);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(_typeFourView);
    }];
    
    [_typeFourView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_typeThreeView.mas_right).offset(10);
        make.centerY.equalTo(_typeThreeView);
        make.height.mas_equalTo(25);
        make.trailing.equalTo(self).offset(-10);
    }];
    
    
    _addressText = [[UITextField alloc] init];
    _addressText.layer.cornerRadius = 5;
    _addressText.layer.borderWidth = 1.0;
    _addressText.layer.borderColor = BACKCOLOR.CGColor;
    _addressText.placeholder = @"详细地址";
    [self addSubview:_addressText];
    [_addressText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_typeThreeView);
        make.trailing.mas_equalTo(self).offset(-10);
        make.top.equalTo(_typeThreeView.mas_bottom).offset(5);
        make.height.mas_equalTo(25);
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
    if ([self.delegate respondsToSelector:@selector(clickViewTag:)]) {
        [self.delegate clickViewTag:tag];
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




















