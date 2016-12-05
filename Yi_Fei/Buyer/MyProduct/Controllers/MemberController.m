//
//  MemberController.m
//  Yi_Fei
//
//  Created by yons on 16/11/24.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "MemberController.h"
#import "MemberTwoViewCell.h"
#import "MemberOneViewCell.h"
#import "Header.h"



NSString * const HUDDismissNotification = @"HUDDismissNotification";
@interface MemberController ()<UITableViewDelegate,UITableViewDataSource,MemberOneViewCellDelegate,MemberTwoViewCellDelegate>
{
    MemberOneViewCell *firstCell;
    MemberTwoViewCell *secondCell;

    
}
@property (nonatomic, strong) NSArray  *contenArray;
@property (nonatomic, strong) NSArray  *payArray;
@property (nonatomic, strong) NSArray  *TitleArray;
@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) UILabel   *moneyLabel;

@end

@implementation MemberController

- (void)viewDidLoad {
    [super viewDidLoad];
self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _TitleArray = [[NSArray alloc] initWithObjects:@"会员类型",@"付款方式", nil];
    _contenArray  = @[@{@"name":@"白钻会员",@"price":@"500/年"},@{@"name":@"金钻会员",@"price":@"1000/年"}];
    _payArray  = @[@{@"name":@"支付宝",@"picture":@"zhifubao"},@{@"name":@"微信",@"picture":@"weixin"}];
    [self createnavigationView];
    [self createTableView];
    
}

#pragma mark 创建导航栏
-(void)createnavigationView{
    self.navigationItem.title = @"申请付费会员";
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 创建tableView
-(void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view);
        make.trailing.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *totleMoney = [[UILabel alloc] init];
    totleMoney.text = @"费用总额:";
    totleMoney.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:totleMoney];
    [totleMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(bottomView).offset(15);
        make.centerY.mas_equalTo(bottomView);
        make.size.mas_equalTo(CGSizeMake(75, 20));
    }];
    
    _moneyLabel = [[UILabel alloc] init];
    _moneyLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(totleMoney.mas_right).offset(10);
        make.centerY.mas_equalTo(bottomView);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    
    UIButton *certainBtn = [[UIButton alloc] init];
    [certainBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    certainBtn.backgroundColor = COLOR;
    [certainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    certainBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    certainBtn.layer.cornerRadius = 5;
    [bottomView addSubview:certainBtn];
    [certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(bottomView).offset(-15);
        make.centerY.mas_equalTo(bottomView);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    [certainBtn addTarget:self action:@selector(clickCertain) forControlEvents:UIControlEventTouchUpInside];
}

#pragma   mark tableView 的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _TitleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *identifer1 = @"firstCell";
        firstCell  = [tableView dequeueReusableCellWithIdentifier:identifer1];
        if (firstCell == nil) {
            firstCell = [[MemberOneViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer1];
        }
firstCell.dict  =  [NSDictionary  dictionaryWithDictionary:_contenArray[indexPath.row]];
    firstCell.delegate = self;
        firstCell.iconImageView.tag = 2800 + indexPath.row;
    firstCell.selectionStyle =  UITableViewCellSelectionStyleNone;
        return firstCell;
    }else{
        static NSString *identifer2 = @"secondCell";
        secondCell  = [tableView dequeueReusableCellWithIdentifier:identifer2];
        if (secondCell == nil) {
            secondCell = [[MemberTwoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer2];
        }
        secondCell.dict = [NSDictionary dictionaryWithDictionary:_payArray[indexPath.row]];
        secondCell.delegate = self;
        secondCell.iconImageView.tag = 1600 + indexPath.row;
        secondCell.selectionStyle =  UITableViewCellSelectionStyleNone;
        return secondCell;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headerOneView =  [self infoSendTableView:_TitleArray[0]];
        return headerOneView  ;
    }else{
        UIView *headerTwoView = [self infoSendTableView:_TitleArray[1]];
        return headerTwoView;
    }
}


- (UIView *)infoSendTableView:(NSString *)title {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    headView.backgroundColor = [UIColor grayColor];
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
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}


#pragma mark cell的代理方法
- (void)clickButton:(UIButton *)btn index:(UITableViewCell *)index{
    btn.selected = !btn.selected;
    NSIndexPath *indexPath =  [_tableView indexPathForCell:index];
    NSInteger  num = indexPath.row;
    if (num == 0) {
    UIButton *button = [self.view viewWithTag:2801];
    button.selected = NO;
    _moneyLabel.text = @"¥500.00";

    }else{
    UIButton *button = [self.view viewWithTag:2800];
    button.selected = NO;
    _moneyLabel.text = @"¥1000.00";

    }
}

#pragma mark 支付方式的选择
- (void)payWay:(UIButton *)btn num:(UITableViewCell *)num{
    btn.selected = !btn.selected;
    NSIndexPath *indexPath =  [_tableView indexPathForCell:num];
    NSInteger  index = indexPath.row;
    if (index == 0) {
        UIButton *button = [self.view viewWithTag:1601];
        button.selected = NO;
  
    }else{
        UIButton *button = [self.view viewWithTag:1600];
        button.selected = NO;
    
    }
}

#pragma mark 支付
-(void)clickCertain{
  

    
    
}




























@end



















