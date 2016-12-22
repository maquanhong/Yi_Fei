//
//  CustomerEditController.h
//  Yi_Fei
//
//  Created by yons on 16/12/21.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditPriceController.h"
#import "AskPriceModel.h"
#import "EditSelectViewCell.h"
#import "EditSelectOneViewCell.h"
#import "SelectOneView.h"
#import "SelectTwoView.h"

@interface CustomerEditController : UIViewController<EditSelectOneViewCellDelegate,SelectOneViewDelegate,SelectTwoViewDelegate>

@property (nonatomic,strong) AskPriceModel *model;


@end
