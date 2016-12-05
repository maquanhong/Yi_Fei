//
//  MessageTradeController.m
//  Yi_Fei
//
//  Created by yons on 16/11/22.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "MessageTradeController.h"
#import "InformationCell.h"


@interface MessageTradeController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation MessageTradeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createTableView];
    
}

-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_tableView registerClass:[InformationCell class] forCellReuseIdentifier:@"InfoCell"];
    
}

#pragma tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell"];
    if (cell == nil) {
        cell = [[InformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InfoCell"];
    }
    
    cell.titleLabel.text = @"资讯消息标题";
    cell.detailLabel.text = @"这是资讯消息概述部分";
    
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}











@end
















