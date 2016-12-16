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
        for(UIView *sub in self.contentView.subviews)
            [sub removeFromSuperview];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self addView];
    }
    return self;
}


-(void)addView{
    
    //选择按钮
    self.selectBtn=[[UIButton alloc]init];
    [self.selectBtn setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [self .selectBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    [self addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    //默认隐藏
    self.selectBtn.hidden=YES;
    
    _iconImageView  = [[UIImageView alloc] init];
    [self addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(30);
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
    
    _priceLabel  =   [myShopView creatLableWithBgColor:nil borderColor:[UIColor whiteColor] borderWidth:0 titleColor:[UIColor blackColor] text:@"价格"];
    _priceLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_titleLabel);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(35, 20));
    }];
    
   
    

    _prepareBtn  = [[UIButton alloc] init];
    [_prepareBtn setTitle:@"预留询价" forState:UIControlStateNormal];
[_prepareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _prepareBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _prepareBtn.layer.cornerRadius  =  5;
    _prepareBtn.layer.borderWidth = 1.0;
    _prepareBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:_prepareBtn];
    _prepareBtn.tag = 1250;
    [_prepareBtn addTarget:self action:@selector(clickBtnNext:) forControlEvents:UIControlEventTouchUpInside];
    
    _leaveBtn  = [[UIButton alloc] init];
    [_leaveBtn setTitle:@"留样询价" forState:UIControlStateNormal];
    [_leaveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _leaveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _leaveBtn.layer.cornerRadius  =  5;
    _leaveBtn.layer.borderWidth = 1.0;
    _leaveBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:_leaveBtn];
    _leaveBtn.tag = 1251;
    [_leaveBtn addTarget:self action:@selector(clickBtnNext:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _editBtn  = [[UIButton alloc] init];
    [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _editBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _editBtn.layer.cornerRadius  =  5;
    _editBtn.layer.borderWidth = 1.0;
    _editBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:_editBtn];
    _editBtn.tag = 1252;
    [_editBtn addTarget:self action:@selector(clickBtnNext:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _price  = [[UILabel alloc] init];
    [self addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_priceLabel.mas_right);
        make.centerY.equalTo(_priceLabel);
        make.trailing.equalTo(self).offset(-10);
        make.height.mas_equalTo(25);
    }];
    
    [_prepareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_titleLabel);
        make.bottom.equalTo(_iconImageView.mas_bottom);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(@[_leaveBtn,_editBtn]);
    }];
    
    [_leaveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_prepareBtn.mas_right).offset(5);
        make.centerY.equalTo(_prepareBtn.mas_centerY);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(@[_prepareBtn,_editBtn]);
    }];
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_leaveBtn.mas_right).offset(5);
        make.centerY.equalTo(_leaveBtn.mas_centerY);
        make.trailing.mas_equalTo(self).offset(-5);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(@[_prepareBtn,_editBtn]);
    }];
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.leading.mas_equalTo(self);
        make.trailing.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];

}


-(void)clickBtnNext:(UIButton*)sender{
    
    NSInteger _index = sender.tag;
    switch (_index) {
        case 1250:
        {
    if ([self.delegate respondsToSelector:@selector(clickcell:num:)]) {
        [self.delegate clickcell:self num:1250];
    }
        }
            break;
        case 1251:
        {
    if ([self.delegate respondsToSelector:@selector(clickcell:num:)]) {
        [self.delegate clickcell:self num:1251];
    }
        }
            break;
        case 1252:
        {
    if ([self.delegate respondsToSelector:@selector(clickcell:num:)]) {
        [self.delegate clickcell:self num:1252];
    }
        }
            break;
            
        default:
            break;
    }
}














- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end


















