//
//  industryView.m
//  Yi_Fei
//
//  Created by yons on 16/12/17.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "industryView.h"

@interface industryView ()


@property (nonatomic,strong) UIImageView *nextImageView;

@end

@implementation industryView


- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self addContentView];
    }
    return self;
}

-(void)addContentView{

    _titleLabel  = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titleLabel];
    
    _nextImageView  = [[UIImageView alloc] init];
    _nextImageView.image = [UIImage imageNamed:@"xiala"];
    [_nextImageView sizeToFit];
    [self addSubview:_nextImageView];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(10);
        make.right.mas_equalTo(_nextImageView.mas_left).offset(-10);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [_nextImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_right).offset(10);
        make.trailing.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(5, 5));
    }];
    
}





































@end




















