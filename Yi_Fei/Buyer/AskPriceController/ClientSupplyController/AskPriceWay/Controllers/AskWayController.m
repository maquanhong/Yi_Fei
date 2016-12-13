//
//  QueryPriceViewController.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/12/3.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "AskWayController.h"
#import "ShopListController.h"
#import "AddOneProductionController.h"
#import "DownSheet.h"
#import "ShopListController.h"
#import "CCZSegementController.h"
#import "AlreadyController.h"
#import "ReservedController.h"
#import "RetentionController.h"


@interface AskWayController ()<DownSheetDelegate>
{
    BOOL isSelect;
}

@property (nonatomic, strong) DownSheet *sheet;
@property (nonatomic, strong) NSArray *MenuList;

@end

@implementation AskWayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    isSelect = YES;
    [self setNav];
    [self createScrollerView];
    
}

#pragma mark 设置导航栏
-(void)setNav {
    self.title = @"询价";
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=leftBtnItem;
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addProduct)];
    self.navigationItem.rightBarButtonItem=rightButton;
}

- (void)leftButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
    [_sheet removeFromSuperview];
}

-(void)addProduct{
    if (isSelect) {
        [self initDemoData];
        _sheet = [[DownSheet alloc]initWithlist:_MenuList height:0];
        _sheet.delegate = self;
        [_sheet showInView:nil];
        isSelect = NO;
    }else{
        [_sheet removeFromSuperview];
        isSelect = YES;
    }
}

-(void)initDemoData{
    DownSheetModel *Model1 = [[DownSheetModel alloc]init];
    Model1.icon = @"tianjiashangpin_icon";
    Model1.title = @"添加商品";
    DownSheetModel *Model2 = [[DownSheetModel alloc]init];
    Model2.icon = @"shoudong.png";
    Model2.title = @"新建商品";
    _MenuList = [[NSArray alloc]init];
    _MenuList = @[Model1,Model2];
    
}

-(void)didSelectIndex:(NSInteger)index{
    if (index == 0) {
    ShopListController *shopListVC = [[ShopListController alloc] init];
    [self.navigationController pushViewController:shopListVC animated:YES];
    }else if (index == 1){
    AddOneProductionController *addOneVc = [[AddOneProductionController alloc] init];
        [self.navigationController pushViewController:addOneVc animated:YES];
    }
}



-(void)createScrollerView{
    
    AlreadyController *oneView = [[AlreadyController alloc] init];
    ReservedController *twoView = [[ReservedController alloc] init];
    RetentionController *threeView = [[RetentionController alloc] init];
    CCZSegementController *segement = [CCZSegementController segementControllerWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) titles:@[@"已报价",@"预留报价",@"留样报价"]];
    [segement setSegementTintColor:COLOR];
    [segement setSegementViewControllers:@[oneView,twoView,threeView]];
    [segement setSelectedItemAtIndex:[_flag integerValue]];
    segement.style = CCZSegementStyleDefault;
    [segement selectedAtIndex:^(NSInteger index) {
        NSLog(@"index %ld",index);
    }];
    [self.view addSubview:segement.view];
    [self addChildViewController:segement];
}





























//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 1;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *identify = @"cell";
//    QueryPriceTableViewCell *cell = (QueryPriceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
//    if (!cell) {
//        cell = [[QueryPriceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
//    }
//    cell.delegate = self;
//    cell.productImageView.image = [UIImage imageNamed:@"logo.png"];
//    
//    cell.nameLabel.text = @"梦幻水晶吊灯";
//    cell.nameLabel.font = [UIFont systemFontOfSize:19];
//    cell.pricelabel.text = @"价格：200";
//    [cell.queryBtn setTitle:@"询价" forState:UIControlStateNormal];
//    [cell.imageQueryBtn setTitle:@"留样询价" forState:UIControlStateNormal];
//    return cell;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100;
//}
//
//- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
//    
//}
//
//#pragma mark QueryPriceTableViewCellDelegate
//- (void)queryPrice:(QueryPriceTableViewCell *)cell {
//    AskProductPriceTableViewController *askVc = [[AskProductPriceTableViewController alloc] init];
//    [self.navigationController pushViewController:askVc animated:YES];
//}
//
//- (void)imageQueryPrice:(QueryPriceTableViewCell *)cell {
//    ImageAskProductPriceTableViewController *askVc = [[ImageAskProductPriceTableViewController alloc] init];
//    [self.navigationController pushViewController:askVc animated:YES];
//}
//
//
//
//
//
//
//#pragma mark XHSegmentControlDelegate
//- (void)xhSegmentSelectAtIndex:(NSInteger)index animation:(BOOL)animation {
//    
//}
//
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [_sheet removeFromSuperview];
//    
//}


@end
