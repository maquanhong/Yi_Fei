//
//  CollectionViewCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/29.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "CollectionViewCell.h"


@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _tiltleLabel.textColor = [UIColor whiteColor];
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    
    self.backgroundColor = BACKCOLOR;
    self.imageView.image = [UIImage imageNamed:@"guanbi_icon"];
    
    
}


















@end
