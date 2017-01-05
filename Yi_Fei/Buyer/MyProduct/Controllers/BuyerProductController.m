//
//  BuyerProductController.m
//  Yi_Fei
//
//  Created by yons on 16/11/24.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "BuyerProductController.h"
#import "AddOneProductionController.h"
#import "BuyerProductTableViewCell.h"
#import "BuyerDetailViewController.h"


@interface BuyerProductController ()<ZMJMyProductionCellDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    BuyerProductTableViewCell *cell;
    BOOL _isSearch;
    BOOL _btnSearch;
    BOOL _nilSearch;
    NewTwoList  *_manager;
}

@property(nonatomic,strong)UITextField *textInput; //输入框
@property(nonatomic,strong)NSMutableArray *listArray;  //保存的数据
@property(nonatomic,strong)UITableView *tableview; //表格视图
@property(nonatomic,strong)UIView *searchBackView; //搜索的背景图片
@property (nonatomic, strong) NSMutableArray *searchResultArr; //输入时的结果
@property (nonatomic, strong) NSMutableArray *btnResultArr; //点击按钮时的结果
@property (nonatomic, strong) NSMutableArray *allArray; //搜索的结果
@property (nonatomic, strong) UILabel *numLabel; //有多少个元素

@end


@implementation BuyerProductController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _isSearch = NO;
    _btnSearch = NO;
    _nilSearch = NO;
    _searchResultArr = [NSMutableArray array];
    _btnResultArr = [NSMutableArray array];
    [self createNavigationView];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self addContentView];
    [self createSearchView];
    
}

//数据的加载
-(void)loadData{
    //获取单例对象
    _manager = [NewTwoList newListManager];
    //可变数组初始化
    _listArray = [NSMutableArray arrayWithArray:[_manager getData]];
    _allArray = [NSMutableArray array];
    for (NSInteger i = 0 ; i < _listArray.count; i++) {
        ProductionData *dataModel = [[ProductionData alloc] init];
        dataModel = _listArray[i];
        if (dataModel.shopName.length != 0 ) {
            [_allArray addObject:dataModel.shopName];
        }else{
            [_allArray addObject:[NSNull null]];
        }
    }
    [_tableview reloadData];
}

#pragma mark 创建navgationView
-(void)createNavigationView
{
    self.navigationItem.title = @"我的商品";
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    BackButton *rightBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"xinjian"] forState:UIControlStateNormal];
    UIBarButtonItem * barRightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = barRightItem;
    [rightBtn addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 创建新的商品
-(void)rightButtonClick:(UIButton *)button{
    AddOneProductionController *shopVC=[[AddOneProductionController alloc] init];
    [self.navigationController pushViewController:shopVC animated:YES];
    
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

#pragma mark 点击搜索按钮
-(void)clickBtnSearch{
    
    _btnSearch = YES;
    [_btnResultArr removeAllObjects];
    int k = 0;
    for (NSString *str in _allArray) {
        NSString *ste = [NSString stringWithFormat:@"%@",str];
        NSRange range = [ste rangeOfString:_textInput.text];
        NSString *tpinyin = [self transform:ste];
        NSRange rangeTpinyin = [tpinyin rangeOfString:_textInput.text];
        if (range.length || rangeTpinyin.length) {
            [_btnResultArr addObject:_listArray[k]];
        }
        k++;
        [_tableview reloadData];
    }
}

#pragma mark textFiled的点击事件
- (void)textFieldDidChange:(UITextField *)textField{
    
    if (textField.text.length == 0) {
        _nilSearch = YES;
        [_tableview reloadData];
    }else{
        _isSearch = YES;
        [_searchResultArr removeAllObjects];
        [self textFileSearch:textField.text];
    }
}


-(void)textFileSearch:(NSString *)TextField
{
    [_searchResultArr removeAllObjects];
    int k = 0;
    for (NSString *str in _allArray) {
        NSString *ste = [NSString stringWithFormat:@"%@",str];
        NSRange range = [ste rangeOfString:TextField];
        NSString *tpinyin = [self transform:ste];
        NSRange rangeTpinyin = [tpinyin rangeOfString:TextField];
        if (range.length || rangeTpinyin.length) {
            [_searchResultArr addObject:_listArray[k]];
        }
        k++;
        [_tableview reloadData];
    }
}


#pragma mark 将输入的字母转换为文字
- (NSString *)transform:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSString *py = [pinyin stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *pys = [NSString stringWithFormat:@"%@%@%@%@%@%@",[pinyin uppercaseString],[pinyin lowercaseString],[pinyin capitalizedString],[py uppercaseString],[py lowercaseString],[py capitalizedString]];
    return pys;
}


#pragma mark 创建tableView视图
-(void)addContentView{
    
    _tableview=[[UITableView alloc] initWithFrame:CGRectMake(10, 120, WIDTH-20, HEIGHT-120 )style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableview];
    
    UIView *haderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH-20, 45)];
    haderView.userInteractionEnabled = YES;
    haderView.backgroundColor = [UIColor whiteColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:haderView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8,8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = haderView.bounds;
    maskLayer.path = maskPath.CGPath;
    haderView.layer.mask = maskLayer;
    
    UIView *nextView = [[UIView alloc]init];
    nextView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [haderView addSubview:nextView];
    [nextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(haderView);
        make.trailing.mas_equalTo(haderView);
        make.bottom.mas_equalTo(haderView.mas_bottom);
        make.height.mas_equalTo(5);
    }];
    
    UILabel  *numberlabel = [[UILabel alloc] init];
    [numberlabel sizeToFit];
    numberlabel.textColor=[UIColor lightGrayColor];
    numberlabel.font=[UIFont systemFontOfSize:16.0];
    numberlabel.text=@" 商品数量:";
    [haderView addSubview:numberlabel];
    [numberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(haderView).offset(10);
        make.centerY.mas_equalTo(haderView.mas_centerY).offset(-2);
        make.size.mas_equalTo(CGSizeMake(75, 20));
    }];
    
    _numLabel = [[UILabel alloc] init];
    _numLabel.textColor=COLOR;
    _numLabel.text = @"0";
    _numLabel.font=[UIFont systemFontOfSize:16.0];
    [haderView addSubview:_numLabel];
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(numberlabel.mas_right).offset(5);
        make.centerY.mas_equalTo(haderView.mas_centerY).offset(-2);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    [nameLabel sizeToFit];
    nameLabel.textColor=[UIColor blackColor];
    nameLabel.font=[UIFont systemFontOfSize:18.0];
    nameLabel.text=@" 商品清单";
    [haderView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(haderView).offset(120);
        make.centerY.mas_equalTo(haderView.mas_centerY).offset(-2);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    self.tableview.tableHeaderView = haderView;
    
}

#pragma Mark -- 事件处理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isSearch == YES) {
        return _searchResultArr.count;
    }else if (_btnSearch == YES){
        return _btnResultArr.count;
    }else if (_nilSearch == YES){
        return _listArray.count;
    }else{
        return _listArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdent=@"cell";
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell==nil) {
        cell=[[BuyerProductTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    
    ProductionData *dataModel = [[ProductionData alloc] init];
    if (_isSearch == YES) {
        //赋值对应的对象
        dataModel = _searchResultArr[indexPath.row];
        _isSearch = NO;
    }else if (_nilSearch == YES){
        dataModel = _listArray[indexPath.row];
        _nilSearch = NO;
    }else if (_btnSearch == YES){
        dataModel = _btnResultArr[indexPath.row];
        _btnSearch = NO;
    }else{
        dataModel = _listArray[indexPath.row];
    }
    
    if (dataModel.imageOne) {
        cell.imgV.image= [UIImage imageWithData:dataModel.imageOne];
    }else{
        cell.imgV.image= [UIImage imageNamed:@"Null"];
    }
   
    cell.nameShop.text=[NSString stringWithFormat:@"%@",dataModel.shopName];
    if (dataModel.shopPrice.length > 0 ) {
    cell.priceL.text=[NSString stringWithFormat:@"￥%@",dataModel.shopPrice];
    }else{
    cell.priceL.text  =  @"";
    }
    cell.delegate = self;
    cell.selected = UITableViewCellSelectionStyleNone;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _numLabel.text = [NSString stringWithFormat:@"%ld",_listArray.count];
    return cell;
}

#pragma mark 点击页面进行跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BuyerDetailViewController *detailPriceVC=[[BuyerDetailViewController alloc] init];
    detailPriceVC.shopData=_listArray[indexPath.row];
    [self.navigationController pushViewController:detailPriceVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

#pragma mark 跳转到详情界面
- (void)clickView:(BuyerDetailViewController *)View row:(UITableViewCell *)row{
    
    NSIndexPath *indexPath =  [_tableview indexPathForCell:row];
    NSInteger  index = indexPath.row;
    BuyerDetailViewController *detailPriceVC=[[BuyerDetailViewController alloc] init];
    
    if (_isSearch == YES) {
        //赋值对应的对象
        detailPriceVC.shopData = _searchResultArr[index];
    }else{
        detailPriceVC.shopData = _listArray[index];
    }
    
    [self.navigationController pushViewController:detailPriceVC animated:YES];
}

#pragma mark 跳转到编辑界面
- (void)clickView:(BuyerEditProductController *)View num:(UITableViewCell *)num{
    NSIndexPath *indexPath =  [_tableview indexPathForCell:num];
    NSInteger  row = indexPath.row;
    BuyerEditProductController *editVC  =[[BuyerEditProductController alloc] init];
    if (_isSearch == YES) {
        //赋值对应的对象
        editVC.shopObj = _searchResultArr[row];
    }else{
        editVC.shopObj = _listArray[row];
    }
    
    [self.navigationController pushViewController:editVC animated:YES];
}


//设置编辑cell的样式（可省略）
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPat{
    return UITableViewCellEditingStyleDelete;
}
//实现删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _manager = [NewTwoList newListManager];
    ProductionData *model ;
    if (_isSearch == YES) {
    model = _searchResultArr[indexPath.row];
    }else if (_btnSearch == YES){
    model = _btnResultArr[indexPath.row];
    }else{
    model = _listArray[indexPath.row];
    }
    [_manager deleteNameFromTable:model.companyID];
    if (_isSearch == YES) {
    [_searchResultArr removeObjectAtIndex:indexPath.row];
    }else if (_btnSearch == YES){
 [_btnResultArr removeObjectAtIndex:indexPath.row];
    }else{
  [_listArray removeObjectAtIndex:indexPath.row];
    }
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
_numLabel.text = [NSString stringWithFormat:@"%ld",_listArray.count];
    [_tableview reloadData];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textInput resignFirstResponder];
    return YES;
}



















































@end





















