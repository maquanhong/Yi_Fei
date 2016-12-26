//
//  MemberFirstCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/24.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "MemberFirstCell.h"

@implementation MemberFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];

[self.selectBtn setImage:[[UIImage imageNamed:@"weixuanzhong"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal]  ;
[self.selectBtn setImage:[[UIImage imageNamed:@"xuanzhong"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    
    self.moneyLabel.textColor = PRICECOLOR;
    self.moneyLabel.textAlignment = NSTextAlignmentRight;
    
    self.lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
