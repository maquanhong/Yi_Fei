//
//  TemplateTwo.m
//  Yi_Fei
//
//  Created by yons on 16/12/22.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "TemplateTwo.h"
#import "FooterView.h"
#import "TemplateThree.h"
#import "SectionOneCell.h"
#import "SectionTwoCell.h"

@interface TemplateTwo ()<UITableViewDelegate,UITableViewDataSource,FooterViewDelegate,SSPopupDelegate,SectionOneCellDelegate,UITextFieldDelegate>
{
    SectionOneCell *firstCell;
    SectionTwoCell *secondCell;
 
}

@property (nonatomic, strong) UITableView  *tableView;
//内容
@property (nonatomic, strong) NSArray *oneArray;
@property (nonatomic, strong) NSArray *twoArray;
@property (nonatomic, strong) NSArray *threeArray;

@end

@implementation TemplateTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = INTERFACECOLOR;
    _oneArray = @[@"商品尺寸",@"商品重量"];
    _twoArray = @[@"cm",@"kg"];
    _threeArray = @[@"外箱包装",@"中盒包装"];
    _model.shopSize = @"cm";
    _model.shopHeight = @"kg";
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
    TemplateThree *twoVC = [[TemplateThree alloc] init];
    twoVC.model = _model;
    [self.navigationController pushViewController:twoVC animated:YES];
}


#pragma mark tableView代理

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
    static NSString *identifer = @"firstCell";
    firstCell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!firstCell) {
    firstCell = [[SectionOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];;
    }
    firstCell.titleLabel.text = _oneArray[indexPath.row];
    firstCell.typeOne.nameLabel.text = _twoArray[indexPath.row];
    firstCell.typeOne.tag = 1352 + indexPath.row;
    firstCell.textFiled.tag = 1462 +  indexPath.row;
    firstCell.textFiled.delegate = self;
    firstCell.delegate = self;
    return firstCell;
    }else{
        static NSString *identifer = @"secondCell";
        secondCell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (!secondCell) {
    secondCell = [[SectionTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];;
        }
        secondCell.titleLabel.text = _threeArray[indexPath.row];
        secondCell.numberLabel.text = @"数量";
        secondCell.heightLabel.text = @"重量";
        secondCell.sizeLabel.text = @"尺寸";
        secondCell.typeOne.textFiled.tag  = 1220 + indexPath.row;
        secondCell.typeTwo.textFiled.tag = 1320 + indexPath.row;
        secondCell.typeThree.textFiled.tag = 1420 + indexPath.row;
        secondCell.typeOne.textFiled.delegate = self;
        secondCell.typeTwo.textFiled.delegate = self;
        secondCell.typeThree.textFiled.delegate = self;
        return secondCell;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }else {
        return 80;
    }
}

//第一组参数设置
- (void)clickView:(NSInteger)index{
    
    NSArray *oneArray = @[@"mm",@"cm",@"m",@"尺"];
    NSArray *twoArray = @[@"mg",@"g",@"kg",@"吨"];
    switch (index) {
        case 1352:
        {
    ZMJTypeView *typeView = [self.view viewWithTag:1352];
  [self createView:oneArray typeView:typeView num:(NSInteger)1352];
        }
            break;
        case 1353:
        {
    ZMJTypeView *typeView = [self.view viewWithTag:1353];
    [self createView:twoArray typeView:typeView num:(NSInteger)1353];
        }
            break;
        default:
            break;
    }
}

-(void)createView:(NSArray*)array typeView:(ZMJTypeView*)typeView  num:(NSInteger)num {
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = array.count;
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:array withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
    typeView.nameLabel.text = array[tag];
        if (num == 1352) {
        _model.sizeUnit = array[tag];
        }else{
        _model.HeightUnit = array[tag];
        }
    }];
}


- (void)textFieldDidEndEditing:(UITextField *)textField{

    NSLog(@"%@",textField.text);
    
    switch (textField.tag) {
        case 1462:
        {
    if (textField.text.length > 0) {
    _model.shopSize = textField.text;
    }else{
    _model.shopSize = @"";
    }
        }
            break;
        case 1463:
        {
    if (textField.text.length > 0) {
        _model.shopHeight = textField.text;
    }else{
        _model.shopHeight = @"";
    }
        }
            break;
        case 1220:
        {
    if (textField.text.length > 0) {
        _model.shopNumOne = textField.text;
    }else{
        _model.shopNumOne = @"";
    }
        }
            break;
        case 1221:
        {
    if (textField.text.length > 0) {
        _model.shopNumTwo = textField.text;
    }else{
        _model.shopNumTwo = @"";
    }
        
        }
            break;
        case 1320:
        {
    if (textField.text.length > 0) {
        _model.shopSizeOne = textField.text;
    }else{
        _model.shopSizeOne = @"";
    }
            
        }
            break;
        case 1321:
        {
    if (textField.text.length > 0) {
        _model.shopSizeTwo = textField.text;
    }else{
        _model.shopSizeTwo = @"";
    }
            
        }
            break;
        case 1420:
        {
    if (textField.text.length > 0) {
        _model.shopHeightOne = textField.text;
    }else{
        _model.shopHeightOne = @"";
    }
        }
            break;
        case 1421:
        {
    if (textField.text.length > 0) {
        _model.shopHeightTwo = textField.text;
    }else{
        _model.shopHeightTwo = @"";
    }
        }
            break;
        default:
            break;
    }





}







































@end






















