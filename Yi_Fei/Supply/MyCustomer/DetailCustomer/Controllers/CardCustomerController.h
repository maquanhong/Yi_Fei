//
//  CardCustomerController.h
//  Yi_Fei
//
//  Created by yons on 16/12/19.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerModel.h"


@interface CardCustomerController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)CustomerModel *model;

@property (nonatomic,strong) UITableView *tableView;


@end












