//
//  QueryPriceViewController.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/12/3.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "QueryPriceViewController.h"
#import "SearchBarView.h"
#import "PureLayout.h"
#import "QueryPriceTableViewCell.h"
#import "AskProductPriceTableViewController.h"
#import "ImageAskProductPriceTableViewController.h"
#import "AddOneProductionController.h"
@interface QueryPriceViewController ()<SearchBarViewDelegate,XHSegmentControlDelegate, UITableViewDelegate, UITableViewDataSource,QueryPriceTableViewCellDelegate>{
    UIView *addTableV;
}
@property (nonatomic, strong) UITableView  *productTableView;
@property (nonatomic, strong) XHSegmentControl *segmentControl;
@property (nonatomic, strong) UISearchController *searchC;
@property (nonatomic, assign) BOOL bShowAddView;
@end

@implementation QueryPriceViewController

- (void)setNav {
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftBtn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=leftBtnItem;
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addProduct)];
    self.navigationItem.rightBarButtonItem=rightButton;
}

- (void)addProduct {
    self.bShowAddView = !self.bShowAddView;
    //获取当前顶层的窗口
    UIWindow *awindow=[[UIApplication sharedApplication].windows lastObject];
    if (self.bShowAddView) {
        addTableV=[[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT)];
        addTableV.backgroundColor=[UIColor clearColor];
        UIView *bgView = [[UIView alloc] initWithFrame:addTableV.bounds];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.6;
        [addTableV addSubview:bgView];
        [awindow addSubview:addTableV];
        NSArray *imgArray=@[@"saoyisao-.png",@"shoudong.png"];
        NSArray *titleArray;
        titleArray=@[@"添加商品",@"新建商品"];
        for (int i=0; i<2; i++) {
            UIView *backV=[[UIView alloc] init];
            backV.backgroundColor = [UIColor whiteColor];
            [backV sizeToFit];
            backV.frame=CGRectMake(0, 41*i, WIDTH, 41);
            [addTableV addSubview:backV];
            
            UIImageView *imgV=[[UIImageView alloc] init];
            imgV.contentMode = UIViewContentModeCenter;
            imgV.frame=CGRectMake(10, 5, 30, 30);
            imgV.image=[UIImage imageNamed:imgArray[i]];
            [backV addSubview:imgV];
            
            
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn sizeToFit];
            btn.frame=CGRectMake(CGRectGetMaxX(imgV.frame), 5, 70, 30);
            if (i==1) {
                btn.frame=CGRectMake(CGRectGetMaxX(imgV.frame), 5, 130, 30);
                [btn addTarget:self action:@selector(btn2Click:) forControlEvents:UIControlEventTouchUpInside];
            }
            btn.tag=70+i;
            btn.titleLabel.font=[UIFont systemFontOfSize:15.0];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [backV addSubview:btn];
            
            
            UIView *lineV=[[UIView alloc] init];
            lineV.frame=CGRectMake(0, CGRectGetMaxY(backV.frame) - 1, WIDTH, 1);
            lineV.backgroundColor=[UIColor lightGrayColor];
            [backV addSubview:lineV];
        }
    }else{
        [addTableV removeFromSuperview];
    }

}

- (void)btnClick {
    AddOneProductionController *addOneVc = [[AddOneProductionController alloc] init];
    [self.navigationController pushViewController:addOneVc animated:YES];
}

- (void)leftButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"询价";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setNav];
    _segmentControl = [[XHSegmentControl alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
    self.segmentControl.delegate = self;
    self.segmentControl.titles = @[@"已报价",@"预留报价",@"留样报价"];
    [self.view addSubview:self.segmentControl];
    [self.segmentControl load];
    
    _productTableView = [[UITableView alloc] initForAutoLayout];
    self.productTableView.delegate = self;
    self.productTableView.dataSource = self;
    [self.view addSubview:self.productTableView];
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
    self.productTableView.tableHeaderView = _searchC.searchBar;
    [self addViewConstraints];
    // Do any additional setup after loading the view.
}

- (void)addViewConstraints {
    [self.productTableView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.productTableView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.productTableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.productTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.segmentControl];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark XHSegmentControlDelegate
- (void)xhSegmentSelectAtIndex:(NSInteger)index animation:(BOOL)animation {
    
}

@end
