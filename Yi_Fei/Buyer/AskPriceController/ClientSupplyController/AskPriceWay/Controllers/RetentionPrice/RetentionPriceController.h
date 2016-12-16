//
//  RetentionPriceController.h
//  Yi_Fei
//
//  Created by yons on 16/12/16.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AskPriceModel.h"

@interface RetentionPriceController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) AskPriceModel *model;

@property (nonatomic,strong) UITableView *tableView;


@end
