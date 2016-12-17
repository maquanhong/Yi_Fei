//
//  AskTwoController.h
//  Yi_Fei
//
//  Created by yons on 16/12/17.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AskTwoController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) ProductionData *model;

@property (nonatomic,strong) UITableView *tableView;

@end
