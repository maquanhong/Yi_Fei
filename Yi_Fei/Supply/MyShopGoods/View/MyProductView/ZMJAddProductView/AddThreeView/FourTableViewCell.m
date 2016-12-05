
//
//  FourTableViewCell.m
//  Yi_Fei
//
//  Created by yons on 16/11/23.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "FourTableViewCell.h"

@implementation FourTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView
{
    _titileLabel = [[UILabel alloc] init];
    _titileLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_titileLabel];
    [_titileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    _textView = [[UITextView alloc] init];
    _textView.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titileLabel.mas_right).offset(10);
        make.top.mas_equalTo(_titileLabel.mas_top).offset(-5);
        make.trailing.mas_equalTo(self).offset(-10);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
    }];
    
    _holderLabel = [[UILabel alloc] init];
    _holderLabel.font = [UIFont systemFontOfSize:14];
    _holderLabel.enabled = NO;
    [_textView addSubview:_holderLabel];
    [_holderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_textView);
        make.top.mas_equalTo(_textView.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake(140, 20));
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









@end
