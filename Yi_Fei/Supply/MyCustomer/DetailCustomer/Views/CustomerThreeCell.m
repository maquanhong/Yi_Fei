//
//  CustomerThreeCell.m
//  Yi_Fei
//
//  Created by yons on 16/12/19.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "CustomerThreeCell.h"
#import "PureLayout.h"
@interface CustomerThreeCell()

@property (nonatomic, strong) UILabel  *titleLabel;

@property (nonatomic, strong) UILabel  *contentLabel;

@end

@implementation CustomerThreeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentLabel];
        [self addViewConstraints];
    }
    return self;
}

- (void)addViewConstraints {
    
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:3];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:5];
    [self.titleLabel autoSetDimension:ALDimensionWidth toSize:WIDTH - 40];
    [self.titleLabel autoSetDimension:ALDimensionHeight toSize:15];
    
    [self.contentLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLabel withOffset:5];
    [self.contentLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.titleLabel];
    [self.contentLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.titleLabel];
    [self.contentLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:5];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initForAutoLayout];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}


- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initForAutoLayout];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = [UIColor blackColor];
    }
    return _contentLabel;
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
