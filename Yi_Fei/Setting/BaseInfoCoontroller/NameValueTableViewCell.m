//
//  NameValueTableViewCell.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/28.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "NameValueTableViewCell.h"
#import "PureLayout.h"
@interface NameValueTableViewCell()
@property (nonatomic, strong) UILabel  *nameLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@end

@implementation NameValueTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLabel = [[UILabel alloc] initForAutoLayout];
        _nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.nameLabel];
        _valueLabel = [[UILabel alloc] initForAutoLayout];
        _valueLabel.backgroundColor = [UIColor clearColor];
        _valueLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.valueLabel];
        [self addViewConstraints];
    }
    return self;
}

- (void)addViewConstraints {
    [self.nameLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [self.nameLabel autoSetDimension:ALDimensionWidth toSize:100];
    [self.nameLabel autoSetDimension:ALDimensionHeight toSize:15];
    
    [self.valueLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.valueLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:5];
    [self.valueLabel autoSetDimension:ALDimensionWidth toSize:100];
    [self.valueLabel autoSetDimension:ALDimensionHeight toSize:15];
}













@end












