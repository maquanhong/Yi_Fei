//
//  ProductListTableViewController.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/12/6.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ProductListTableViewController.h"
#import "QueryPriceTableViewCell.h"
#import "AskProductPriceTableViewController.h"
#import "ImageAskProductPriceTableViewController.h"
@interface ProductListTableViewController ()
@property (nonatomic, strong) UISearchController *searchC;
@end

@implementation ProductListTableViewController

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
    self.title = @"商品列表";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setNav];
    //初始化搜索栏
    _searchC = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchC.searchBar.barTintColor=[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    _searchC.delegate=self;
    //是否隐藏导航
    _searchC.hidesNavigationBarDuringPresentation = NO;
    _searchC.dimsBackgroundDuringPresentation=NO;
    _searchC.searchBar.barStyle=UIBarStyleBlack;
    //自适应
    [_searchC.searchBar sizeToFit];
    //提示信息
    _searchC.searchBar.placeholder = @"请输入供应商名称或者公司名称";
    _searchC.searchBar.showsCancelButton=YES;
    UIButton *canceLBtn = [_searchC.searchBar valueForKey:@"cancelButton"];
    [canceLBtn setTitle:@"取消" forState:UIControlStateNormal];
    [canceLBtn setTitleColor:NAVCOLOR forState:UIControlStateNormal];
    //代理方法
    _searchC.searchResultsUpdater = self;
    _searchC.delegate=self;
    self.tableView.tableHeaderView = _searchC.searchBar;
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cell";
    QueryPriceTableViewCell *cell = (QueryPriceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[QueryPriceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.delegate = self;
    cell.productImageView.image = [UIImage imageNamed:@"logo.png"];
    
    cell.nameLabel.text = @"梦幻水晶吊灯";
    cell.nameLabel.font = [UIFont systemFontOfSize:19];
    cell.pricelabel.text = @"价格：200";
    [cell.queryBtn setTitle:@"询价" forState:UIControlStateNormal];
    [cell.imageQueryBtn setTitle:@"留样询价" forState:UIControlStateNormal];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

#pragma mark QueryPriceTableViewCellDelegate
- (void)queryPrice:(QueryPriceTableViewCell *)cell {
    AskProductPriceTableViewController *askVc = [[AskProductPriceTableViewController alloc] init];
    [self.navigationController pushViewController:askVc animated:YES];
}

- (void)imageQueryPrice:(QueryPriceTableViewCell *)cell {
    ImageAskProductPriceTableViewController *askVc = [[ImageAskProductPriceTableViewController alloc] init];
    [self.navigationController pushViewController:askVc animated:YES];
}

@end
