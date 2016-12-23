//
//  BuyerAskCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/21.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "BuyerAskCell.h"
#import "myShopView.h"

@interface BuyerAskCell ()

@property (nonatomic,strong) UILabel *priceLabel;

@property (nonatomic,strong) UIButton *deleteBtn;

@property (nonatomic,strong) UIButton *editBtn;

@end


@implementation BuyerAskCell


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
    
    
    _price  = [[UILabel alloc] init];
    _price.font = [UIFont systemFontOfSize:14];
    _price.textColor = PRICECOLOR;
    [self addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_priceLabel.mas_right);
        make.centerY.equalTo(_priceLabel);
        make.trailing.equalTo(self).offset(-10);
        make.height.mas_equalTo(25);
    }];

    
    _editBtn  = [[UIButton alloc] init];
    [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _editBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _editBtn.layer.cornerRadius  =  5;
    _editBtn.layer.borderWidth = 1.0;
    _editBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:_editBtn];
    _editBtn.tag = 1280;
    [_editBtn addTarget:self action:@selector(clickBtnNext:) forControlEvents:UIControlEventTouchUpInside];
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_priceLabel);
        make.bottom.equalTo(_iconImageView);
        make.size.mas_equalTo(CGSizeMake(75, 25));
    }];
    
    
    _deleteBtn  = [[UIButton alloc] init];
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _deleteBtn.layer.cornerRadius  =  5;
    _deleteBtn.layer.borderWidth = 1.0;
    _deleteBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [_deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:_deleteBtn];
    _deleteBtn.tag = 1281;
    [_deleteBtn addTarget:self action:@selector(clickBtnNext:) forControlEvents:UIControlEventTouchUpInside];

    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_editBtn.mas_right).offset(10);
        make.centerY.equalTo(_editBtn);
        make.size.mas_equalTo(CGSizeMake(75, 25));
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
        case 1280:
        {
    if ([self.delegate respondsToSelector:@selector(clickcell:num:)]) {
        [self.delegate clickcell:self num:1280];
    }
        }
            break;
        case 1281:
        {
    if ([self.delegate respondsToSelector:@selector(clickcell:num:)]) {
        [self.delegate clickcell:self num:1281];
    }
        }
            break;
        default:
            break;
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
