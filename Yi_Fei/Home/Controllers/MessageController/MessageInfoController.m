//
//  MessageInfoController.m
//  Yi_Fei
//
//  Created by yons on 16/11/22.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.

#import "MessageInfoController.h"
#import "InformationCell.h"
#import "MessageModel.h"
@interface MessageInfoController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;



// 分页的页码
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation MessageInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self downloadData];
  self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createTableView];
    
    [self createRefresh];
    
}


/**上下拉刷新*/
- (void)createRefresh {
    
    // 添加下拉刷新  在downloadData方法中刷新数据
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 调用刷新数据的方法
        [self downloadData];
    }];
    
    // 将刷新控件添加于表格视图上
    self.tableView.header = header;
    
    // 添加上拉加载
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 调用加载更多的方法
        [self loadMoreData];
    }];
    self.tableView.footer = footer;
    
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
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell"];
    if (cell == nil) {
        cell = [[InformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InfoCell"];
    }
    
    
    
    
    //    xym
    MessageModel *model;
    if (self.dataArray.count>0) {
        model = self.dataArray[indexPath.row];
    }

    
    cell.titleLabel.text = model.title;
    cell.detailLabel.text = model.content;
    if ([model.type isEqualToString:@"0"]) {
        cell.certainLabel.text = @"未读";
    }
    
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}




- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataArray;
    
}


//请求数据xym
- (void)downloadData{
    self.currentIndex = 1;

    NSString *str=@"/easyfair-webservice/sysUserMessage/getMessageByType";
    NSString *urlStrinx=[NSString stringWithFormat:@"%@%@",Website,str];
    
    //     获取token
    NSUserDefaults *tokenDeful = [NSUserDefaults standardUserDefaults];
    NSString *token = [tokenDeful objectForKey:@"token"];
    
    //全部回复
    NSDictionary  *dicDay=@{
        @"token": token,
        @"userType": @"ch",
        @"type": @"0",
        @"pageNo": @(self.currentIndex),
        @"pageSize": @(10)
    };
    
    
    [[NetWorkingManager getManager]POST:urlStrinx parameters:dicDay success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject[@"code"]isEqualToString:@"200"]) {
            [self.dataArray removeAllObjects];
            
            for (NSDictionary *dic in responseObject[@"messageList"]) {
                MessageModel *model = [[MessageModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self.tableView.header endRefreshing];
            });
            
            
            
            
        }else{
            UIAlertController *actro = [UIAlertController alertControllerWithTitle:@"提示" message:responseObject[@"message"] preferredStyle:(UIAlertControllerStyleAlert)];
            [self presentViewController:actro animated:YES completion:nil];
            
            [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(creatAlertx:) userInfo:actro repeats:NO];
            

            
        }
        
    }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                    
                                    
     }];
    
    
}


- (void)loadMoreData{
    self.currentIndex++;
    
    NSString *str=@"/easyfair-webservice/sysUserMessage/getMessageByType";
    NSString *urlStrinx=[NSString stringWithFormat:@"%@%@",Website,str];
    
    //     获取token
    NSUserDefaults *tokenDeful = [NSUserDefaults standardUserDefaults];
    NSString *token = [tokenDeful objectForKey:@"token"];
    
    //全部回复
    NSDictionary  *dicDay=@{
                            @"token": token,
                            @"userType": @"ch",
                            @"type": @"0",
                            @"pageNo": @(self.currentIndex),
                            @"pageSize": @(10)
                            };
    
    
    [[NetWorkingManager getManager]POST:urlStrinx parameters:dicDay success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject[@"code"]isEqualToString:@"200"]) {
            
            for (NSDictionary *dic in responseObject[@"messageList"]) {
                MessageModel *model = [[MessageModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self.tableView.footer endRefreshing];
            });
            
            
            
        }else{
            UIAlertController *actro = [UIAlertController alertControllerWithTitle:@"提示" message:responseObject[@"message"] preferredStyle:(UIAlertControllerStyleAlert)];
            [self presentViewController:actro animated:YES completion:nil];
            
            [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(creatAlertx:) userInfo:actro repeats:NO];
            
            
            
        }
        
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                    
                                    
     }];
    
    
}



- (void)creatAlertx:(NSTimer *)timer{
    UIAlertController *alert = [timer userInfo];
    [alert dismissViewControllerAnimated:YES completion:nil];
    alert = nil;
}
















@end

























