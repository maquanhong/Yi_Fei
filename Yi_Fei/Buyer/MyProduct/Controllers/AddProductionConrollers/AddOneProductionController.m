//
//  AddOneProductionController.m
//  Yi_Fei
//
//  Created by yons on 16/11/24.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "AddOneProductionController.h"
#import "BUYButton.h"
#import "ZMJAddGoodsOneCell.h"
#import "AddTwoProductionController.h"
#import "GetDataFromeSupply.h"


@interface AddOneProductionController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>


@property(nonatomic,strong)ProductionData *shopObjc; //初始化商品对象

@property(nonatomic,strong)UITableView *tableView; //tableView

@property(nonatomic,strong)UIButton *nextBtn;  //下一步按钮

@property(nonatomic,strong)NSArray *nameArray;  //下一步按钮

@property(nonatomic,strong)NSArray *holderArray;  //下一步按钮

@property(nonatomic,strong)ZMJAddGoodsOneCell *cell;

@end

@implementation AddOneProductionController

- (void)viewDidLoad {
    [super viewDidLoad];

    _shopObjc = [[ProductionData alloc] init];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self createNaviGationView];
    [self addContentView];
    
}


#pragma mark 创建导航视图
-(void)createNaviGationView
{
    self.navigationItem.title = @"新建商品";
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    BackButton* rightBtn= [BackButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"Excel导入" forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 60, 30);
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=rightBtnItem;
    
    [rightBtn addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

//添加视图
-(void)addContentView{
    
    _nameArray = @[@"公司货号",@"商品名称",@"商品尺寸",@"商品材质"];
    _holderArray = @[@"例如2351415451",@"请填写商品名称",@"例如52cm/68cm",@"例如PVC塑料"];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.scrollEnabled = NO;
    UIView *footView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 200 )];
    UIButton *btn = [BUYButton creatBtnWithBgColor:NAVCOLOR borderColor:[UIColor lightGrayColor] borderWidth:1 titleColor:[UIColor whiteColor] text:@"下一步"];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footView.mas_centerX);
        make.centerY.mas_equalTo(footView.mas_centerY);
        make.leading.mas_equalTo(footView).offset(40);
        make.trailing.mas_equalTo(footView).offset(-40);
    }];
    _tableView.tableFooterView=footView;
    [self.view addSubview:_tableView];
}

#pragma Mark -->事件处理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _nameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdent=@"cell";
    _cell=[tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (_cell==nil) {
        _cell=[[ZMJAddGoodsOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    _cell.textF.placeholder = _holderArray[indexPath.row];
    _cell.label.text = _nameArray[indexPath.row];
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    _cell.textF.tag = 10000 + indexPath.row;
    _cell.textF.delegate = self;
    _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    return _cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}



#pragma UITextField代理
//编辑结束监听
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    switch (textField.tag - 10000) {
        case 0:
            _shopObjc.companyID = textField.text ;
            //            NSLog(@"%@",_shopObjc.companyID );
            [textField resignFirstResponder];
            break;
        case 1:
            _shopObjc.shopName = textField.text;
            //         NSLog(@"%@",_shopObjc.shopName );
            break;
        case 2:
            _shopObjc.shopSize = textField.text;
            //         NSLog(@"%@",_shopObjc.shopPrice );
            break;
        case 3:
            _shopObjc.shopMed = textField.text;
            //         NSLog(@"%@",_shopObjc.shopMed );
            break;
        default:
            break;
    }
}


//进入商品的下一界面
-(void)btnClick:(UIButton *)button{
    
    UITextField *textFOne = [self.view viewWithTag:10000];
    UITextField *textFTwo = [self.view viewWithTag:10001];
    
    if (textFOne.text.length != 0 && textFTwo.text.length != 0 ) {
    AddTwoProductionController *detailShopVC=[[AddTwoProductionController alloc] init];
        detailShopVC.shopObj = _shopObjc;
        [self.navigationController pushViewController:detailShopVC animated:YES];
    }else {
        
        if (textFOne.text.length == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"公司货号不能为空" preferredStyle:UIAlertControllerStyleAlert];
            //确定按钮
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }] ;
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }else if (textFTwo.text.length == 0){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"公司名称不能为空" preferredStyle:UIAlertControllerStyleAlert];
            //确定按钮
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }] ;
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }
}


-(void)clickRightBtn{
    
    GetDataFromeSupply * form = [[GetDataFromeSupply alloc ] init];
    [form getDataFromeForm];
    
}






































@end
















































