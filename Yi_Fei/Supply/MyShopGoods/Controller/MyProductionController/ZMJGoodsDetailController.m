//
//  DetailpriceViewController.m
//  YiFei
//
//  Created by yangyan on 16/8/31.
//  Copyright © 2016年 yous. All rights reserved.
//


#import "ZMJGoodsDetailController.h"
#import "DetailViewFirstCell.h"
#import "DetailViewSecondCell.h"
#import "DetailViewThreeCell.h"
#import "InfoSendViewController.h"
#import "SGActionSheet.h"


@interface ZMJGoodsDetailController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,SGActionSheetDelegate>
{
    DetailViewFirstCell *firstCell;
    DetailViewSecondCell *secondCell;
    DetailViewThreeCell *threeCell;
}

@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) HYActivityView *activityView;

@property(copy  ,nonatomic) NSMutableArray *array;

@end

@implementation ZMJGoodsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
     [self createNavigationView];
     [self addContentView];
}

#pragma mark 创建导航栏
-(void)createNavigationView{
    
    self.navigationItem.title = @"商品详情";
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
  BackButton *rightBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [rightBtn setImage:[UIImage imageNamed:@"点点"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(shareProduct) forControlEvents: UIControlEventTouchUpInside];
   self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)shareProduct{
    
    SGActionSheet * sheet = [[SGActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitleArray:@[@"发送"]];
    sheet.cancelButtonTitleColor = [UIColor redColor];
    [sheet show];
}

- (void)SGActionSheet:(SGActionSheet *)actionSheet didSelectRowAtIndexPath:(NSInteger)indexPath {
    InfoSendViewController *sendView = [[InfoSendViewController alloc] init];
    sendView.shopData = _shopData;
    [self.navigationController pushViewController:sendView animated:YES];
}


#pragma mark 创建视图模块
-(void)addContentView{
    
    _tableView  =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_tableView];
    [_tableView reloadData];
}

#pragma mark -- tableView代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.row == 0) {
        static NSString *identifer1=@"DetailFirstCell";
        firstCell  = [tableView dequeueReusableCellWithIdentifier:identifer1];
        if (firstCell == nil) {
            firstCell = [[DetailViewFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer1];
        }
    firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
    firstCell.shopObjc = self.shopData;
    return firstCell;
    }else if (indexPath.row == 1){
        static NSString *identifer2 = @"DetailSecondCell";
        secondCell  = [tableView dequeueReusableCellWithIdentifier:identifer2];
        if (secondCell == nil) {
            secondCell = [[DetailViewSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer2];
        }
        
        secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return secondCell;
        
    }else if (indexPath.row == 2){
        static NSString *identifer3 = @"DetailThreeCell";
        threeCell  = [tableView dequeueReusableCellWithIdentifier:identifer3];
        if (threeCell == nil) {
            threeCell = [[DetailViewThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer3];
        }
        threeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return threeCell;
    }else{
        return nil;
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 200;
    }else if (indexPath.row == 1){
        return 100;
    }else if (indexPath.row == 2){
        return 260;
    }else{
        return 0;
    }
}


//设置section的header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  
  UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 260)];
     backView.backgroundColor  =   [UIColor whiteColor];
    
    _array = [NSMutableArray array];
    if (_shopData.imageOne) {
        UIImage *imageOne = [UIImage imageWithData:_shopData.imageOne];
        [_array addObject:imageOne];
    }
    if (_shopData.imageTwo) {
        UIImage *imageTwo = [UIImage imageWithData:_shopData.imageTwo];
        [_array addObject:imageTwo];
    }
    
    if (_shopData.imageThree) {
        UIImage *imageThree = [UIImage imageWithData:_shopData.imageThree];
        [_array addObject:imageThree];
    }
    
    if (_shopData.imageFour) {
        UIImage *imageFour = [UIImage imageWithData:_shopData.imageFour];
        [_array addObject:imageFour];
    }

    SDCycleScrollView *cycleScrollView=[SDCycleScrollView   cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH, 180) imageNamesGroup:_array];
    cycleScrollView.bannerImageViewContentMode =  UIViewContentModeRedraw;
    [backView addSubview:cycleScrollView];
    
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.font = [UIFont systemFontOfSize:18];
    if (_shopData.shopName.length != 0) {
    titleLable.text = _shopData.shopName;
    }else{
    titleLable.text = @"akjfpaifipa";
    }

    [backView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(cycleScrollView).offset(10);
        make.top.mas_equalTo(cycleScrollView.mas_bottom).offset(15);
        make.height.mas_equalTo(20);
        make.trailing.mas_equalTo(cycleScrollView).offset(-10);
    }];
    
   UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"价格";
    nameLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(titleLable);
        make.top.mas_equalTo(titleLable.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(30);
    }];
    
   UILabel * priceLabel = [[UILabel alloc] init];
    priceLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.text = _shopData.shopPrice;
    [backView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(nameLabel.mas_centerY);
        make.height.mas_equalTo(20);
        make.trailing.mas_equalTo(backView).offset(-10);
    }];
    return backView;
}
//在设置section的header的时候，必须要结合设置header的高度，否则header不显示(要想实现section的header的话 必须要设置其高度，否则不显示)
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 250;
}










//如果要做的话，可以看下这个文档http://bbs.mob.com/thread-20938-1-1.html



































@end






































