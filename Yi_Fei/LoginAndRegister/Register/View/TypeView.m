//
//  TypeView.m
//  Yi_Fei
//
//  Created by yons on 16/12/26.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "TypeView.h"

@implementation TypeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addContainView];
    }
    return self;
}

-(void)addContainView{

    _titleLabel =[[UILabel alloc] init];
    _titleLabel.textColor = BACKCOLOR;
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self  addSubview:_titleLabel];
    
    _imageView =[[UIImageView alloc] init];
    _imageView.image = [UIImage imageNamed:@"xiala"];
    [self  addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self).offset(-5);
        make.centerY.mas_equalTo(self.mas_centerY);
       make.size.mas_equalTo(CGSizeMake(10, 7));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self);
        make.trailing.mas_equalTo(self).offset(-20);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        
    }];
    
}

















@end
