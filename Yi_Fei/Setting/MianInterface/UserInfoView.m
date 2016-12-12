//
//  UserInfoView.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/23.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "UserInfoView.h"
#import "PureLayout.h"

@interface UserInfoView()
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIView *maskImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *levelLabel;
@end

@implementation UserInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _backgroundImageView = [[UIImageView alloc] initForAutoLayout];
        [self addSubview:self.backgroundImageView];
        _maskImageView = [[UIImageView alloc] initForAutoLayout];
        _maskImageView.backgroundColor = [UIColor grayColor];
        _maskImageView.alpha = 0.5;
        [self addSubview:self.maskImageView];
        _logoImageView = [[UIImageView alloc] initForAutoLayout];
        _logoImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:self.logoImageView];
        _nameLabel = [[UILabel alloc] initForAutoLayout];
        _nameLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.nameLabel];
        _levelLabel = [[UILabel alloc] initForAutoLayout];
        _levelLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.levelLabel];
        [self addViewConstraints];
    }
    return self;
}

- (void)addViewConstraints {
    [self.backgroundImageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.backgroundImageView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.backgroundImageView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.backgroundImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.maskImageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.maskImageView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.maskImageView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.maskImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    [self.logoImageView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:35];
    [self.logoImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:80];
    [self.logoImageView autoSetDimension:ALDimensionWidth toSize:100];
    [self.logoImageView autoSetDimension:ALDimensionHeight toSize:100];
    
    [self.nameLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.logoImageView withOffset:30];
    [self.nameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.logoImageView withOffset:30];
    [self.nameLabel autoSetDimension:ALDimensionHeight toSize:15];
//    [self.nameLabel autoSetDimension:ALDimensionWidth toSize:100];
    
    [self.levelLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.nameLabel];
    [self.levelLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:20];

    [self.levelLabel autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.nameLabel];
    [self.levelLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.nameLabel];
}






























@end










