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
        [self addView];
    }
    return self;
}

-(void)addView{
    _imagV=[[UIImageView alloc] init];
    [_imagV sizeToFit];
    _imagV.frame=CGRectMake(5, (40-WIDTH/10)/2, WIDTH/10, WIDTH/10);
    [self.contentView addSubview:_imagV];
    
    _label=[[UILabel alloc] init];
    [_label sizeToFit];
    _label.frame=CGRectMake(CGRectGetMaxX(_imagV.frame)+10, (40-WIDTH/10)/2, WIDTH-(WIDTH/10+5), WIDTH/10);
    _label.font=[UIFont systemFontOfSize:16.0];
    _label.textColor=[UIColor blackColor];
    [self.contentView addSubview:_label];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
