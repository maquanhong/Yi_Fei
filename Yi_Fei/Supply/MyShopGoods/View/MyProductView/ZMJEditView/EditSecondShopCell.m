//
//  EditSecondShopCell.m
//  Yi_Fei
//
//  Created by yons on 16/11/11.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "EditSecondShopCell.h"

@implementation EditSecondShopCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    [self addView];
    }
    return self;
}


-(void)addView{
    
    _titileLabel = [[UILabel alloc] init];
    _titileLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titileLabel];
    [_titileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(15);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    _textView = [[UITextView alloc] init];
    _textView.font = [UIFont systemFontOfSize:14];
    [self addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titileLabel.mas_right).offset(10);
        make.top.mas_equalTo(_titileLabel.mas_top).offset(-5);
        make.trailing.mas_equalTo(self).offset(-10);
        make.height.mas_equalTo(100);
    }];
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}







@end















