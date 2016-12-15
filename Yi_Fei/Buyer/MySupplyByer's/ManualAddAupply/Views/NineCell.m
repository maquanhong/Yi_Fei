//
//  NineCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/14.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "NineCell.h"

@interface NineCell ()

@property (nonatomic,strong) UILabel *noteLabel;

@end

@implementation NineCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    
    _noteLabel = [[UILabel alloc] init];
    _noteLabel.text = @"备注其他";
    _noteLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_noteLabel];
    [_noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    _contenText = [[UITextView alloc] init];
    [self addSubview:_contenText];
    [_contenText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self).offset(-15);
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(_noteLabel.mas_right).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
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


















@end
