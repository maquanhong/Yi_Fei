//
//  EditPriceController.h
//  Yi_Fei
//
//  Created by yons on 16/12/16.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditPriceController.h"
#import "OfferPriceModel.h"
#import "EditSelectViewCell.h"
#import "EditSelectOneViewCell.h"
#import "SelectOneView.h"
#import "SelectTwoView.h"


@interface EditPriceController : UIViewController<EditSelectOneViewCellDelegate,SelectOneViewDelegate,SelectTwoViewDelegate>

@property (nonatomic,strong) OfferPriceModel *model;

@end
