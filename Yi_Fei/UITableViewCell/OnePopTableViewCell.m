//
//  OnePopTableViewCell.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/29.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "OnePopTableViewCell.h"
#import "PureLayout.h"
@interface OnePopTableViewCell()
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UITextField *valueTextField;
@property (nonatomic, strong) UILabel  *valueDescLabel;
@property (nonatomic, strong) DownListButton  *downBtn;
@end

@implementation OnePopTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] initForAutoLayout];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.titleLabel];
        
        _valueTextField = [[UITextField alloc] initForAutoLayout];
        _valueTextField.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.valueTextField];
        
        
        _valueDescLabel = [[UILabel alloc] initForAutoLayout];
        _valueDescLabel.textColor = [UIColor lightGrayColor];
        _valueDescLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.valueDescLabel];
        _downBtn = [[DownListButton alloc] initForAutoLayout];
        [self.contentView addSubview:self.downBtn];
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
    [self.valueTextField autoSetDimension:ALDimensionWidth toSize:100];
    [self.valueTextField autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.titleLabel];
    
    [self.downBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.downBtn autoSetDimension:ALDimensionWidth toSize:80];
    [self.downBtn autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [self.downBtn autoSetDimension:ALDimensionHeight toSize:30];
    
    [self.valueDescLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.valueDescLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.downBtn];
    [self.valueDescLabel autoSetDimension:ALDimensionHeight toSize:15];
    [self.valueDescLabel autoSetDimension:ALDimensionWidth toSize:50];
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
