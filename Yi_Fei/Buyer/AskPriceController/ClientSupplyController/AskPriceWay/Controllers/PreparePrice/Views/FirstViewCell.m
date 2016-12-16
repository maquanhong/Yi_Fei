//
//  FirstViewCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/16.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "FirstViewCell.h"

@interface FirstViewCell ()
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation FirstViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    _backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
