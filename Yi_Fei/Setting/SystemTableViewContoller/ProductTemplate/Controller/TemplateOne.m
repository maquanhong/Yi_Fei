//
//  TemplateOne.m
//  Yi_Fei
//
//  Created by yons on 16/12/22.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "TemplateOne.h"
#import "OneTemplateCell.h"
#import "FooterView.h"
#import "TemplateModel.h"
#import "TemplateTwo.h"

@interface TemplateOne ()<UITableViewDelegate,UITableViewDataSource,FooterViewDelegate>
{
    OneTemplateCell *cell;
}
@property (nonatomic, strong) TemplateModel *model;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray  *holderArray;
@property (nonatomic, strong) UITableView  *tableView;

@end

@implementation TemplateOne

- (void)viewDidLoad {
    [super viewDidLoad];
    _model = [[TemplateModel alloc] init];
    _titleArray = @[@"货        号",@"商品名称",@"商品价格",@"商品材质",@"商品颜色"];
    _holderArray = @[@"例如2351415451",@"请填写商品名称",@"请填写商品价格(数字)",@"例如PVC塑料",@"例如黄色/绿色/蓝色"];
    self.view.backgroundColor = INTERFACECOLOR;
    [self createNavigationView];
    [self addViewConstraints];
}

#pragma mark 创建navgationView
-(void)createNavigationView
{
    self.navigationItem.title = @"商品模板";
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 添加视图
- (void)addViewConstraints {
    
  _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    FooterView *footerView = [[FooterView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 150)];
    [footerView.footerBtn  setTitle:@"下一步" forState:UIControlStateNormal];
    footerView.delegate  = self;
    _tableView.tableFooterView = footerView;
    
}

-(void)clickBtn{
    
    UITextField *textF = [self.view viewWithTag:1390];
    if (textF.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"公司货号不能为空" preferredStyle:UIAlertControllerStyleAlert];
        //确定按钮
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }] ;
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        TemplateTwo *twoVC = [[TemplateTwo alloc] init];
        twoVC.model = _model;
        [self.navigationController pushViewController:twoVC animated:YES];
    }
}


#pragma mark tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   static NSString *ideentifer = @"OneTemplateCell";
    cell = [tableView dequeueReusableCellWithIdentifier:ideentifer];
    if (!cell) {
    cell = [[[NSBundle mainBundle ] loadNibNamed:@"OneTemplateCell" owner:self options:nil] lastObject];
    }
    cell.titleLabel.text = _titleArray[indexPath.row];
    cell.textFiled.placeholder = _holderArray[indexPath.row];
    cell.textFiled.tag = 1390 + indexPath.row;
    return cell;
}

#pragma UITextField代理
//编辑结束监听
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    switch (textField.tag - 1390) {
        case 0:
            if (textField.text.length > 0) {
                _model.companyID = textField.text ;
            }else{
                _model.companyID = @"" ;
            }
            break;
        case 1:
            if (textField.text.length > 0) {
                _model.shopName = textField.text ;
            }else{
                _model.shopName = @"" ;
            }
            break;
        case 2:
            if (textField.text.length > 0) {
                _model.shopPrice = textField.text ;
            }else{
                _model.shopPrice = @"" ;
            }
            break;
        case 3:
            if (textField.text.length > 0) {
                _model.shopMed = textField.text ;
            }else{
                _model.shopMed = @"" ;
            }
            break;
        case 4:
            if (textField.text.length > 0) {
                _model.shopColor = textField.text ;
            }else{
                _model.shopColor = @"" ;
            }
            break;
        default:
            break;
    }
}




































@end











