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
@property (nonatomic, strong) UIImageView *moreImageView;
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
        _moreLabel = [[UILabel alloc] initForAutoLayout];
        _moreLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.moreLabel];
        _productImageView = [[UIImageView alloc] initForAutoLayout];
        _productImageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:self.productImageView];
        
        _productNameLabel = [[UILabel alloc] initForAutoLayout];
        _productNameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.productNameLabel];
        
        _moreImageView = [[UIImageView alloc] initForAutoLayout];
        _moreImageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:self.moreImageView];
        [self addViewConstraints];
    }
    return self;
}

- (void)addViewConstraints {
    [self.iconImageView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:3];
    [self.iconImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [self.iconImageView autoSetDimension:ALDimensionWidth toSize:50];
    [self.iconImageView autoSetDimension:ALDimensionHeight toSize:30];
    
    [self.titleLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.iconImageView withOffset:5];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [self.titleLabel autoSetDimension:ALDimensionHeight toSize:20];
    [self.titleLabel autoSetDimension:ALDimensionWidth toSize:90];
    
    [self.moreLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:8];
    [self.moreLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [self.moreLabel autoSetDimension:ALDimensionWidth toSize:80];
    [self.moreLabel autoSetDimension:ALDimensionHeight toSize:20];
    
    [self.productImageView autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.iconImageView];
    [self.productImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.iconImageView withOffset:3];
    [self.productImageView autoSetDimension:ALDimensionWidth toSize:60];
    [self.productImageView autoSetDimension:ALDimensionHeight toSize:60];
    
    [self.productNameLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.productImageView];
    [self.productNameLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.productImageView withOffset:8];
    [self.productNameLabel autoSetDimension:ALDimensionHeight toSize:20];
    [self.productNameLabel autoSetDimension:ALDimensionWidth toSize:200];
    
    [self.moreImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.productImageView];
    [self.moreImageView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [self.moreImageView autoSetDimension:ALDimensionWidth toSize:30];
    [self.moreImageView autoSetDimension:ALDimensionHeight toSize:30];
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
