//
//  SectionTwoCell.h
//  Yi_Fei
//
//  Created by yons on 16/12/22.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeViewTextFiled.h"

@interface SectionTwoCell : UITableViewCell


@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *numberLabel;
@property (nonatomic,strong) UILabel *heightLabel;
@property (nonatomic,strong) UILabel *sizeLabel;

@property (nonatomic,strong) TypeViewTextFiled *typeOne;
@property (nonatomic,strong) TypeViewTextFiled *typeTwo;
@property (nonatomic,strong) TypeViewTextFiled *typeThree;


@end
