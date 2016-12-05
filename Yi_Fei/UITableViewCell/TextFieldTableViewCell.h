//
//  TextFieldTableViewCell.h
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/20.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldTableViewCell : UITableViewCell
@property (nonatomic, strong, readonly) UILabel  *titleLabel;
@property (nonatomic, strong, readonly) UITextField *valueTextField;
@end
