//
//  QueryPriceTableViewCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/17.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "QueryPriceTableViewCell.h"

@interface QueryPriceTableViewCell ()





@property (weak, nonatomic) IBOutlet UIButton *askPrice;


@property (weak, nonatomic) IBOutlet UIButton *leaveAsk;

@end



@implementation QueryPriceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.askPrice.layer.cornerRadius = 5;
    self.askPrice.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.askPrice.layer.borderWidth = 1.0;
    [self.askPrice setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.askPrice.titleLabel.font=[UIFont systemFontOfSize:14.0];
    
    self.leaveAsk.layer.cornerRadius = 5;
    self.leaveAsk.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.leaveAsk.layer.borderWidth = 1.0;
    [self.leaveAsk setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.leaveAsk.titleLabel.font=[UIFont systemFontOfSize:14.0];
    
    
}





- (IBAction)queryPrice:(id)sender {
if (self.delegate && [self.delegate respondsToSelector:@selector(queryPrice:)]) {
        [self.delegate queryPrice:self];
}
}




- (IBAction)leaveQueryPrice:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageQueryPrice:)]) {
        [self.delegate imageQueryPrice:self];
    }
}



















- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}













@end
