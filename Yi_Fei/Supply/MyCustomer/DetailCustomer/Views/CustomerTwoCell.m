//
//  CustomerTwoCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/19.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "CustomerTwoCell.h"

@interface CustomerTwoCell ()

@property (nonatomic, strong) UILabel *oneLabel;
@property (nonatomic, strong) UILabel *twoLabel;
@property (nonatomic, strong) UILabel *threeLabel;
@property (nonatomic, strong) UILabel *fourLabel;
@property (nonatomic, strong) UILabel *fiveLabel;
@property (nonatomic, strong) UILabel *sixLabel;
@property (nonatomic, strong) UILabel *sevenLabel;


@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *telLabel;
@property (nonatomic, strong) UILabel *postionLabel;
@property (nonatomic, strong) UILabel *emailLabel;
@property (nonatomic, strong) UILabel *companyLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *careerLabel;


@end



@implementation CustomerTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addViewConstraints];
    }
    return self;
    
}

- (void)addViewConstraints {
    
    _oneLabel = [[UILabel alloc] init];
    _oneLabel.text = @"姓   名:";
    _oneLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_oneLabel];
    [_oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    _twoLabel = [[UILabel alloc] init];
    _twoLabel.text = @"职   位:";
    _twoLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_twoLabel];
    [_twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_oneLabel);
        make.top.mas_equalTo(_oneLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    _threeLabel = [[UILabel alloc] init];
    _threeLabel.text = @"公司名称:";
    _threeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_threeLabel];
    [_threeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_twoLabel);
        make.top.mas_equalTo(_twoLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    _fourLabel = [[UILabel alloc] init];
    _fourLabel.text = @"地   址:";
    _fourLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_fourLabel];
    [_fourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_threeLabel);
        make.top.mas_equalTo(_threeLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    _fiveLabel = [[UILabel alloc] init];
    _fiveLabel.text = @"行业类型:";
    _fiveLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_fiveLabel];
    [_fiveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_fourLabel);
        make.top.mas_equalTo(_fourLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    _sixLabel = [[UILabel alloc] init];
    _sixLabel.text = @"电  话:";
    _sixLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_sixLabel];
    [_sixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 20));;
    }];
    _sevenLabel = [[UILabel alloc] init];
    _sevenLabel.text = @"邮   箱";
    _sevenLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_sevenLabel];
    [_sevenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_sixLabel);
        make.top.mas_equalTo(_sixLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textColor = [UIColor grayColor];
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_oneLabel.mas_right).offset(10);
        make.centerY.equalTo(_oneLabel);
        make.right.equalTo(_sixLabel.mas_left).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    _telLabel = [[UILabel alloc] init];
    _telLabel.font = [UIFont systemFontOfSize:14];
    _telLabel.textColor = [UIColor grayColor];
    [self addSubview:_telLabel];
    [_telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sixLabel.mas_right).offset(10);
        make.trailing.equalTo(self).offset(-10);
        make.height.mas_equalTo(20);
        make.centerY.equalTo(_sixLabel);
        
    }];
    
    
    _postionLabel = [[UILabel alloc] init];
    _postionLabel.font = [UIFont systemFontOfSize:14];
    _postionLabel.textColor = [UIColor grayColor];
    [self addSubview:_postionLabel];
    [_postionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_twoLabel.mas_right).offset(10);
        make.centerY.equalTo(_twoLabel);
        make.right.equalTo(_sevenLabel.mas_left).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    
    
    _emailLabel = [[UILabel alloc] init];
    _emailLabel.font = [UIFont systemFontOfSize:14];
    _emailLabel.textColor = [UIColor grayColor];
    [self addSubview:_emailLabel];
    [_emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sevenLabel.mas_right).offset(10);
        make.centerY.equalTo(_sevenLabel);
        make.trailing.equalTo(_sevenLabel).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    _companyLabel = [[UILabel alloc] init];
    _companyLabel.font = [UIFont systemFontOfSize:14];
    _companyLabel.textColor = [UIColor grayColor];
    [self addSubview:_companyLabel];
    [_companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_threeLabel.mas_right).offset(10);
        make.centerY.equalTo(_threeLabel);
        make.trailing.equalTo(self).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    
    _addressLabel = [[UILabel alloc] init];
    _addressLabel.font = [UIFont systemFontOfSize:14];
    _addressLabel.textColor = [UIColor grayColor];
    [self addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_fourLabel.mas_right).offset(10);
        make.centerY.equalTo(_fourLabel);
        make.trailing.equalTo(self).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    _careerLabel = [[UILabel alloc] init];
    _careerLabel.font = [UIFont systemFontOfSize:14];
    _careerLabel.numberOfLines = 0;
    _careerLabel.textColor = [UIColor grayColor];
    [self addSubview:_careerLabel];
    [_careerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_fiveLabel.mas_right).offset(10);
        make.centerY.equalTo(_fiveLabel);
        make.trailing.equalTo(self).offset(-10);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [ UIColor groupTableViewBackgroundColor];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
}

- (void)setModel:(CustomerModel *)model{
    
    if (model.customerName.length > 0) {
        _nameLabel.text = model.customerName ;
    }else{
        _nameLabel.text = @"";
    }
    if (model.phone.length > 0) {
        _telLabel.text = model.phone ;
    }else{
        _telLabel.text = @"" ;
    }
    
    if (model.position.length > 0) {
        _postionLabel.text = model.position ;
    }else{
        _postionLabel.text = @"";
    }
    
    if (model.emailAddress.length > 0) {
        _emailLabel.text = model.emailAddress ;
    }else{
        _emailLabel.text = @"";
    }
    
    
    if (model.companyName.length > 0) {
        _companyLabel.text = model.companyName ;
    }else{
        _companyLabel.text = @"" ;
    }
    
    if (model.companyAddress.length > 0) {
        _addressLabel.text = model.companyAddress ;
    }else{
        _addressLabel.text = @"" ;
    }
    
    if (model.industryType.length > 0) {
        _careerLabel.text = model.industryType ;
    }else{
        _careerLabel.text = @"" ;
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
