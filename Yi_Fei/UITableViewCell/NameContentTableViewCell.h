//
//  NameContentTableViewCell.h
//  YTNewEnergy
//
//  Created by maquanhong on 16/1/6.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 cell 的样式为
 -----------------------------------
 |                                 |
 |文字                              |
 |文字                              |
 -----------------------------------
 */
@interface NameContentTableViewCell : UITableViewCell
@property (nonatomic, strong, readonly) UILabel  *titleLabel;
@property (nonatomic, strong, readonly) UILabel  *contentLabel;
@end
