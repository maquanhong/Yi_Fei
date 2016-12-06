//
//  ClientViewController.m
//  YiFei
//
//  Created by maquanhong on 10/23/16.
//  Copyright © 2016 yous. All rights reserved.
//

#import "ClientViewController.h"
#import "PureLayout.h"
#import "DownListButton.h"
#import "OnlyTitleTableViewCell.h"
#import "SearchBarView.h"

@interface ClientViewController ()<UITableViewDataSource, UITableViewDelegate, SearchBarViewDelegate>
@property (nonatomic, strong) UITableView  *clientTableView;
@property (nonatomic, strong) DownListButton  *industryDownBtn;
@property (nonatomic, strong) DownListButton  *productDownBtn;
@end

@implementation ClientViewController


- (void)setNav {
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftBtn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=leftBtnItem;
}

- (void)leftButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    self.view.backgroundColor = [UIColor whiteColor];
    SearchBarView *searchView = [[SearchBarView alloc] initWithFrame:CGRectMake(0, 0, 260, 40)];
    searchView.searchBar.placeholder = @"输入公司名称";
    [searchView.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    self.navigationItem.titleView = searchView;
    _clientTableView = [[UITableView alloc] initForAutoLayout];
//    _clientTableView.dataSource = self;
//    _clientTableView.delegate = self;
    [self.view addSubview:self.clientTableView];
    
    self.clientTableView.tableFooterView = [[UIView alloc] init];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
    self.clientTableView.tableHeaderView = headerView;
    _industryDownBtn = [[DownListButton alloc] initForAutoLayout];
    _industryDownBtn.btnTitleLabel.text = @"选择行业类型";
    [headerView addSubview:self.industryDownBtn];
    
    _productDownBtn = [[DownListButton alloc] initForAutoLayout];
    _productDownBtn.btnTitleLabel.text = @"选择或者编辑商品";
    [headerView addSubview:self.productDownBtn];
    [self addViewConstraints];
    
    // Do any additional setup after loading the view.
}

- (void)addViewConstraints {
    [self.clientTableView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.clientTableView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.clientTableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.clientTableView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    
    [self.industryDownBtn autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15];
    [self.industryDownBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [self.industryDownBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [self.industryDownBtn autoSetDimension:ALDimensionWidth toSize:140];
    
    [self.productDownBtn autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:15];
    [self.productDownBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [self.productDownBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [self.productDownBtn autoSetDimension:ALDimensionWidth toSize:140];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark SearchBarViewDelegate
- (void)searchProduct:(NSString *)key barView:(SearchBarView *)barView {
    
}

@end
