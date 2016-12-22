//
//  CardNameController.h
//  Yi_Fei
//
//  Created by yons on 16/12/17.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerModel.h"

@interface CardNameController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong)SupplyModel *model;






@end

