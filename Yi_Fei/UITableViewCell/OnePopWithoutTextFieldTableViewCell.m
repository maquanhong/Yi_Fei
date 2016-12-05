//
//  OnePopWithoutTextFieldTableViewCell.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/12/3.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "OnePopWithoutTextFieldTableViewCell.h"
#import "PureLayout.h"
@interface OnePopWithoutTextFieldTableViewCell ()
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) DownListButton  *downBtn;
@end

@implementation OnePopWithoutTextFieldTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] initForAutoLayout];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.titleLabel];
        
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
    
    [self.downBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.downBtn autoSetDimension:ALDimensionWidth toSize:80];
    [self.downBtn autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [self.downBtn autoSetDimension:ALDimensionHeight toSize:30];
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
