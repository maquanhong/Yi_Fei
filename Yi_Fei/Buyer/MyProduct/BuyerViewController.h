//
//  BuyerViewController.h
//  YiFei
//
//  Created by yangyan on 16/8/30.
//  Copyright © 2016年 yous. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
@interface BuyerViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;
- (instancetype)initWithTypeId:(BussinessType)type;
@end
