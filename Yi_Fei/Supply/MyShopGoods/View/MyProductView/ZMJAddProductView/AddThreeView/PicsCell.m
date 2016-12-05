//
//  PicsCell.m
//  Yi_Fei
//
//  Created by yons on 16/11/23.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "PicsCell.h"

@implementation PicsCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat photoSize = ([UIScreen mainScreen].bounds.size.width - 50) / 4;
        
        _photo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, photoSize, photoSize)];
        
        _photo.layer.masksToBounds = YES;
        
        _photo.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.contentView addSubview:_photo];
    }
    return self;
}


@end
