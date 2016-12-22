//
//  FirstCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/14.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "FirstCell.h"

@interface FirstCell ()

@property (nonatomic,strong) UILabel * surname;

@property (nonatomic,strong) UILabel * name;



@end


@implementation FirstCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{

    _surname = [[UILabel alloc] init];
    _surname.text = @"姓";
    _surname.font = [UIFont systemFontOfSize:14];
    [self addSubview:_surname];
    [_surname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(10);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];

    _oneTF = [[UITextField alloc] init];
    _oneTF.font = [UIFont systemFontOfSize:14];
    [self addSubview:_oneTF];
    [_oneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_surname.mas_right).offset(5);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(WIDTH / 2 - 30, 20));
    }];
    
    _name = [[UILabel alloc] init];
    _name.text = @"名";
    _name.font = [UIFont systemFontOfSize:14];
    [self addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_oneTF.mas_right).offset(5);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    

    _twoTF = [[UITextField alloc] init];
    _twoTF.font = [UIFont systemFontOfSize:14];
    [self addSubview:_twoTF];
    [_twoTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_name.mas_right).offset(5);
        make.centerY.mas_equalTo(self);
        make.trailing.mas_equalTo(self).offset(-5);
        make.height.mas_equalTo(20);
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






















