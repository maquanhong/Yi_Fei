//
//  AskPriceCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/13.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "AskPriceCell.h"
#import "myShopView.h"

@interface AskPriceCell ()


@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIButton *prepareBtn;
@property (nonatomic,strong) UIButton *leaveBtn;
@property (nonatomic,strong) UIButton *editBtn;

@end

@implementation AskPriceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addView];
    }
    return self;
}


-(void)addView{
    
    _iconImageView  = [[UIImageView alloc] init];
    [self addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];

    _titleLabel  = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImageView.mas_right).offset(10);
        make.top.mas_equalTo(_iconImageView.mas_top);
        make.trailing.mas_equalTo(self).offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    _priceLabel  =   [myShopView creatLableWithBgColor:[UIColor whiteColor] borderColor:[UIColor whiteColor] borderWidth:0 titleColor:[UIColor blackColor] text:@"价格"];
    _priceLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_titleLabel);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    _price  = [[UILabel alloc] init];
    [self addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_priceLabel.mas_right);
        make.centerY.equalTo(_price);
        make.trailing.equalTo(self).offset(-10);
        make.height.mas_equalTo(20);
    }];
    

    _prepareBtn  = [[UIButton alloc] init];
    [_prepareBtn setTitle:@"预留询价" forState:UIControlStateNormal];
[_prepareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _prepareBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _prepareBtn.layer.cornerRadius  =  5;
    _prepareBtn.layer.borderWidth = 1.0;
    _prepareBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:_prepareBtn];
    [_prepareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_titleLabel);
        make.bottom.equalTo(_iconImageView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(60, 20));
        
    }];
    
    _leaveBtn  = [[UIButton alloc] init];
    [_leaveBtn setTitle:@"留样询价" forState:UIControlStateNormal];
    [_leaveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _leaveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _leaveBtn.layer.cornerRadius  =  5;
    _leaveBtn.layer.borderWidth = 1.0;
    _leaveBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:_leaveBtn];
    [_leaveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_prepareBtn.mas_right).offset(10);
        make.centerY.equalTo(_prepareBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    _editBtn  = [[UIButton alloc] init];
    [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _editBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _editBtn.layer.cornerRadius  =  5;
    _editBtn.layer.borderWidth = 1.0;
    _editBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:_editBtn];
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_leaveBtn.mas_right).offset(10);
        make.centerY.equalTo(_leaveBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 20));
        
    }];
    



}

















- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end


















