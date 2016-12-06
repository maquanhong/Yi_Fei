//
//  IconContenTableVIewCell.h
//  YTNewEnergy
//
//  Created by maquanhong on 16/1/15.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 cell 的样式为
 -----------------------------------
 | ------                          |
 | |图片 |  文字                    |
 | ------                          |
 -----------------------------------
 */
@interface IconContenTableVIewCell : UITableViewCell
@property (strong, nonatomic, readonly) UIImageView  *iconImageView;
@property (strong, nonatomic, readonly) UILabel      *titleLabel;
@end
