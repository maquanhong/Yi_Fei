//
//  OfferPriceCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/21.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "OfferCuPriceCell.h"

@implementation OfferCuPriceCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.nextBtn.layer.cornerRadius = 5;
    self.nextBtn.layer.borderWidth = 1.0;
    [self.nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.nextBtn.tag = 1345;
    self.nextBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    self.oneBtn.layer.cornerRadius = 5;
    self.oneBtn.layer.borderWidth = 1.0;
    [self.oneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.oneBtn.tag = 1346;
    self.oneBtn.layer.borderColor =  [UIColor lightGrayColor].CGColor;
    
    self.lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
}



- (IBAction)clickBtnView:(UIButton*)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickCell:index:)]) {
    [self.delegate clickCell:self index:sender.tag];
    }
    
    
}





- (IBAction)clickPrepareBtn:(UIButton*)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickCell:index:)]) {
        [self.delegate clickCell:self index:sender.tag];
    }

}














- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
