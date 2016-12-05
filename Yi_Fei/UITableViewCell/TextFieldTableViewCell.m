//
//  TextFieldTableViewCell.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/20.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//
#import "PureLayout.h"
#import "TextFieldTableViewCell.h"
@interface TextFieldTableViewCell ()
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UITextField *valueTextField;
@end

@implementation TextFieldTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] initForAutoLayout];
        _titleLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.titleLabel];
        
        _valueTextField = [[UITextField alloc] initForAutoLayout];
        [self.contentView addSubview:self.valueTextField];
        [self addViewConstraints];
    }
    return self;
}

- (void)addViewConstraints {
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:3];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:3];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [self.titleLabel autoSetDimension:ALDimensionWidth toSize:80];
    
    [self.valueTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.titleLabel];
    [self.valueTextField autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.titleLabel];
    [self.valueTextField autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:5];
    [self.valueTextField autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.titleLabel];
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
