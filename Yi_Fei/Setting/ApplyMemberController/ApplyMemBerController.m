//
//  ApplyMemBerController.m
//  Yi_Fei
//
//  Created by yons on 16/12/12.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ApplyMemBerController.h"
#import "BUYButton.h"
#import "MemberFirstCell.h"
#import "MemBerSecondCell.h"

@interface ApplyMemBerController ()<UITableViewDelegate,UITableViewDataSource,MemBerSecondCellDelegate,MemberFirstCellDelegate>
{
    MemberFirstCell *firstCelll;
    MemBerSecondCell *secondCell;

}

@property (nonatomic,strong)UILabel *labelOne;
@property (nonatomic,strong)UILabel *labelTwo;
@property (nonatomic,strong)UIButton *certainBtn;
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *tileArray;
@property (nonatomic,strong)NSArray *contenArray;
@property (nonatomic,strong)NSArray *payArray;

@end

@implementation ApplyMemBerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请付费会员";
    _tileArray = [[NSArray alloc] initWithObjects:@"会员类型",@"付款方式", nil];
    _payArray  = @[@{@"name":@"支付宝",@"picture":@"zhifubao"},@{@"name":@"微信",@"picture":@"weixin"}];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createNavigationView];
    [self createUI];
}

-(void)createNavigationView
{
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)leftButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)createUI{

    _backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];

    _labelOne = [[UILabel alloc] init];
    _labelOne.text = @"费用总额：";
    _labelOne.font = [UIFont systemFontOfSize:14];
    [_backView addSubview:_labelOne];
    [_labelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_backView.mas_centerY).offset(5);
        make.leading.equalTo(_backView).offset(15);
        make.height.mas_equalTo(20);
    }];

    
    _labelTwo = [[UILabel alloc] init];
    _labelTwo.text = @"¥11.99";
    _labelTwo.font = [UIFont systemFontOfSize:14];
    [_backView addSubview:_labelTwo];
    [_labelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_backView.mas_centerY).offset(5);
        make.left.equalTo(_labelOne.mas_right).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    _certainBtn = [[UIButton alloc] init];
    _certainBtn.backgroundColor = BACKCOLOR;
    _certainBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _certainBtn.layer.cornerRadius = 5;
    [_certainBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [_backView addSubview:_certainBtn];
    [_certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_backView.mas_centerY).offset(5);
        make.trailing.equalTo(self.view).offset(-20);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, WIDTH, HEIGHT - 110) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
}


#pragma   mark tableView 的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _tileArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *identifer1 = @"firstCell";
        firstCelll  = [tableView dequeueReusableCellWithIdentifier:identifer1];
        if (firstCelll == nil) {
            firstCelll = [[MemberFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer1];
        }
//        firstCelll.dict  =  [NSDictionary  dictionaryWithDictionary:_contenArray[indexPath.row]];
//        firstCelll.delegate = self;
//        firstCelll.iconImageView.tag = 2800 + indexPath.row;
        firstCelll.selectionStyle =  UITableViewCellSelectionStyleNone;
        return firstCelll;
    }else{
        static NSString *identifer2 = @"secondCell";
        secondCell  = [tableView dequeueReusableCellWithIdentifier:identifer2];
        if (secondCell == nil) {
            secondCell = [[MemBerSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer2];
        }
    secondCell.dict = [NSDictionary dictionaryWithDictionary:_payArray[indexPath.row]];
        secondCell.delegate = self;
        secondCell.iconImageView.tag = 1700 + indexPath.row;
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
        UIView *headerOneView =  [self infoSendTableView:_tileArray[0]];
        return headerOneView  ;
    }else{
        UIView *headerTwoView = [self infoSendTableView:_tileArray[1]];
        return headerTwoView;
    }
}


- (UIView *)infoSendTableView:(NSString *)title {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    headView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    [headView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(headView).offset(20);
        make.centerY.mas_equalTo(headView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    UIView *seperator = [[UIView alloc] init];
    seperator.backgroundColor = RGB(211, 211, 211);
    [headView addSubview:seperator];
    [seperator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(headView);
        make.trailing.equalTo(headView);
        make.bottom.equalTo(headView);
        make.height.mas_equalTo(0.1);
    }];
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}



#pragma mark 支付方式的选择
- (void)payWay:(UIButton *)btn num:(UITableViewCell *)num{
    btn.selected = !btn.selected;
    NSIndexPath *indexPath =  [_tableView indexPathForCell:num];
    NSInteger  index = indexPath.row;
    if (index == 0) {
        UIButton *button = [self.view viewWithTag:1701];
        button.selected = NO;
        
    }else{
        UIButton *button = [self.view viewWithTag:1700];
        button.selected = NO;
    }
}





































@end















