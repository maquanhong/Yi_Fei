//
//  AddSupplyViewController.m
//  YiFei
//
//  Created by yangyan on 16/9/7.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "AddSupplyViewController.h"
#import "BuyerViewController.h"
#import "AddSupplyTableViewCell.h"
#import "Macro.h"

@interface AddSupplyViewController ()
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)NSArray *leftArray;
@property(nonatomic,strong)NSArray *rightArray;
@end

@implementation AddSupplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
    self.title=@"编辑客户";
    self.view.backgroundColor=[UIColor darkGrayColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self addNavView];
    [self addContentView];
}

-(void)addNavView{
    //添加右边视图的内容
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.backgroundColor=[UIColor clearColor];
    leftButton.frame=CGRectMake(0, 0, 90, 30);
    [leftButton setTitle:@"重新拍摄" forState:UIControlStateNormal];
    leftButton.titleLabel.font=[UIFont systemFontOfSize:18.0];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *letfButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=letfButtonItem;
    
    //添加右边视图的内容
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.backgroundColor=[UIColor clearColor];
    rightButton.frame=CGRectMake(0, 0, 50, 30);
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:18.0];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem=buttonItem;
}



-(void)leftButtonClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClick:(UIButton *)button{
    BuyerViewController *shopVC=[[BuyerViewController alloc] initWithTypeId:BussinessBuyer];
    [self.navigationController pushViewController:shopVC animated:YES];
}

-(void)addContentView{
    _leftArray=@[@"姓名",@"职位",@"联系电话",@"邮箱",@"公司名称",@"公司地址",@"行业类型"];
    _rightArray=@[@"周润发",@"总经理",@"15833444990",@"233134454@qq.com",@"杭州百倍云科技有限公司",@"杭州西湖区",@"建筑建材及装饰-建筑装饰  涂料、化学类-建筑胶/胶带"];
//    _tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 30, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
//    _tableV.delegate=self;
//    _tableV.dataSource=self;
//    [self.view addSubview:_tableV];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdent=@"cell";
    AddSupplyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell==nil) {
        cell=[[AddSupplyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    cell.backgroundColor=[UIColor groupTableViewBackgroundColor];
    cell.label.text=_leftArray[indexPath.row];
    cell.valueTF.text=_rightArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



















@end









