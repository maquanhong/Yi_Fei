//
//  SupplySendController.m
//  Yi_Fei
//
//  Created by yons on 17/1/4.
//  Copyright © 2017年 ZMJPersonal. All rights reserved.


#import "SupplySendController.h"
#import "SendTableViewCell.h"
#import "FooterView.h"
#import "UserDefaultManager.h"
#import "SupplyComeOut.h"

@interface SupplySendController ()<UITableViewDataSource, UITableViewDelegate,FooterViewDelegate>
{
    SupplyComeOut * _supplyOut;
    SendTableViewCell *firstell;
    SendTableViewCell *secondCell;
}

@property (nonatomic, strong) UITableView   *tableView;


#pragma mark 数据源
@property (nonatomic, strong) NSArray  *titleArray;

@end

@implementation SupplySendController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor =  INTERFACECOLOR;
    [self createNavigationView];
    _titleArray = [[NSArray alloc] initWithObjects:@"发送方式",@"资料格式", nil];
    [self addViewConstraints];
}

#pragma mark 创建navgationView
-(void)createNavigationView{
    
    self.navigationItem.title = @"商品资料发送";
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 添加视图
- (void)addViewConstraints {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    FooterView *footerView = [[FooterView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 150)];
    [footerView.footerBtn setTitle:@"发送" forState:UIControlStateNormal];
    footerView.delegate  = self;
    _tableView.tableFooterView = footerView;
    
}


#pragma mark tableView 的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
   static NSString *identifer1 = @"firstCell";
        firstell = [tableView dequeueReusableCellWithIdentifier:identifer1];
        if (!firstell) {
    firstell = [[[NSBundle mainBundle] loadNibNamed:@"SendTableViewCell" owner:self options:nil] lastObject];
        }
        firstell.titleLabel.text = @"蓝牙";
        return firstell;
    }else{
        static NSString *identifer1 = @"firstCell";
        secondCell = [tableView dequeueReusableCellWithIdentifier:identifer1];
        if (!secondCell) {
            secondCell = [[[NSBundle mainBundle] loadNibNamed:@"SendTableViewCell" owner:self options:nil] lastObject];
        }
        secondCell.titleLabel.text = @"Excel";
        return secondCell;
    }
}

#pragma mark cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headerOneView =  [self infoSendTableView:_titleArray[0]];
        return headerOneView  ;
    }else{
        UIView *headerTwoView = [self infoSendTableView:_titleArray[1]];
        return headerTwoView;
    }
}

#pragma mark tableView的组头
- (UIView *)infoSendTableView:(NSString *)title {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    headView.backgroundColor =  INTERFACECOLOR ;
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:14];
    [headView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(headView).offset(20);
        make.centerY.mas_equalTo(headView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}




-(void)clickBtn{

    NSString *str = [UserDefaultManager getDataByKey:@"key"];

    if ([str integerValue] == 1) {
        
        _supplyOut = [[SupplyComeOut alloc] init];
        _supplyOut.objcArray = self.dataArray;
        _supplyOut.companyName = self.companyName;
        _supplyOut.supplyName = self.supplyName;
        _supplyOut.offerTime = self.offerTime;
        _supplyOut.reverTime = self.reverTime;
        [_supplyOut sendToBuyerExcel];
        
        
    }else if ([str integerValue] == 2){
        _supplyOut = [[SupplyComeOut alloc] init];
        _supplyOut.objcArray = self.dataArray;
        _supplyOut.companyName = self.companyName;
        _supplyOut.supplyName = self.supplyName;
        _supplyOut.offerTime = self.offerTime;
        [_supplyOut sendToBuyerExcel];
    }
}





















@end











