

//
//  SecondViewCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/16.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "SecondViewCell.h"

@interface SecondViewCell ()

@property (nonatomic,strong) UILabel *nameLabel;

@end



@implementation SecondViewCell


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


    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"预留时间";
    _nameLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    _typViewOne = [[ZMJTypeView alloc] init];
    _typViewOne.layer.cornerRadius = 5;
    _typViewOne.layer.borderWidth = 1.0;
    _typViewOne.layer.borderColor = BACKCOLOR.CGColor;
    _typViewOne.nameLabel.text = @"选择预留询价时间";
    [self addSubview:_typViewOne];
    [_typViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_right).offset(10);
        make.centerY.equalTo(_nameLabel);
        make.size.mas_equalTo(CGSizeMake(150, 25));
    }];
    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBordWdith)];
    [_typViewOne addGestureRecognizer:tapOne];
    
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

-(void)clickBordWdith{
    if ([self.delegate respondsToSelector:@selector(clickView)]) {
        [self.delegate clickView];
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








