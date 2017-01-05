//
//  InformationCell.h
//  Yi_Fei
//
//  Created by yons on 16/11/22.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationCell : UITableViewCell

@property (nonatomic, strong) UILabel  *titleLabel;

@property (nonatomic, strong) UILabel  *detailLabel;


@property (nonatomic, strong) UIImageView  *iconImage;
@property (nonatomic, strong) UIImageView  *tagImage;
@property (nonatomic, strong) UILabel  *certainLabel;

@end
