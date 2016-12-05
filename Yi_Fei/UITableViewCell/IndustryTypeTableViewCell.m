//
//  IndustryTypeTableViewCell.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/20.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "IndustryTypeTableViewCell.h"
#import "PureLayout.h"
#import "DownListButton.h"
@interface IndustryTypeTableViewCell ()
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) DownListButton  *industryDownBtn;
@property (nonatomic, strong) DownListButton  *productDownBtn;
@property (nonatomic, strong) DownListButton  *pictureDownBtn;
@property (nonatomic, strong) DownListButton  *craftDownBtn;
@end

@implementation IndustryTypeTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] initForAutoLayout];
        [self.contentView addSubview:self.titleLabel];
        _industryDownBtn = [[DownListButton alloc] initForAutoLayout];
        _industryDownBtn.btnTitleLabel.text = @"家居装饰";
        [self.contentView addSubview:self.industryDownBtn];
        
        _productDownBtn = [[DownListButton alloc] initForAutoLayout];
        _productDownBtn.btnTitleLabel.text = @"墙挂装饰品";
        [self.contentView addSubview:self.productDownBtn];
        
        _pictureDownBtn = [[DownListButton alloc] initForAutoLayout];
        _pictureDownBtn.btnTitleLabel.text = @"画／画框／镜框／镜";
        [self.contentView addSubview:self.pictureDownBtn];
        
        _craftDownBtn = [[DownListButton alloc] initForAutoLayout];
        _craftDownBtn.btnTitleLabel.text = @"工艺镜框";
        [self.contentView addSubview:self.craftDownBtn];
        [self addViewConstraints];

    }
    return self;
}

- (void)addViewConstraints {
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:3];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:3];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:3];
    [self.titleLabel autoSetDimension:ALDimensionHeight toSize:15];
    
    [self.industryDownBtn  autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:9];
    [self.industryDownBtn autoSetDimension:ALDimensionWidth toSize:100];
    [self.industryDownBtn autoSetDimension:ALDimensionHeight toSize:30];
    [self.industryDownBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLabel withOffset:5];
    
    [self.productDownBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.industryDownBtn];
    [self.productDownBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.industryDownBtn];
    [self.productDownBtn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.industryDownBtn];
    [self.productDownBtn autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:5];
    

    
    [self.pictureDownBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.industryDownBtn withOffset:5];
    [self.pictureDownBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.industryDownBtn];
    [self.pictureDownBtn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.industryDownBtn];
    [self.pictureDownBtn autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:5];
    
    [self.craftDownBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.pictureDownBtn];
    [self.craftDownBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.industryDownBtn];
    [self.craftDownBtn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.industryDownBtn];
    [self.craftDownBtn autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:5];
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
