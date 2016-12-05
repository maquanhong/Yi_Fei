//
//  OnePopTableViewCell.h
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/29.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownListButton.h"
#import "DownListBgView.h"

@interface OnePopTableViewCell : UITableViewCell
@property (nonatomic, strong, readonly) UILabel  *titleLabel;
@property (nonatomic, strong, readonly) UITextField *valueTextField;
@property (nonatomic, strong, readonly) UILabel  *valueDescLabel;
@property (nonatomic, strong, readonly) DownListButton  *downBtn;
@end
