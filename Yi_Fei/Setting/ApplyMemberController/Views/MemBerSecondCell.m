//
//  MemBerSecondCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/12.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "MemBerSecondCell.h"

@interface MemBerSecondCell ()

@property (nonatomic, strong ) UIImageView   *pictureImage;
@property (nonatomic, strong ) UILabel   *nameLable;

@end

@implementation MemBerSecondCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViewConstraints];
    }
    return self;
}

- (void)addViewConstraints {
    
    _iconImageView=[[TapButton alloc] init];
    [_iconImageView setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [_iconImageView setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    [self addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self).offset(-20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_iconImageView addTarget:self action:@selector(clicikBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _pictureImage =[[UIImageView alloc] init];
    [self addSubview:_pictureImage];
    [_pictureImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    _nameLable =[[UILabel alloc] init];
    _nameLable.font=[UIFont systemFontOfSize:14.0];
    [_nameLable sizeToFit];
    [self addSubview:_nameLable];
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_pictureImage.mas_right).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    
    
}


-(void)setDict:(NSDictionary *)dict{
    _nameLable.text = dict[@"name"];
    _pictureImage.image = [UIImage imageNamed:dict[@"picture"]];
}

-(void)clicikBtn:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(payWay:num:)]) {
        [self.delegate payWay:sender num:self];
    }
}























@end














