//
//  MySalerViewController.h
//  YiFei
//
//  Created by yangyan on 16/9/2.
//  Copyright © 2016年 yous. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySalerViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableV;


@property(nonatomic,strong)SupplyModel *model;


@end
