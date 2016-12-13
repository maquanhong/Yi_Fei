//
//  SalerViewController.m
//  YiFei
//
//  Created by yangyan on 16/8/30.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "AskPriceSupplyController.h"
#import "ZMJMyProductionCell.h"
#import "BuyerTableViewCell.h"
#import "MyBuyerViewController.h"
#import "AddSupplyViewController.h"


#import "AskWayController.h"
#import "DownSheet.h"
@interface AskPriceSupplyController ()<DownSheetDelegate,UITextFieldDelegate>{

    BOOL _isSearch;
    BOOL _btnSearch;
    BOOL _nilSearch;
    NSArray *array;
    UIView *addTableV;
    BOOL isSelect;
 
}
@property(nonatomic,strong)UITextField *textInput; //输入框
@property(nonatomic,strong)NSMutableArray *listArray;  //保存的数据
@property(nonatomic,strong)UITableView *tableview; //表格视图
@property(nonatomic,strong)UIView *searchBackView; //搜索的背景图片
@property (nonatomic, strong) NSMutableArray *searchResultArr; //输入时的结果
@property (nonatomic, strong) NSMutableArray *btnResultArr; //点击按钮时的结果
@property (nonatomic, strong) NSMutableArray *allArray; //搜索的结果
@property (nonatomic, strong) UILabel *numLabel; //有多少个元素
@property (nonatomic, strong)  NewTwoList *manager;
@property (nonatomic, strong)  NSMutableArray *circleArray;
@property (nonatomic, strong) DownSheet *sheet;
@property (nonatomic, strong) NSArray *MenuList;

@property(nonatomic,strong)UISearchController *searchC;

@end

@implementation AskPriceSupplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    isSelect = YES;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createNavigationView];
    [self createSearchView];
    [self createTableView];
    
}

#pragma mark 创建导航栏
-(void)createNavigationView
{
    self.title = @"供应商列表";
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    BackButton *rightBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"xinjian"] forState:UIControlStateNormal];
    UIBarButtonItem * barRightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = barRightItem;
    [rightBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
    [_sheet removeFromSuperview];
}

#pragma mark 出现头部视图
-(void)rightButtonClick{
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
    Model1.icon = @"saoyisao-0";
    Model1.title = @"扫一扫";
    DownSheetModel *Model2 = [[DownSheetModel alloc]init];
    Model2.icon = @"shoudong.png";
    Model2.title = @"手动添加供应商";
    _MenuList = [[NSArray alloc]init];
    _MenuList = @[Model1,Model2];
    
}

-(void)didSelectIndex:(NSInteger)index{
    
    if (index == 0) {
    NSLog(@"%ld",index);
    }else if (index == 1){
     NSLog(@"%ld",index);
    }
}


#pragma mark 设置搜索框
-(void)createSearchView{
    
    _searchBackView = [[UIView alloc]init];
    _searchBackView.backgroundColor = [UIColor whiteColor];
    _searchBackView.userInteractionEnabled = YES;
    [self.view addSubview:_searchBackView];
    [_searchBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view);
        make.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(64);
        make.height.mas_equalTo(50);
    }];
    
    UIView *imageBackView = [[UIView alloc]init];
    imageBackView.userInteractionEnabled = YES;
    imageBackView.layer.cornerRadius = 8;
    imageBackView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_searchBackView addSubview:imageBackView];
    [imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_searchBackView).offset(10);
        make.trailing.mas_equalTo(_searchBackView).offset(-70);
        make.centerY.mas_equalTo(_searchBackView.mas_centerY);
        make.height.mas_equalTo(30);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"sousuo"];
    [imageBackView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(imageBackView).offset(20);
        make.centerY.mas_equalTo(imageBackView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _textInput = [[UITextField alloc] init];
    _textInput.font = [UIFont systemFontOfSize:14];
    _textInput.placeholder = @"输入商品名称";
    _textInput.delegate = self;
    [_textInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [imageBackView addSubview:_textInput];
    [_textInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(5);
        make.centerY.mas_equalTo(imageBackView.mas_centerY);
        make.trailing.mas_equalTo(imageBackView);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *searchBtn = [[UIButton alloc]init];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [searchBtn setTitleColor:COLOR forState:UIControlStateNormal];
    [_searchBackView addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageBackView.mas_right).offset(15);
        make.centerY.mas_equalTo(imageBackView.mas_centerY);
        make.height.mas_equalTo(40);
        make.trailing.mas_equalTo(_searchBackView).offset(-15);
    }];
    [searchBtn addTarget:self action:@selector(clickBtnSearch) forControlEvents:UIControlEventTouchUpInside];
}


-(void)createTableView{
    _tableview=[[UITableView alloc] initWithFrame:CGRectMake(10, 140, WIDTH-20, HEIGHT- 140 )style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
}


#pragma Mark -- 事件处理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdent=@"cell";
    BuyerTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell==nil) {
        cell=[[BuyerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    cell.imgV.image=[UIImage imageNamed:@"logo.png"];
    cell.nameShop.text=array[indexPath.row];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AskWayController *salerVC=[[AskWayController alloc] init];
    [self.navigationController pushViewController:salerVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_sheet removeFromSuperview];
    
}










@end









