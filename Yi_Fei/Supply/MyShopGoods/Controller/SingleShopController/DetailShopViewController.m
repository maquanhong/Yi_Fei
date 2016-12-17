//
//  DetailShopViewController.m
//  YiFei
//
//  Created by yangyan on 16/8/29.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "DetailShopViewController.h"
#import "ZMJAddGoodsTwoView.h"
#import "ZMJGoodParamViewController.h"
#import "BUYButton.h"


@interface DetailShopViewController ()<UITextFieldDelegate,ZMJAddGoodsTwoViewDelegate,SSPopupDelegate>{
    
    NSArray *_currencyArray;
    NSArray *_typeArray;
    NSInteger _index;
    UIView *_backGroundView;
    
}

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)ZMJAddGoodsTwoView *backView;  //列表视图

@end

@implementation DetailShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _index=0;
    self.navigationItem.title=@"新建商品";
    self.view.backgroundColor=[UIColor whiteColor];
    [self createNavigationView];
    [self createViewBackView];
}


#pragma mark 创建导航栏
-(void)createNavigationView
{
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightBtn setTitle:@"Excel导入" forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 60, 30);
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    [rightBtn addTarget:self action:@selector(ExcelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=rightBtnItem;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 创建视图
-(void)createViewBackView
{
    _backView = [[ZMJAddGoodsTwoView alloc]init];
    
    _backView.typeOneView.nameLabel.text = @"人民币";
    _backView.typeTwoView.nameLabel.text = @"EXW";
    _shopObj.shopHuoBi = @"人民币";
    _shopObj.shopTiaoK = @"EXW";
    _backView.userInteractionEnabled = YES;
    _backView.delegate = self;
    _backView.textFOne.delegate = self;
     _backView.textFTwo.delegate = self;
    _backView.textFThree.delegate = self;
    _backView.textFThree.hidden = YES;
    _backView.textFThree.tag = 20002;
    [self.view addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view);
        make.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(64);
        make.height.mas_equalTo(200);
    }];
    UIButton *btn = [BUYButton creatBtnWithBgColor:BACKCOLOR borderColor:[UIColor lightGrayColor] borderWidth:1 titleColor:[UIColor whiteColor] text:@"下一步"];
    btn.frame=CGRectMake(50, 300, WIDTH - 100, 35);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

#pragma mark 进入最后的页面
- (void)btnClick:(UIButton*)btn
{
    ZMJGoodParamViewController *paramVC = [[ ZMJGoodParamViewController alloc] init];
    paramVC.shopObj = _shopObj;
    [self.navigationController pushViewController:paramVC animated:YES];
}



#pragma UITextField代理
//编辑结束监听
- (void)textFieldDidEndEditing:(UITextField *)textField{

    switch (textField.tag) {
        case 2000:
        {

        if (textField.text.length > 0) {
    _shopObj.shopColor = textField.text;
        }else{
    _shopObj.shopColor = @"";
        }
    }
            break;
        case 2001:
        {
        if (textField.text.length > 0) {
            _shopObj.shopPrice = textField.text;
        }else{
            _shopObj.shopPrice = @"";
        }
        }
            break;
    }
}


- (void)clickViewTag:(NSInteger)tag
{
    _index = 100000;
    _currencyArray = @[@"人民币",@"美元",@"欧元",@"英镑",@"日元"];
    _typeArray = @[@"EXW",@"CFR",@"CIF",@"FOB"];
    switch (tag) {
        case 10000:
        {
            _index = 10000;
    
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
     selection.index = _currencyArray.count;
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
            
    [selection CreateTableview:_currencyArray withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        
        _backView.typeOneView.nameLabel.text = _currencyArray[tag];
        _shopObj.shopHuoBi = _currencyArray[tag];
    }];
        }
            break;
        case 10001:
        {
         _index = 10001;

    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
            selection.index = _typeArray.count;
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
            
    [selection CreateTableview:_typeArray withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        
        _backView.typeTwoView.nameLabel.text = _typeArray[tag];
        _shopObj.shopTiaoK = _typeArray[tag];
        if ([_typeArray[tag] isEqualToString:@"FOB"]) {
            _backView.textFThree.hidden= NO;
            _backView.textFThree.delegate = self;
        }else{
            _backView.textFThree.hidden= YES;
        }
    }];
        }
            break;
        default:
            break;
    }
}





































@end





































