
//
//  OneViewController.m
//  Yi_Fei
//
//  Created by yons on 16/12/21.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "OneViewController.h"
#import "HeaderWayView.h"
#import "BuyerAskCell.h"
#import "FooterView.h"
#import "AddController.h"
#import "CustomerEditController.h"
#import "CustomerProductList.h"
#import "UserDefaultManager.h"
#import "SupplySendController.h"
#import "CustomerProductModel.h"

@interface OneViewController ()<UITableViewDelegate,UITableViewDataSource,BuyerAskCellDelegate,FooterViewDelegate>{
    CustomerProductList *_manager;
    BOOL _isPress;
    BOOL _isSelect;
}

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *circleArray;

#pragma mark 报价数据源
@property (nonatomic,strong) NSMutableArray *leaveArray;

@end

@implementation OneViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

-(void)loadData{
      _manager = [CustomerProductList defaultManager];
    _leaveArray = [NSMutableArray arrayWithArray: [_manager getDataName:_model.customerName and:_model.companyName and:@"2"]];
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = INTERFACECOLOR;
    [UserDefaultManager saveDataWithValue:self.seeNum key:@"key"];
    [UserDefaultManager saveDataWithValue:_model.customerName key:@"name"];
    [UserDefaultManager saveDataWithValue:_model.companyName key:@"company"];
    _circleArray = [NSMutableArray array];
    _isPress = NO;
    [self setNav];
    [self createTableView];
}

- (void)setNav {
    self.navigationItem.title = @"报价清单";
    BackButton* leftBtn= [BackButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=leftBtnItem;
    BackButton* rightBtn= [BackButton buttonWithType:UIButtonTypeCustom];
[rightBtn setImage:[UIImage imageNamed:@"点点"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
[rightBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
}

- (void)leftButtonClick {
  [self.navigationController popViewControllerAnimated:YES];
}


-(void)createTableView{
    
    HeaderWayView *view = [[HeaderWayView alloc] initWithFrame:CGRectMake(10, 74, WIDTH - 20, 80)];
    view.backgroundColor = [UIColor whiteColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8,8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    view.titleLabel.text = _model.customerName;
    [self.view addSubview:view];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 155, WIDTH-20, HEIGHT-155 )style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    UILongPressGestureRecognizer *lp = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    //触发长按手势的最小时间间隔，秒
    lp.minimumPressDuration = 0.5;
    [_tableView addGestureRecognizer:lp];
    
   FooterView *footerView = [[FooterView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
    footerView.delegate  = self;
    _tableView.tableFooterView = footerView;
    
}

-(void)clickBtn{

    AddController *addVC = [[AddController alloc] init];
[self.navigationController pushViewController:addVC animated:YES];
    
}


#pragma mark tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _leaveArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"BuyerAskCell";
    BuyerAskCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
 cell = [[BuyerAskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    CustomerProductModel *dataModel = _leaveArray[indexPath.row];
    if (dataModel.imageOne) {
    cell.iconImageView.image = [UIImage imageWithData:dataModel.imageOne];
    }else{
    cell.iconImageView.image = [UIImage imageNamed:@"Null"];
    }
    if (dataModel.shopName) {
    cell.titleLabel.text = dataModel.shopName;
    }
    if (dataModel.shopPrice) {
    cell.price.text = [NSString stringWithFormat:@"¥%@",dataModel.shopPrice];
    }
    cell.delegate = self;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)clickcell:(UITableViewCell *)cell num:(NSInteger)num{

    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    
    switch (num) {
        case 1280:
        {
    CustomerEditController *editVC = [[CustomerEditController alloc] init];
    editVC.model = _leaveArray[indexPath.row];
    [self.navigationController pushViewController:editVC animated:YES];
        }
            break;
        case 1281:
        {
    _manager = [CustomerProductList defaultManager];
CustomerProductModel *dataModel = [[CustomerProductModel alloc] init];
    dataModel = _leaveArray[indexPath.row];
    NSString *str = [NSString stringWithFormat:@"%d",dataModel.ind];
    [_manager deleteElement:dataModel.customerName and:dataModel.companyName index:@"2" num:str];
    [_leaveArray  removeObjectAtIndex:indexPath.row];
    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tableView reloadData];
        }
            break;
        default:
            break;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isSelect ) {
        BuyerAskCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        NSString *str = [NSString stringWithFormat:@"%ld",indexPath.row];
        if ([_circleArray containsObject:str]) {
            cell.selectBtn.selected = NO ;
            [_circleArray removeObject:str];
        }else{
            cell.selectBtn.selected = YES ;
            [_circleArray addObject:str];
        }
    }
}


- (void)longPressGesture:(UILongPressGestureRecognizer*)lp{
    if(lp.state == UIGestureRecognizerStateBegan){
        if (_isPress) {
            NSArray *allCells=[_tableView visibleCells];
            for(BuyerAskCell *cell in allCells)
            {
            cell.selectBtn.hidden=NO;
            cell.selectBtn.selected=NO;
            }
            _isPress = NO;
            _isSelect = YES;
        }else{
            NSArray *allCells=[_tableView visibleCells];
            for(BuyerAskCell *cell in allCells){
                cell.selectBtn.hidden=YES;
            }
            _isPress = YES;
            _isSelect = NO;
        }
    }

}



-(void)rightButtonClick{
    
    NSString *strOne = [UserDefaultManager getDataByKey:@"name"];
    NSString *strTwo = [UserDefaultManager getDataByKey:@"link"];
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    CustomerProductModel  *model = [[CustomerProductModel alloc] init];
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0 ; i <_circleArray.count ; i++) {
        NSString *index = [_circleArray objectAtIndex:i];
        model = _leaveArray[[index integerValue]];
        model.flag = @"2";
       [array addObject:model];
    }
    SupplySendController * sendVC = [[SupplySendController alloc] init];
    sendVC.dataArray = [NSArray arrayWithArray:array];
    sendVC.supplyName = strOne;
    sendVC.companyName = strTwo;
    sendVC.offerTime = dateString;
    [self.navigationController pushViewController:sendVC animated:YES];
    
}




















































@end

















