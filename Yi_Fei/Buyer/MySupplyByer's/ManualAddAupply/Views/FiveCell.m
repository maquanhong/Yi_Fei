//
//  FiveCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/14.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "FiveCell.h"

@interface FiveCell ()

@property (nonatomic,strong) UILabel * emailLabel;

@end


@implementation FiveCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{

    _emailLabel = [[UILabel alloc] init];
    _emailLabel.text = @"邮箱地址";
    _emailLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_emailLabel];
    [_emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(10);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];

    _emailText = [[UITextField alloc] init];
    _emailText.layer.cornerRadius = 5;
    _emailText.layer.borderWidth = 1.0;
    _emailText.layer.borderColor = BACKCOLOR.CGColor;
    [self addSubview:_emailText];
    [_emailText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_emailLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self);
        make.trailing.mas_equalTo(self).offset(-10);
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





- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}











@end














