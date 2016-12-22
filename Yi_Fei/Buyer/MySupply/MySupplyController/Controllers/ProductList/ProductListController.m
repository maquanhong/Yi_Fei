//
//  ProductListController.m
//  Yi_Fei
//
//  Created by yons on 16/12/17.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ProductListController.h"
#import "QueryPriceTableViewCell.h"
#import "CardNameController.h"

@interface ProductListController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,QueryPriceTableViewCellDelegate>
{
    NewTwoList  *_manager;
    QueryPriceTableViewCell *cell;
}
@property(nonatomic,strong)UITextField *textInput; //输入框
@property(nonatomic,strong)NSMutableArray *listArray;  //保存的数据
@property(nonatomic,strong)UITableView *tableview; //表格视图
@property(nonatomic,strong)UIView *searchBackView; //搜索的背景图片

@end

@implementation ProductListController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

//数据的加载
-(void)loadData{
    //获取单例对象
    _manager = [NewTwoList newListManager];
    //可变数组初始化
    _listArray = [NSMutableArray arrayWithArray:[_manager getData]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationView];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addContentView];
    [self createSearchView];
    

}



#pragma mark 创建navgationView
-(void)createNavigationView
{
    self.navigationItem.title = @"商品列表";
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark 创建tableView视图
-(void)addContentView{
    
    _tableview=[[UITableView alloc] initWithFrame:CGRectMake(10, 130, WIDTH-20, HEIGHT-130 )style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_tableview.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8,8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _tableview.bounds;
    maskLayer.path = maskPath.CGPath;
    _tableview.layer.mask = maskLayer;
    [self.view addSubview:self.tableview];
}

#pragma Mark -- 事件处理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdent=@"askCell";
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell==nil) {
    cell = [[[NSBundle mainBundle] loadNibNamed:@"QueryPriceTableViewCell" owner:self options:nil] lastObject];
    }
    ProductionData *dataModel = [[ProductionData alloc] init];
        dataModel = _listArray[indexPath.row];
    NSArray *arrayimg=[dataModel.shopPicture componentsSeparatedByString:@"|"];
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",arrayimg[0]]];
    cell.iconImage.image= [UIImage imageWithContentsOfFile:imagePath];
    cell.titleLabel.text=[NSString stringWithFormat:@"%@",dataModel.shopName];
    if (dataModel.shopPrice.length > 0 ) {
        cell.priceLabel.text=[NSString stringWithFormat:@"￥%@",dataModel.shopPrice];
    }else{
        cell.priceLabel.text  =  @"";
    }
    cell.delegate = self;
    cell.selected = UITableViewCellSelectionStyleNone;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}




//设置编辑cell的样式（可省略）
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPat{
    return UITableViewCellEditingStyleDelete;
}
//实现删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    _manager = [NewTwoList newListManager];
    ProductionData *model ;
    [_manager deleteNameFromTable:model.companyID];
    [_listArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tableview reloadData];
    
}


























@end





















