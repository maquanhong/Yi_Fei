//
//  ThreePopTableViewCell.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/29.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ThreePopTableViewCell.h"
#import "PureLayout.h"

@interface ThreePopTableViewCell()
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *valueDescLabel;
@property (nonatomic, strong) DownListButton  *downBtn;
@property (nonatomic, strong) UILabel  *valueDescLabel1;
@property (nonatomic, strong) DownListButton  *downBtn1;
@property (nonatomic, strong) UILabel  *valueDescLabel2;
@property (nonatomic, strong) DownListButton  *downBtn2;
@end

@implementation ThreePopTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] initForAutoLayout];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.titleLabel];
        
        
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
    
    [self.downBtn1 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.titleLabel];
    [self.downBtn1 autoSetDimension:ALDimensionHeight toSize:30];
    [self.downBtn1 autoSetDimension:ALDimensionWidth toSize:100];
    [self.downBtn1 autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.titleLabel withOffset:70];
    
    [self.valueDescLabel1 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.titleLabel];
    [self.valueDescLabel1 autoSetDimension:ALDimensionWidth toSize:50];
    [self.valueDescLabel1 autoSetDimension:ALDimensionHeight toSize:15];
    [self.valueDescLabel1 autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.downBtn1];
    
    [self.downBtn2 autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.downBtn1];
    [self.downBtn2 autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.downBtn1];
    [self.downBtn2 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.downBtn1];
    [self.downBtn2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.downBtn1 withOffset:5];
    [self.valueDescLabel2 autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.valueDescLabel1];
    [self.valueDescLabel2 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.downBtn2];
    [self.valueDescLabel2 autoSetDimension:ALDimensionHeight toSize:ALDimensionHeight];
    [self.valueDescLabel2 autoSetDimension:ALDimensionWidth toSize:ALDimensionWidth];
    
    
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
