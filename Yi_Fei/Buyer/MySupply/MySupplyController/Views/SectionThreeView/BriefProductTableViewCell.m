//
//  BriefProductTableViewCell.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/12/6.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "BriefProductTableViewCell.h"
#import <PureLayout/PureLayout.h>
@interface BriefProductTableViewCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel    *titleLabel;
@property (nonatomic, strong) UILabel    *moreLabel;
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel    *productNameLabel;
@property (nonatomic, strong) UIImageView *nextView;
@end

@implementation BriefProductTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _iconImageView = [[UIImageView alloc] initForAutoLayout];
        _iconImageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:self.iconImageView];
        _titleLabel = [[UILabel alloc] initForAutoLayout];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.titleLabel];
        
        _productNameLabel = [[UILabel alloc] initForAutoLayout];
        _productNameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.productNameLabel];

        [self addViewConstraints];
    }
    return self;
}

- (void)addViewConstraints {
    
    
    _iconImageView = [[UIImageView alloc] init];
    [_iconImageView sizeToFit];
    [self addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake(20, 20));;
    }];
    
    
    [self.titleLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.iconImageView withOffset:5];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [self.titleLabel autoSetDimension:ALDimensionHeight toSize:20];
    [self.titleLabel autoSetDimension:ALDimensionWidth toSize:90];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    
    
    self.moreLabel = [[UILabel alloc] init];
    [self.moreLabel sizeToFit];
    self.moreLabel.font = [UIFont systemFontOfSize:16];
    self.moreLabel.textColor = BACKCOLOR;
    [self addSubview:self.moreLabel];
    [self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-10);
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake(70, 20));;
    }];

    _productImageView = [[UIImageView alloc] init];
    [_productImageView sizeToFit];
    [self addSubview:_productImageView];
    [_productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(10);
        make.top.mas_equalTo(_iconImageView.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(70, 70));;
    }];
    
    
    [self.productNameLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.productImageView];
    [self.productNameLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.productImageView withOffset:8];
    [self.productNameLabel autoSetDimension:ALDimensionHeight toSize:20];
    [self.productNameLabel autoSetDimension:ALDimensionWidth toSize:200];
    self.productNameLabel.font = [UIFont systemFontOfSize:20];
    
    _nextView = [[UIImageView alloc] init];
    [_nextView sizeToFit];
    [self addSubview:_nextView];
    [_nextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-10);
        make.centerY.mas_equalTo(_productImageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(8, 15));;
    }];

}

- (void)setModel:(ProductionData *)model{
    self.moreLabel.text = @"查看更多";
    self.titleLabel.text = @"商品列表";
    self.iconImageView.image = [UIImage imageNamed:@"shangpin_icon"];
    
    
    if (model.imageOne) {
    self.productImageView.image= [UIImage imageWithData:model.imageOne];
    }
    if (model.shopName.length > 0) {
    self.productNameLabel.text =  model.shopName ;
    }
    _nextView.image = [UIImage imageNamed:@"more"];
}















- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
