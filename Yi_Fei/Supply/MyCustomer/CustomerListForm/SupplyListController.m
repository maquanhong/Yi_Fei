//
//  SupplyListController.m
//  Yi_Fei
//
//  Created by yons on 16/12/17.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "SupplyListController.h"
#import "DownSheet.h"
#import "CustomerModel.h"
#import "CustomerList.h"
#import "CustomerController.h"
#import "CustomerScanController.h"
#import "BuyerTableViewCell.h"
#import "DetailCustomerController.h"

@interface SupplyListController ()<DownSheetDelegate,UITextFieldDelegate>{;
    BOOL isSelect;
    CustomerList *_manager;
    
}
@property(nonatomic,strong)UITextField *textInput; //输入框
@property(nonatomic,strong)NSMutableArray *listArray;  //保存的数据
@property(nonatomic,strong)UITableView *tableview; //表格视图
@property(nonatomic,strong)UIView *searchBackView; //搜索的背景图片
@property (nonatomic, strong) NSMutableArray *searchResultArr; //输入时的结果
@property (nonatomic, strong) NSMutableArray *btnResultArr; //点击按钮时的结果
@property (nonatomic, strong) NSMutableArray *allArray; //搜索的结果
@property (nonatomic, strong) UILabel *numLabel; //有多少个元素
@property (nonatomic, strong) NSArray *clientInfoArray;
@property (nonatomic, strong) DownSheet *sheet;
@property (nonatomic, strong) NSArray *MenuList;

@end

@implementation SupplyListController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

//数据的加载
-(void)loadData{
    //获取单例对象
    _manager = [CustomerList  defaultManager];
    //可变数组初始化
    _listArray = [NSMutableArray arrayWithArray:[_manager getData]];
    NSLog(@"%ld",_listArray.count);
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    isSelect  = YES ;
    [self setNav];
    [self createSearchView];
    [self addContentView];
}


- (void)setNav {
    
    self.title = @"客户列表";
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=leftBtnItem;
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightButtonClick)];
    self.navigationItem.rightBarButtonItem=rightButton;
    self.automaticallyAdjustsScrollViewInsets=YES;
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
        CustomerScanController *scanVC = [[CustomerScanController alloc] init];
        [self.navigationController pushViewController:scanVC animated:YES];
    }else if (index == 1){
        CustomerController *manualVC = [[CustomerController alloc] init];
        [self.navigationController pushViewController:manualVC animated:YES];
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

-(void)clickBtnSearch{
    
    
    
}



-(void)addContentView{
    self.tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, 124, WIDTH, HEIGHT- 124 )style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor redColor];
    self.tableview.rowHeight = 70;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
}


#pragma Mark -- 事件处理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdent=@"supplyCell";
    BuyerTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (!cell) {
    cell = [[[NSBundle mainBundle] loadNibNamed:@"BuyerTableViewCell" owner:self options:nil]lastObject];
    }
    CustomerModel *model = _listArray[indexPath.row];
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",model.companyLogo]];
    cell.iconImageView.image  = [UIImage imageWithContentsOfFile:imagePath];
    cell.titleLabel.text = model.supplyName;
    cell.nextLabel.text = model.companyName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailCustomerController *mySalerVC=[[DetailCustomerController alloc] init];
    mySalerVC.model = _listArray[indexPath.row];
    [self.navigationController pushViewController:mySalerVC animated:YES];
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//向左拖动cell的时候，会调用该方法
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

//修改cell自带的删除按钮上文字
- (NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}


//删除模式下，点击“-”按钮，不会调用该方法，点击cell上的“Delete”按钮，才会调用该方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    _manager = [CustomerList defaultManager];
    CustomerModel *model ;
  [_manager deleteNameFromTable:model.supplyName];
    [_listArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tableview reloadData];
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_sheet removeFromSuperview];
}

















































@end



















