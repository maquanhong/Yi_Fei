//
//  AddMyProductionController.m
//  Yi_Fei
//
//  Created by yons on 16/12/21.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.


#import "AddMyProductionController.h"
#import "AddContinueCell.h"
#import "ZMJEditViewController.h"
#import "ZMJGoodsDetailController.h"
#import "TranslationObjec.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "UserDefaultManager.h"
#import "CustomerProductModel.h"
#import "CustomerProductList.h"

@interface AddMyProductionController ()<UITableViewDelegate,UITableViewDataSource,ZMJMyProductionCellDelegate,UITextFieldDelegate>{
     AddContinueCell *cell;
}

@property(nonatomic,strong)UITextField *textInput; //输入框
@property(nonatomic,strong)UIView *searchBackView; //搜索的背景图片
@property(nonatomic,strong)NSMutableArray *listArray;  //保存的数据
@property(nonatomic,strong)UITableView *tableview; //表格视图
@property (nonatomic, strong)  FMDBOneList *manager;
@property (nonatomic, strong)  NSMutableArray *circleArray; //存放被选中的cell

@end

@implementation AddMyProductionController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

//数据的加载
-(void)loadData{
    _manager = [FMDBOneList defaultManager];
    _listArray = [NSMutableArray arrayWithArray:[_manager getData]];
    [_tableview reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = INTERFACECOLOR ;
    _circleArray = [NSMutableArray array];
    [self createNavigationView];
    [self createSearchView];
    [self createTableView];
}

#pragma mark 创建navgationView
-(void)createNavigationView{
    self.navigationItem.title = @"商品清单";
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
   BackButton *rightBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    [rightBtn setTitle:@"确认添加" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item;
    [rightBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClick{
    
    NSString *oneStr = [UserDefaultManager getDataByKey:@"key"];
    NSString *twoStr = [UserDefaultManager getDataByKey:@"name"];
    NSString *threeStr = [UserDefaultManager getDataByKey:@"company"];
    
    if ([oneStr isEqualToString:@"2"]) {
        
        for (NSInteger i = 0 ; i < _circleArray.count; i++) {
            NSString *str = [NSString stringWithFormat:@"%@",_circleArray[i]];
            shopData *dataModel = [[shopData alloc] init];
            dataModel = _listArray[[str integerValue]];
            TranslationObjec *objcVC = [[TranslationObjec alloc] init];
            
        CustomerProductModel *addModel = [objcVC trams:dataModel customerName:twoStr companyName:threeStr index:oneStr];
    
        CustomerProductList   * manager = [CustomerProductList defaultManager];
            [manager insertDataModel:addModel];
            
        }
        
        OneViewController *myVC = [[ OneViewController alloc] init];
        for (OneViewController * controller in self.navigationController.viewControllers) { //遍历
            if ([controller isKindOfClass:[OneViewController class]]) { //这里判断是否
                myVC = controller;
            }
        }
        if (myVC) {
            [self.navigationController popToViewController:myVC animated:YES]; //跳转
        }
    }else if ([oneStr isEqualToString:@"1"]){
        
        for (NSInteger i = 0 ; i < _circleArray.count; i++) {
            
        NSString *str = [NSString stringWithFormat:@"%@",_circleArray[i]];
        shopData *dataModel = [[shopData alloc] init];
        dataModel = _listArray[[str integerValue]];
        TranslationObjec *objcVC = [[TranslationObjec alloc] init];
        
        CustomerProductModel *addModel = [objcVC trams:dataModel customerName:twoStr companyName:threeStr index:oneStr];
        
        CustomerProductList   * manager = [CustomerProductList defaultManager];
        [manager insertDataModel:addModel];
        
    }
    
    TwoViewController *myVC = [[ TwoViewController alloc] init];
    for (TwoViewController * controller in self.navigationController.viewControllers) { //遍历
        if ([controller isKindOfClass:[TwoViewController class]]) { //这里判断是否
            myVC = controller;
        }
    }
    if (myVC) {
        [self.navigationController popToViewController:myVC animated:YES]; //跳转
    }
  }
}



#pragma mark 创建搜索框
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
        make.leading.mas_equalTo(_searchBackView).offset(20);
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


#pragma mark 创建tableView
-(void)createTableView{

    _tableview=[[UITableView alloc] initWithFrame:CGRectMake(10, 120, WIDTH-20, HEIGHT-120 )style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    
}

#pragma mark tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return _listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdent=@"cell";
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell==nil) {
   cell=[[  AddContinueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    shopData *dataModel = [[shopData alloc] init];
    dataModel = _listArray[indexPath.row];
    
    if (dataModel.imageOne) {
   cell.imgV.image= [UIImage imageWithData:dataModel.imageOne];
    }else{
   cell.imgV.image= [UIImage imageNamed:@"Null"];
    }

    if (dataModel.shopName.length > 0 ) {
cell.nameShop.text=[NSString stringWithFormat:@"￥%@",dataModel.shopName];
    }else{
cell.nameShop.text  =  @"";
    }
    if (dataModel.shopPrice.length > 0 ) {
        cell.priceL.text=[NSString stringWithFormat:@"￥%@",dataModel.shopPrice];
    }else{
        cell.priceL.text  =  @"";
    }
    cell.delegate = self;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell=[_tableview cellForRowAtIndexPath:indexPath];
    NSString *str = [NSString stringWithFormat:@"%ld",indexPath.row];
    if ([_circleArray containsObject:str]) {
        cell.selectBtn.selected = NO ;
        [_circleArray removeObject:str];
    }else{
        cell.selectBtn.selected = YES ;
        [_circleArray addObject:str];
    }
}

#pragma mark 跳转到详情界面
- (void)clickView:(ZMJGoodsDetailController *)controller index:(UITableViewCell *)index
{
    NSIndexPath *indexPath =  [_tableview indexPathForCell:index];
    NSInteger  row = indexPath.row;
    ZMJGoodsDetailController *detailPriceVC=[[ZMJGoodsDetailController alloc] init];
    detailPriceVC.shopData=_listArray[row];
    [self.navigationController pushViewController:detailPriceVC animated:YES];
}

#pragma mark 跳转到编辑界面
- (void)clickLabelView:(ZMJEditViewController *)controller index:(UITableViewCell *)index
{
    NSIndexPath *indexPath =  [_tableview indexPathForCell:index];
    NSInteger  row = indexPath.row;
    ZMJEditViewController *editVC =[[ZMJEditViewController alloc] init];
       editVC.shopObj = _listArray[row];
    [self.navigationController pushViewController:editVC animated:YES];
}








































































































@end

















