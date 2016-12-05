//
//  UploadImageTableViewCell.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/12/3.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "UploadImageTableViewCell.h"
#import "PureLayout.h"
@interface UploadImageTableViewCell ()
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UIButton *uploadBtn;
@property (nonatomic, strong) UICollectionView *imageCollectionView;
@end

@implementation UploadImageTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] initForAutoLayout];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
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
