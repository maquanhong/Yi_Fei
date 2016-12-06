//
//  OnlyTitleTableViewCell.m
//  YiFei
//
//  Created by maquanhong on 10/23/16.
//  Copyright © 2016 yous. All rights reserved.
//

#import "OnlyTitleTableViewCell.h"
#import "PureLayout.h"
#import "Macro.h"
@interface OnlyTitleTableViewCell ()
@property (strong, nonatomic) UILabel   *titleLabel;
@end

@implementation OnlyTitleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self addViewConstraints];
    }
    return self;
}

- (void)addViewConstraints {
    
    [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:CellLeading];
    [self.titleLabel autoSetDimension:ALDimensionWidth toSize:200];
    [self.titleLabel autoSetDimension:ALDimensionHeight toSize:30];

}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initForAutoLayout];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}


@end
