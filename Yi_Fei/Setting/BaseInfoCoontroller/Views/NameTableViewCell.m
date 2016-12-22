//
//  NameTableViewCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/20.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "NameTableViewCell.h"

@implementation NameTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    
self.lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.textFiled.borderStyle = UITextBorderStyleNone;
    
}








- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}












@end
























