//
//  IconContenTableVIewCell.m
//  YTNewEnergy
//
//  Created by maquanhong on 16/1/15.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "IconContenTableVIewCell.h"
#import "PureLayout.h"
@interface IconContenTableVIewCell ()
@property (strong, nonatomic) UIImageView  *iconImageView;
@property (strong, nonatomic) UILabel      *titleLabel;
@end

@implementation IconContenTableVIewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLabel];
        [self addViewConstraints];
    }
    return self;
}

- (void)addViewConstraints {
    
    [self.iconImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.iconImageView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:12];
    [self.iconImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.iconImageView autoSetDimension:ALDimensionWidth toSize:30];
    
    [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.titleLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.iconImageView withOffset:15];
    [self.titleLabel autoSetDimension:ALDimensionWidth toSize:280];
    [self.titleLabel autoSetDimension:ALDimensionHeight toSize:20];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initForAutoLayout];
        _iconImageView.backgroundColor = [UIColor clearColor];
        _iconImageView.contentMode = UIViewContentModeCenter;
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initForAutoLayout];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _titleLabel;
}

@end
