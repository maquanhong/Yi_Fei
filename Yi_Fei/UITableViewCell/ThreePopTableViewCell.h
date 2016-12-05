//
//  ThreePopTableViewCell.h
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/29.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownListButton.h"

@interface ThreePopTableViewCell : UITableViewCell
@property (nonatomic, strong, readonly) UILabel  *titleLabel;
@property (nonatomic, strong, readonly) UILabel  *valueDescLabel;
@property (nonatomic, strong, readonly) DownListButton  *downBtn;
@property (nonatomic, strong, readonly) UILabel  *valueDescLabel1;
@property (nonatomic, strong, readonly) DownListButton  *downBtn1;
@property (nonatomic, strong, readonly) UILabel  *valueDescLabel2;
@property (nonatomic, strong, readonly) DownListButton  *downBtn2;
@end
