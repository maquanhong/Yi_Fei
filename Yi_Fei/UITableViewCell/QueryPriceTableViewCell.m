//
//  QueryPriceTableViewCell.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/12/4.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "QueryPriceTableViewCell.h"
#import "PureLayout.h"
@interface QueryPriceTableViewCell ()
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *pricelabel;
@property (nonatomic, strong) UIButton *queryBtn;
@property (nonatomic, strong) UIButton *imageQueryBtn;

@end

@implementation QueryPriceTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        _selectBtn = [[UIButton alloc] initForAutoLayout];
//        [self.contentView addSubview:self.selectBtn];
        _productImageView = [[UIImageView alloc] initForAutoLayout];
        [self.contentView addSubview:self.productImageView];
        _nameLabel = [[UILabel alloc] initForAutoLayout];
        _nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.nameLabel];
        _pricelabel = [[UILabel alloc] initForAutoLayout];
        [self.contentView addSubview:self.pricelabel];
        _queryBtn = [[UIButton alloc] initForAutoLayout];
        _queryBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _queryBtn.layer.borderWidth = 1;
        _queryBtn.layer.cornerRadius = 8;
        [_queryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_queryBtn addTarget:self action:@selector(queryPrice) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.queryBtn];
        _imageQueryBtn = [[UIButton alloc] initForAutoLayout];
        _imageQueryBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _imageQueryBtn.layer.borderWidth = 1;
        _imageQueryBtn.layer.cornerRadius = 8;
        [_imageQueryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_imageQueryBtn addTarget:self action:@selector(imageQueryPrice) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.imageQueryBtn];
        [self addViewConstraints];
    }
    return self;
}

- (void)addViewConstraints {
    [self.productImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [self.productImageView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:5];
    [self.productImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [self.productImageView autoSetDimension:ALDimensionWidth toSize:80];
    
    [self.nameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.productImageView];
    [self.nameLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.productImageView withOffset:3];
    [self.nameLabel autoSetDimension:ALDimensionWidth toSize:180];
    [self.nameLabel autoSetDimension:ALDimensionHeight toSize:15];
    
    [self.pricelabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.nameLabel];
    [self.pricelabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:5];
    [self.pricelabel autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.nameLabel];
    [self.pricelabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.nameLabel];
    
    [self.queryBtn autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.nameLabel];
    [self.queryBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.pricelabel withOffset:3];
    [self.queryBtn autoSetDimension:ALDimensionWidth toSize:60];
    [self.queryBtn autoSetDimension:ALDimensionHeight toSize:30];
    
    [self.imageQueryBtn autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.queryBtn withOffset:8];
    [self.imageQueryBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.queryBtn];
    [self.imageQueryBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.queryBtn];
    [self.imageQueryBtn autoSetDimension:ALDimensionWidth toSize:120];
}

- (void)queryPrice {
    if (self.delegate && [self.delegate respondsToSelector:@selector(queryPrice:)]) {
        [self.delegate queryPrice:self];
    }
}

- (void)imageQueryPrice {
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageQueryPrice:)]) {
        [self.delegate imageQueryPrice:self];
    }
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
