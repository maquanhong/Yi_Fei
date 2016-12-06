//
//  BriefProductTableViewCell.h
//  Yi_Fei
//
//  Created by maquanhong on 2016/12/6.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BriefProductTableViewCell : UITableViewCell
@property (nonatomic, strong, readonly) UIImageView *iconImageView;
@property (nonatomic, strong, readonly) UILabel    *titleLabel;
@property (nonatomic, strong, readonly) UILabel    *moreLabel;
@property (nonatomic, strong, readonly) UIImageView *productImageView;
@property (nonatomic, strong, readonly) UILabel    *productNameLabel;
@property (nonatomic, strong, readonly) UIImageView *moreImageView;
@end
