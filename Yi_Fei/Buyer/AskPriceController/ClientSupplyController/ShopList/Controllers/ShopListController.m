//
//  ShopListController.m
//  Yi_Fei
//
//  Created by yons on 16/12/13.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ShopListController.h"
#import "ShopListCell.h"
#import "BuyerEditProductController.h"
#import "ZMJTypeView.h"
#import "UWDatePickerView.h"
#import "AskPriceModel.h"
#import "AskWayController.h"
#import "AskPriceList.h"
#import "ConversionTrams.h"

@interface ShopListController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ShopListCellDelegate,SSPopupDelegate,UWDatePickerViewDelegate>{
    ShopListCell *cell;
    BOOL _isSearch;
    BOOL _btnSearch;
    BOOL _nilSearch;
    NSString *_time;
    UWDatePickerView *_pickerView;
    NSInteger _index;
}
@property(nonatomic,strong)AskPriceList *askManager;
@property(nonatomic,strong)ZMJTypeView *typeOneView;
@property(nonatomic,strong)ZMJTypeView *typeTwoView;
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

@end

@implementation ShopListController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _circleArray = [NSMutableArray array];
    _isSearch = NO;
    _btnSearch = NO;
    _nilSearch = NO;
    _index = 0;
    _searchResultArr = [NSMutableArray array];
    _btnResultArr = [NSMutableArray array];
    [self createNavigationView];
    [self createSearchView];
    [self addContentView];
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
      self.title = @"商品清单";
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    BackButton *rightBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    [rightBtn setTitle:@"确认添加" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonClick{

    if (_circleArray.count != 0) {
        for (NSInteger i = 0 ; i < _circleArray.count; i++) {
            NSString *str = [NSString stringWithFormat:@"%@",_circleArray[i]];
            NSInteger num = [str integerValue];
            ProductionData *dataModel = [[ProductionData alloc] init];
            if (_isSearch == YES) {
                //赋值对应的对象
                dataModel = _searchResultArr[num];
                _isSearch = NO;
            }else if (_nilSearch == YES){
                dataModel = _listArray[num];
                _nilSearch = NO;
            }else if (_btnSearch == YES){
                dataModel = _listArray[num];
                _btnSearch = NO;
            }else{
                dataModel = _listArray[num];
          }
            ConversionTrams *conversion = [[ConversionTrams alloc] init];
            NSString *flag = [NSString stringWithFormat:@"%ld",_index];
            AskPriceModel *model;
            if (_index == 2) {
            model = [conversion  trams:dataModel tag:flag time:_time];
            }else{
            model = [conversion  trams:dataModel tag:flag time:nil];
            }
            _askManager = [AskPriceList defaultManager];
            [_askManager insertDataModel:model];
        }
        AskWayController *myVC = [[ AskWayController alloc] init];
        for (AskWayController * controller in self.navigationController.viewControllers) { //遍历
            if ([controller isKindOfClass:[AskWayController class]]) { //这里判断是否为你想要跳转的页面
                myVC = controller;
                myVC.flag = [NSString stringWithFormat:@"%ld",_index];
            }
        }
        if (myVC) {
            [self.navigationController popToViewController:myVC animated:YES]; //跳转
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
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
            NSLog(@"%@",_btnResultArr);
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
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view);
        make.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(_searchBackView.mas_bottom).offset(3);
        make.height.mas_equalTo(40);
    }];
    
    _typeOneView = [[ZMJTypeView alloc] init];
    _typeOneView.layer.cornerRadius = 5;
    _typeOneView.layer.borderWidth = 1.0;
    _typeOneView.nameLabel.text = @"已报价";
    _typeOneView.tag = 9000;
    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTypeView:)];
    [_typeOneView addGestureRecognizer:tapOne];
    _typeOneView.layer.borderColor = BACKCOLOR.CGColor;
    [backView addSubview:_typeOneView];
    [_typeOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(backView).offset(10);
        make.centerY.equalTo(backView);
        make.size.mas_equalTo(CGSizeMake(90, 20));
    }];
    
    _typeTwoView = [[ZMJTypeView alloc] init];
    _typeTwoView.layer.cornerRadius = 5;
    _typeTwoView.layer.borderWidth = 1.0;
    _typeTwoView.layer.borderColor = BACKCOLOR.CGColor;
    _typeTwoView.nameLabel.text = @"2017-02-02 12:10";
    [backView addSubview:_typeTwoView];
    [_typeTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_typeOneView.mas_right).offset(10);
        make.centerY.equalTo(backView);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    _typeTwoView.tag = 9001;
    _typeTwoView.hidden = YES;
    UITapGestureRecognizer *tapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTypeView:)];
    [_typeTwoView addGestureRecognizer:tapTwo];
    
    _tableview=[[UITableView alloc] initWithFrame:CGRectMake(10, 165, WIDTH-20, HEIGHT- 165 )style:UITableViewStylePlain];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_tableview.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(8,8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _tableview.bounds;
    maskLayer.path = maskPath.CGPath;
    _tableview.layer.mask = maskLayer;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableview];
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
        cell=[[ShopListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
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
        dataModel = _listArray[indexPath.row];
        _btnSearch = NO;
    }else{
        dataModel = _listArray[indexPath.row];
    }
    NSArray *arrayimg=[dataModel.shopPicture componentsSeparatedByString:@"|"];
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",arrayimg[0]]];
    cell.imgV.image= [UIImage imageWithContentsOfFile:imagePath];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;

    _numLabel.text = [NSString stringWithFormat:@"%ld",_listArray.count];
    return cell;
    
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

//#pragma mark 跳转到详情界面
//- (void)clickView:(ZMJGoodsDetailController *)controller index:(UITableViewCell *)index
//{
//    NSIndexPath *indexPath =  [_tableview indexPathForCell:index];
//    NSInteger  row = indexPath.row;
//    ZMJGoodsDetailController *detailPriceVC=[[ZMJGoodsDetailController alloc] init];
//    detailPriceVC.shopData=_listArray[row];
//    [self.navigationController pushViewController:detailPriceVC animated:YES];
//}


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



#pragma mark 跳转到编辑界面
- (void)clickLabelView:(BuyerEditProductController *)controller index:(UITableViewCell *)index
{
    NSIndexPath *indexPath =  [_tableview indexPathForCell:index];
    NSInteger  row = indexPath.row;
    BuyerEditProductController *editVC =[[BuyerEditProductController alloc] init];
    if (_isSearch == YES) {
        //赋值对应的对象
        editVC.shopObj = _searchResultArr[row];
    }else{
        editVC.shopObj = _listArray[row];
    }
    [self.navigationController pushViewController:editVC animated:YES];
}


#pragma mark 三种状态的选择改变
-(void)clickTypeView:(id)sender{
    UITapGestureRecognizer * singleTap = (UITapGestureRecognizer *)sender;
    NSInteger tag = [singleTap view].tag;
    NSArray *firstArray = @[@"已报价",@"预留报价",@"留样报价"];
    switch (tag) {
        case 9000:
        {
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = firstArray.count;
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:firstArray withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        _index = tag;
        _typeOneView.nameLabel.text = firstArray[tag];
        if (tag == 1) {
        _typeTwoView.hidden = NO;
        }else{
        _typeTwoView.hidden = YES;
        }
    }];
        }
            break;
        case 9001:
        {
      [self setupDateView:DateTypeOfStart];
        }
            break;
        default:
            break;
    }
}

- (void)setupDateView:(DateType)type {

    _pickerView = [UWDatePickerView instanceDatePickerView];
    _pickerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [_pickerView setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.3]];
    _pickerView.delegate = self;
    _pickerView.type = type;
    [self.view addSubview:_pickerView];
    
}

- (void)getSelectDate:(NSString *)date type:(DateType)type {
    switch (type) {
        case DateTypeOfStart:
        {
    _typeTwoView.nameLabel.text = date;
    _time = date;
        }
            break;
        case DateTypeOfEnd:

            break;
        default:
            break;
    }
}









































@end
















