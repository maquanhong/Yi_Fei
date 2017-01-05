//
//  ConferenceInfoViewController.m
//  YiFei
//
//  Created by maquanhong on 10/20/16.
//  Copyright © 2016 yous. All rights reserved.
//

#import "ExhibitionViewController.h"
#import "PureLayout.h"
#import "ExhibitionViewCell.h"
#import "ExhibitionDeatailController.h"
#import "ExibitionModel.h"
@interface ExhibitionViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView  *tableView;

@property (nonatomic, strong) NSArray    *conferenceInfoArray;



// 分页的页码
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ExhibitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createNavigationView];
    
    [self downloadData];
//    _conferenceInfoArray = @[@{@"title":@"2017年波兰设备照明展",@"time":@"2016-12-30"},@{@"title":@"2017年波兰设备照明展",@"time":@"2016-12-30"},@{@"title":@"2017年波兰设备照明展",@"time":@"2016-12-30"},@{@"title":@"2017年波兰设备照明展",@"time":@"2016-12-30"},@{@"title":@"2017年波兰设备照明展",@"time":@"2016-12-30"},@{@"title":@"2017年波兰设备照明展",@"time":@"2016-12-30"},@{@"title":@"2017年波兰设备照明展",@"time":@"2016-12-30"},@{@"title":@"2017年波兰设备照明展",@"time":@"2016-12-30"},@{@"title":@"2017年波兰设备照明展",@"time":@"2016-12-30"}];
    [self.view addSubview:self.conferenceInfoTableView];
    [self addViewConstraints];
    
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




#pragma mark - 设置导航条
-(void)createNavigationView
{
    self.navigationItem.title = @"展会信息";
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)addViewConstraints {
    [self.conferenceInfoTableView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.conferenceInfoTableView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.conferenceInfoTableView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.conferenceInfoTableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString  *cellIdentify = @"ExhibitionCell";
    ExhibitionViewCell *cell = (ExhibitionViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[ExhibitionViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
//    xym
    ExibitionModel *model;
    if (self.dataArray.count>0) {
        model = self.dataArray[indexPath.row];
    }
    cell.model = model;
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (UITableView *)conferenceInfoTableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initForAutoLayout];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] initForAutoLayout];
    }
    return _tableView;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ExhibitionDeatailController *detailVC = [[ExhibitionDeatailController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}


- (NSMutableArray *)dataArray{

    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataArray;
}


//首次获取信息 xym
- (void)downloadData{
       self.currentIndex = 1;
        //     获取token
        NSUserDefaults *tokenDeful = [NSUserDefaults standardUserDefaults];
        NSString *token = [tokenDeful objectForKey:@"token"];
        
        NSString *str=@"/easyfair-webservice/sysExhibition/getExhibitionList";
        NSString *urlStrinx=[NSString stringWithFormat:@"%@%@",Website,str];
        
       NSMutableDictionary  *dicDay= [[NSMutableDictionary alloc]init];
       dicDay[@"token"] = token;
       dicDay[@"userType"] = @"ch";
       dicDay[@"pageNo"] = @(self.currentIndex);
       dicDay[@"pageSize"] = @(10);
    
    
       [[NetWorkingManager getManager]POST:urlStrinx parameters:dicDay success:^(AFHTTPRequestOperation *operation, id responseObject) {
           [self.dataArray removeAllObjects];

            NSLog(@"%@",responseObject);
           if ([responseObject[@"code"] isEqualToString:@"200"]) {
               
               for (NSDictionary *Dic in responseObject[@"exhibitionList"]) {
                   ExibitionModel *model = [[ExibitionModel alloc]init];
                   
                   [model setValuesForKeysWithDictionary:Dic];
                   [self.dataArray addObject:model];
                   
               }
                   
               dispatch_async(dispatch_get_main_queue(), ^{
                   [self.tableView reloadData];
                   [self.tableView.header endRefreshing];
                   
               });
               
               
           }
            
            
            
        }
         
         
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        
                                        
           }];
        
        
        
}

- (void)loadMoreData{
    self.currentIndex++;
    //     获取token
    NSUserDefaults *tokenDeful = [NSUserDefaults standardUserDefaults];
    NSString *token = [tokenDeful objectForKey:@"token"];
    
    NSString *str=@"/easyfair-webservice/sysExhibition/getExhibitionList";
    NSString *urlStrinx=[NSString stringWithFormat:@"%@%@",Website,str];
    
    NSMutableDictionary  *dicDay= [[NSMutableDictionary alloc]init];
    dicDay[@"token"] = token;
    dicDay[@"userType"] = @"ch";
    dicDay[@"pageNo"] = @(self.currentIndex);
    dicDay[@"pageSize"] = @(10);
    
    
    [[NetWorkingManager getManager]POST:urlStrinx parameters:dicDay success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            
            for (NSDictionary *Dic in responseObject[@"exhibitionList"]) {
                ExibitionModel *model = [[ExibitionModel alloc]init];
                
                [model setValuesForKeysWithDictionary:Dic];
                [self.dataArray addObject:model];
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self.tableView.footer endRefreshing];
                
            });
            
            
        }
        
        
        
    }
     
     
   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                    
                                    
     }];
    
    
    
}










@end



















