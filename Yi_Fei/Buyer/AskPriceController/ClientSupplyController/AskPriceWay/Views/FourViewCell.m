//
//  FourViewCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/16.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "FourViewCell.h"

@implementation FourViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.setBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.setBtn.layer.cornerRadius = 5;
    self.setBtn.backgroundColor = BACKCOLOR;
    self.lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (IBAction)clickBtn:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickView)]) {
        [self.delegate clickView];
    }
    
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



















@end














