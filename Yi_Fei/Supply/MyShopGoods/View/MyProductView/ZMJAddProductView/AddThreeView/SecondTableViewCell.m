//
//  ThreeTableViewCell.m
//  Yi_Fei
//
//  Created by yons on 16/11/9.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "SecondTableViewCell.h"

@implementation SecondTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView
{
    _textFOne = [[UITextField alloc] init];
    _textFOne.font = [UIFont systemFontOfSize:14];
    _textFOne.layer.masksToBounds=YES;
    _textFOne.layer.cornerRadius=5.0;
    _textFOne.layer.borderWidth=1.0;
    _textFOne.layer.borderColor=[UIColor blueColor].CGColor;
    [self addSubview:_textFOne];
    [_textFOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(70, 25));
    }];
    _textFTwo = [[UITextField alloc] init];
    _textFTwo.font = [UIFont systemFontOfSize:14];
    _textFTwo.layer.masksToBounds=YES;
    _textFTwo.layer.cornerRadius=5.0;
    _textFTwo.layer.borderWidth=1.0;
    _textFTwo.layer.borderColor=[UIColor blueColor].CGColor;
    [self addSubview:_textFTwo];
    [_textFTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_textFOne.mas_right).offset(10);
        make.centerY.mas_equalTo(_textFOne.mas_centerY);
        make.trailing.mas_equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(25);
    }];
    
    UIView *lineV=[[UIView alloc] init];
    lineV.backgroundColor=[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self);
        make.trailing.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(1);
    }];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
