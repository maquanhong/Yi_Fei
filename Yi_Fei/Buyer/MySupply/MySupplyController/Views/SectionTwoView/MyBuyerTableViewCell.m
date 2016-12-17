//
//  MyBuyerTableViewCell.m
//  YiFei
//
//  Created by yangyan on 16/9/2.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "MyBuyerTableViewCell.h"

@implementation MyBuyerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addView];
    }
    return self;
}

-(void)addView{
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [ UIColor groupTableViewBackgroundColor];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.mas_top);
    }];
    
    _imagV=[[UIImageView alloc] init];
    [_imagV sizeToFit];
    [self addSubview:_imagV];
    [_imagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
    }];
    
    
    _label=[[UILabel alloc] init];
    [_label sizeToFit];;
    _label.font=[UIFont systemFontOfSize:18.0];
    _label.textColor=[UIColor blackColor];
    [self addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imagV.mas_right).offset(10);
        make.centerY.equalTo(_imagV);
        make.height.mas_equalTo(20);
    }];

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}






@end











