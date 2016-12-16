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
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    isSelect = YES;
    [self setNav];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
self.navigationController.navigationBar.hidden = NO;
}

#pragma mark 设置导航栏
-(void)setNav {
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = BACKCOLOR;
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"询价";
    titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView).offset(10);
        make.centerX.equalTo(backView);
        make.height.mas_equalTo(20);
    }];
    
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    [backView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(10);
        make.centerY.equalTo(backView).offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 40));
    }];
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    _rightBtnOne = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtnOne setImage:[UIImage imageNamed:@"xinjian"] forState:UIControlStateNormal];
    [backView addSubview:_rightBtnOne];
    [_rightBtnOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view).offset(-10);
        make.centerY.equalTo(backView).offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_rightBtnOne addTarget:self action:@selector(addProduct) forControlEvents:UIControlEventTouchUpInside];
    
    _rightBtnTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtnTwo setImage:[UIImage imageNamed:@"点点"] forState:UIControlStateNormal];
    [backView addSubview:_rightBtnTwo];
    [_rightBtnTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view).offset(-10);
        make.centerY.equalTo(backView).offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    _rightBtnTwo.hidden = YES;
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
    shopListVC.model = self.model;
    [self.navigationController pushViewController:shopListVC animated:YES];
    }else if (index == 1){
    AddOneProductionController *addOneVc = [[AddOneProductionController alloc] init];
        [self.navigationController pushViewController:addOneVc animated:YES];
    }
}



-(void)createScrollerView{
    
    AlreadyController *oneView = [[AlreadyController alloc] init];
    oneView.model = self.model;
    ReservedController *twoView = [[ReservedController alloc] init];
    twoView.model = self.model;
RetentionController *threeView = [[RetentionController alloc] init];
    threeView.model = self.model;
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createScrollerView];
self.navigationController.navigationBar.hidden = YES;
}


















@end
