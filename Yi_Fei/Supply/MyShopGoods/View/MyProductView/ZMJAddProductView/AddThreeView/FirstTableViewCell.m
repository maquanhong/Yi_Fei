//
//  FirstTableViewCell.m
//  Yi_Fei
//
//  Created by yons on 16/11/9.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell


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
    
    _contentLabel = [[UITextField alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titileLabel.mas_right).offset(10);
        make.top.mas_equalTo(_titileLabel.mas_top).offset(-5);
        make.trailing.mas_equalTo(self).offset(-10);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
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













