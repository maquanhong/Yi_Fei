//
//  AskPriceTableViewCell.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/20.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "AskPriceTableViewCell.h"
#import "PureLayout.h"
@interface AskPriceTableViewCell ()
@property (nonatomic, strong) UILabel *productLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *skinLabel;
@property (nonatomic, strong) UILabel *sizeLabel;
@property (nonatomic, strong) UILabel *colorLabel;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *markLabel;
@end

@implementation AskPriceTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _productLabel = [[UILabel alloc] initForAutoLayout];
        [self.contentView addSubview:self.productLabel];
        _typeLabel = [[UILabel alloc] initForAutoLayout];
        [self.contentView addSubview:self.typeLabel];
        _skinLabel = [[UILabel alloc] initForAutoLayout];
        [self.contentView addSubview:self.skinLabel];
        _sizeLabel = [[UILabel alloc] initForAutoLayout];
        [self.contentView addSubview:self.sizeLabel];
        _colorLabel = [[UILabel alloc] initForAutoLayout];
        [self.contentView addSubview:self.colorLabel];
        _countLabel = [[UILabel alloc] initForAutoLayout];
        [self.contentView addSubview:self.countLabel];
        _markLabel = [[UILabel alloc] initForAutoLayout];
        [self.contentView addSubview:self.markLabel];
        [self addViewConstraints];
    }
    
    return self;
}

- (void)addViewConstraints {
    [self.productLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:5];
    [self.productLabel autoSetDimension:ALDimensionWidth toSize:WIDTH / 2 + 80];
    [self.productLabel autoSetDimension:ALDimensionHeight toSize:20];
    [self.productLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    
    [self.typeLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.productLabel];
    [self.typeLabel autoSetDimension:ALDimensionWidth toSize:WIDTH / 2];
    [self.typeLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.productLabel];
    [self.typeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.productLabel];
    
    [self.skinLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.productLabel];
    [self.skinLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.typeLabel];
    [self.skinLabel autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.typeLabel];
    [self.skinLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.typeLabel];
    
    [self.sizeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.typeLabel];
    [self.sizeLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.typeLabel];
    [self.sizeLabel autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.typeLabel];
    [self.sizeLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.typeLabel];
    
    [self.colorLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.skinLabel];
    [self.colorLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.skinLabel];
    [self.colorLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.skinLabel];
    [self.colorLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.skinLabel];
    
    [self.countLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.colorLabel];
    [self.countLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.typeLabel];
    [self.countLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.typeLabel];
    [self.countLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.colorLabel];
    
    [self.markLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.countLabel];
    [self.markLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.countLabel];
    [self.markLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.countLabel];
    [self.markLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.countLabel];
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
