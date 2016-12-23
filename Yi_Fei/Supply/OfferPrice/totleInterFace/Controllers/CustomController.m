//
//  CustomerController.m
//  Yi_Fei
//
//  Created by yons on 16/12/18.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "CustomController.h"
#import "ZMJTypeView.h"
#import "OfferCuPriceCell.h"
#import "CustomerModel.h"
#import "CustomerList.h"
#import "OneViewController.h"
#import "TwoViewController.h"

@interface CustomController ()<UITableViewDelegate,UITableViewDataSource,OfferCuPriceCellDelegate>{
    ZMJTypeView *_typeOneView;
    ZMJTypeView *_typeTwoView;
    UITableView *_tableView;
    CustomerList *_manager;
}

@property(nonatomic,strong)NSMutableArray *listArray;  //保存的数据

@end

@implementation CustomController

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
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[ UIColor groupTableViewBackgroundColor];
    [self setNav];
    [self createFirstView];
    [self createTableView];
    
}
- (void)setNav {
    
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=leftBtnItem;
    
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH - 120, 30 )];
    backView.layer.cornerRadius = 8;
    backView.layer.masksToBounds = YES;
    backView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"sousuo"];
    imageView.image = image;
    [backView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(backView).offset(10);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.centerY.mas_equalTo(backView.mas_centerY);
    }];

    UITextField *textFiled = [[UITextField alloc] init];
    textFiled.tintColor = [UIColor lightGrayColor];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    textFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入公司名称" attributes:attributes];
    [backView addSubview:textFiled];
    [textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(10);
        make.trailing.equalTo(backView).offset(10);
        make.height.mas_equalTo(20);
        make.centerY.equalTo(backView);
    }];
    self.navigationItem.titleView = backView;
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 20);
    [rightBtn setTitle:@"搜索" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(rightBtnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=rightBtnItem;
    
}

- (void)leftButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createFirstView{
    
    UIView *typeView = [[UIView alloc] init];
    typeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:typeView];
    [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(64);
        make.height.mas_equalTo(50);
    }];

    _typeOneView = [[ZMJTypeView alloc] init];
    _typeOneView.layer.borderWidth = 1.0;
    _typeOneView.layer.cornerRadius = 5;
    _typeOneView.layer.borderColor = BACKCOLOR.CGColor;
    _typeOneView.nameLabel.text = @"选择行业类型";
    [typeView addSubview:_typeOneView];
   
    
    _typeTwoView = [[ZMJTypeView alloc] init];
    _typeTwoView.layer.borderWidth = 1.0;
    _typeTwoView.layer.cornerRadius = 5;
    _typeTwoView.layer.borderColor = BACKCOLOR.CGColor;
    _typeTwoView.nameLabel.text = @"选择或编辑商品";
    [typeView addSubview:_typeTwoView];
    
    
    [_typeTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(typeView).offset(-10);
        make.height.mas_equalTo(30);
        make.centerY.equalTo(typeView);
        make.left.equalTo(_typeOneView.mas_right).offset(20);
        make.width.equalTo(_typeOneView);
    }];
    
    [_typeOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(typeView).offset(10);
        make.height.mas_equalTo(30);
        make.centerY.equalTo(typeView);
        make.right.equalTo(_typeTwoView.mas_left).offset(-20);
        make.width.equalTo(_typeTwoView);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"搜索结果";
    titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(10);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(typeView.mas_bottom);
        make.width.mas_equalTo(60);
    }];
}

-(void)createTableView{

    _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 145, WIDTH, HEIGHT - 145) style:UITableViewStylePlain];
    _tableView.rowHeight = 70;
    _tableView.delegate=self;
    _tableView.dataSource=self;
_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

}

//代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listArray.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdent=@"OfferCuPriceCell";
    OfferCuPriceCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OfferCuPriceCell" owner:self options:nil]lastObject];
    }
    CustomerModel *model = _listArray[indexPath.row];
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    if (model.companyLogo.length > 0) {
NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",model.companyLogo]];
cell.iconImageView.image  = [UIImage imageWithContentsOfFile:imagePath];
    }else{
cell.iconImageView.image  = [UIImage imageNamed:@"Null"];
    }
    cell.titleLabel.text = model.customerName;
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.delegate = self;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}



- (void)clickCell:(UITableViewCell *)cell index:(NSInteger)index{
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    switch (index) {
        case 1345:
        {
    OneViewController *customVC = [[OneViewController alloc] init];
    CustomerModel *model = _listArray[indexPath.row];
            customVC.customerName = model.customerName;
    [self.navigationController pushViewController:customVC animated:YES];
        }
            break;
        case 1346:
        {
  TwoViewController *ReserveVC = [[TwoViewController alloc] init];
    CustomerModel *model = _listArray[indexPath.row];
        ReserveVC.customerName = model.customerName;
  [self.navigationController pushViewController:ReserveVC animated:YES];
        }
            break;
            
        default:
            break;
    }



}





































@end






