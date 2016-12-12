//
//  TextIconTableViewCell.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/28.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "TextIconTableViewCell.h"
#import "PureLayout.h"

@interface TextIconTableViewCell()
@property (nonatomic, strong) UILabel  *nameLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@end

@implementation TextIconTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLabel = [[UILabel alloc] initForAutoLayout];
        _nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.nameLabel];
        _iconImageView = [[UIImageView alloc] initForAutoLayout];
        _iconImageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:self.iconImageView];
        [self addViewConstraints];
    }
    return self;
}

- (void)addViewConstraints {
    [self.nameLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [self.nameLabel autoSetDimension:ALDimensionWidth toSize:100];
    [self.nameLabel autoSetDimension:ALDimensionHeight toSize:15];
    
    [self.iconImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.iconImageView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:5];
    [self.iconImageView autoSetDimension:ALDimensionWidth toSize:80];
    [self.iconImageView autoSetDimension:ALDimensionHeight toSize:40];
}






@end













