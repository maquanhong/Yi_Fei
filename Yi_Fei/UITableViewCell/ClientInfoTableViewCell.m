//
//  ClientInfoTableViewCell.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/20.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ClientInfoTableViewCell.h"
#import "PureLayout.h"
@interface ClientInfoTableViewCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *telLabel;
@property (nonatomic, strong) UILabel *postionLabel;
@property (nonatomic, strong) UILabel *emailLabel;
@property (nonatomic, strong) UILabel *companyLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *careerLabel;
@end
@implementation ClientInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLabel = [[UILabel alloc] initForAutoLayout];
        [self.contentView addSubview:self.nameLabel];
        _telLabel = [[UILabel alloc] initForAutoLayout];
        [self.contentView addSubview:self.telLabel];
        _postionLabel = [[UILabel alloc] initForAutoLayout];
        [self.contentView addSubview:self.postionLabel];
        _emailLabel = [[UILabel alloc] initForAutoLayout];
        [self.contentView addSubview:self.emailLabel];
        _companyLabel = [[UILabel alloc] initForAutoLayout];
        [self.contentView addSubview:self.companyLabel];
        _addressLabel = [[UILabel alloc] initForAutoLayout];
        [self.contentView addSubview:self.addressLabel];
        _careerLabel = [[UILabel alloc] initForAutoLayout];
        [self.contentView addSubview:self.careerLabel];
        [self addViewConstraints];
    }
    return self;

}

- (void)addViewConstraints {
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:5];
    [self.nameLabel autoSetDimension:ALDimensionWidth toSize:WIDTH / 2 - 5];
    [self.nameLabel autoSetDimension:ALDimensionHeight toSize:20];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    
    [self.telLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.nameLabel];
    [self.telLabel autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.nameLabel];
    [self.telLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.nameLabel];
    [self.telLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.nameLabel];
    
    [self.postionLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel];
    [self.postionLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.nameLabel];
    [self.postionLabel autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.nameLabel];
    [self.postionLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.nameLabel];
    
    [self.emailLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.telLabel];
    [self.emailLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.telLabel];
    [self.emailLabel autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.nameLabel];
    [self.emailLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.nameLabel];
    
    [self.companyLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.postionLabel];
    [self.companyLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.postionLabel];
    [self.companyLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.nameLabel];
    [self.companyLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.emailLabel];
    
    [self.addressLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.companyLabel];
    [self.addressLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.companyLabel];
    [self.addressLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.nameLabel];
    [self.addressLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.companyLabel];
    
    [self.careerLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.addressLabel];
    [self.careerLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.addressLabel];
    [self.careerLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.nameLabel];
    [self.careerLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.companyLabel];
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
