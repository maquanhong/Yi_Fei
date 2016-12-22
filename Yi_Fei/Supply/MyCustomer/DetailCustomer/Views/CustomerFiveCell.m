//
//  CustomerFiveCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/19.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "CustomerFiveCell.h"

@interface CustomerFiveCell ()

@property (nonatomic,strong) UILabel *titleOneLabel;
@property (nonatomic,strong) UILabel *titleTwoLabel;
@property (nonatomic,strong) UILabel *titleThreeLabel;
@property (nonatomic,strong) UILabel *titleFourLabel;
@property (nonatomic,strong) UILabel *titleFiveLabel;
@property (nonatomic,strong) UILabel *titleSixLabel;
@property (nonatomic,strong) UILabel *titleSevenLabel;


@property (nonatomic,strong) UIButton *returnBtn;

@end


@implementation CustomerFiveCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViewConstraints];
    }
    return self;
}

- (void)addViewConstraints {
    
    _titleOneLabel  = [[UILabel alloc] init];
    _titleOneLabel.text = @"商品:";
    _titleOneLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titleOneLabel];

 

    _titleTwoLabel  = [[UILabel alloc] init];
    _titleTwoLabel.text = @"规格:";
    _titleTwoLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titleTwoLabel];

    
    
    _titleThreeLabel  = [[UILabel alloc] init];
    _titleThreeLabel.text = @"尺寸:";
    _titleThreeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titleThreeLabel];
    [_titleThreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_titleTwoLabel);
        make.top.mas_equalTo(_titleTwoLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    
    _titleFourLabel  = [[UILabel alloc] init];
    _titleFourLabel.text = @"数量:";
    _titleFourLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titleFourLabel];
    [_titleFourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_titleThreeLabel);
        make.top.mas_equalTo(_titleThreeLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    
    
    _titleFiveLabel  = [[UILabel alloc] init];
    _titleFiveLabel.text = @"备注:";
    _titleFiveLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titleFiveLabel];
    [_titleFiveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.equalTo(_titleFourLabel);
    make.top.mas_equalTo(_titleFourLabel.mas_bottom).offset(10);
    make.size.mas_equalTo(CGSizeMake(40, 20));
    }];

    _titleSixLabel  = [[UILabel alloc] init];
    _titleSixLabel.text = @"材质:";
    _titleSixLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titleSixLabel];
    
    
    

    
    _titleSevenLabel  = [[UILabel alloc] init];
    _titleSevenLabel.text = @"颜色:";
    _titleSevenLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titleSevenLabel];
    
    
    
    _titleEightLabel  = [[UILabel alloc] init];
    _titleEightLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titleEightLabel];
   
    
    
    
    [_titleOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    
    [_titleTwoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_titleOneLabel);
        make.top.mas_equalTo(_titleOneLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    
    
    
    
    
    
    _detailOneLabel  = [[UILabel alloc] init];
    _detailOneLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_detailOneLabel];
    [_detailOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleOneLabel.mas_right).offset(10);
        make.right.mas_equalTo(_titleEightLabel.mas_left).offset(-10);
        make.centerY.equalTo(_titleOneLabel);
        make.height.mas_equalTo( 20);
    }];
    
    
    [_titleEightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    
    _detailTwoLabel  = [[UILabel alloc] init];
    _detailTwoLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_detailTwoLabel];
    [_detailTwoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.right.mas_equalTo(_titleSixLabel.mas_left).offset(-10);
      make.left.mas_equalTo(_titleTwoLabel.mas_right).offset(10);
      make.centerY.equalTo(_titleTwoLabel);
      make.height.mas_equalTo( 20);
    }];

    
    [_titleSixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.mas_equalTo(_detailTwoLabel);
        make.left.mas_equalTo(_detailTwoLabel.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    
    
    
    _detailThreeLabel  = [[UILabel alloc] init];
    _detailThreeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_detailThreeLabel];
    [_detailThreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_titleSevenLabel.mas_left).offset(-10);
        make.left.mas_equalTo(_titleThreeLabel.mas_right).offset(10);
        make.centerY.equalTo(_titleThreeLabel);
        make.height.mas_equalTo( 20);
    }];


    [_titleSevenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_titleSixLabel);
        make.centerY.equalTo(_titleThreeLabel);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];

    
    
    _detailFourLabel  = [[UILabel alloc] init];
    _detailFourLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_detailFourLabel];
    [_detailFourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleFourLabel.mas_right).offset(10);
        make.centerY.equalTo(_titleFourLabel);
        make.trailing.equalTo(self).offset(-10);
        make.height.mas_equalTo( 20);
    }];
    
    
    
    
    _returnBtn  = [[UIButton alloc] init];
    [_returnBtn setTitle:@"回复" forState:UIControlStateNormal];
    _returnBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_returnBtn setTitleColor:BACKCOLOR forState:UIControlStateNormal];
    _returnBtn.layer.cornerRadius = 5;
    _returnBtn.layer.borderWidth = 1.0;
    _returnBtn.layer.borderColor = COLOR.CGColor;
    [self addSubview:_returnBtn];
    [_returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleFiveLabel);
        make.trailing.equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(60, 25));
    }];
    
    
    
    _detailFiveLabel  = [[UILabel alloc] init];
    _detailFiveLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_detailFiveLabel];
    [_detailFiveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleFiveLabel.mas_right).offset(10);
        make.centerY.equalTo(_titleFiveLabel);
        make.right.equalTo(_titleFiveLabel.mas_left).offset(-10);
        make.height.mas_equalTo( 20);
    }];
    
    
    
    _detailSixLabel  = [[UILabel alloc] init];
    _detailSixLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_detailSixLabel];
    [_detailSixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleSixLabel.mas_right).offset(10);
        make.centerY.equalTo(_titleSixLabel);
        make.trailing.equalTo(self).offset(-10);
        make.height.mas_equalTo( 20);
    }];
    
    
    
    _detailSevenLabel  = [[UILabel alloc] init];
    _detailSevenLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_detailSevenLabel];
    [_detailSevenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleSevenLabel.mas_right).offset(10);
        make.centerY.equalTo(_titleSevenLabel);
        make.trailing.equalTo(self).offset(-10);
        make.height.mas_equalTo( 20);
    }];
    
    
    UIView *backView  = [[UIView alloc] init];
    backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
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
