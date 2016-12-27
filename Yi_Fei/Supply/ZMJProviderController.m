//
//  BUYBusinessControl.m
//  YiFei
//
//  Created by yons on 16/8/27.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "ZMJProviderController.h"
#import "UIView+Layout.h"
#import "BUYButton.h"
#import "MyProductionController.h"
#import "SupplyListController.h"
#import "OfferController.h"
#import "Macro.h"
#import "UserModel.h"
#import "UserList.h"
#import "UserDefaultManager.h"

@interface ZMJProviderController ()
{
    UserModel *oneModel;
}

@property (nonatomic,strong) UIView *symView;

@property (nonatomic, strong) UIButton  *btnOne;
@property (nonatomic, strong) UIButton  *btnTwo;
@property (nonatomic, strong) UIButton  *btnThree;

@end

@implementation ZMJProviderController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = INTERFACECOLOR;
    //添加标志图片
    [self addSymbol];
    //添加按钮
    [self addBtns];
}

#pragma mark - 添加标志图片
- (void)addSymbol
{
    
_symView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
    _symView.backgroundColor =  BACKCOLOR;
    
    //添加标志图
    UIImageView *img = [[UIImageView alloc] init];
    img.layer.cornerRadius = 5;
    img.layer.masksToBounds = YES;
    [_symView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_symView).offset(30);
        make.bottom.mas_equalTo(_symView.mas_bottom).offset(-50);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    
    //获取单例对象
    UserList *manager = [UserList defaultManager];
    //可变数组初始化
    oneModel = [[ UserModel alloc] init];
    NSString *str = [UserDefaultManager getDataByKey:@"user"];
    oneModel = [manager getDataWith:str];
    
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    if (oneModel.picture.length > 0) {
        NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",oneModel.picture]];
       img.image = [UIImage imageWithContentsOfFile:imagePath];
        
    }
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text  = @"我是供应商";
    titleLabel.textColor = [UIColor whiteColor];
    [_symView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_symView);
        make.top.mas_equalTo(_symView.mas_top).offset(30);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    [_symView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_symView).offset(10);
        make.top.mas_equalTo(_symView.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [btn addTarget:self action:@selector(returnNextView) forControlEvents:UIControlEventTouchUpInside];
    
    //添加公司名称
    UILabel *label = [[UILabel alloc] init];
    label.text = oneModel.name;
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    [_symView addSubview:label];
    [self.view addSubview:_symView];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(img.mas_right).offset(15);
        make.centerY.equalTo(img);
        make.height.mas_equalTo(20);
    }];
}


-(void)returnNextView{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 添加下面三个按钮
- (void)addBtns
{
    
    NSArray *strs = @[@"我的商品",@"我的客户",@"报价"];
    _btnOne = [[UIButton alloc] init];
    [_btnOne setTitle:strs[0] forState:UIControlStateNormal];
    _btnOne.backgroundColor = [UIColor whiteColor];
    _btnOne.layer.borderColor = [UIColor lightGrayColor].CGColor;
     _btnOne.layer.borderWidth = 1.0;
    _btnOne.layer.cornerRadius = 5;
    _btnOne.layer.masksToBounds = YES;
    _btnOne.titleLabel.font = [UIFont systemFontOfSize:18];
    [_btnOne setTitleColor:COLOR forState:UIControlStateNormal];
    [self.view addSubview:_btnOne];
    [_btnOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_symView.mas_bottom).offset(10);
        make.leading.mas_equalTo(self.view).offset(20);
        make.trailing.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(50);
    }];
    _btnOne.tag = 1864;
    [_btnOne addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _btnTwo = [[UIButton alloc] init];
    [_btnTwo setTitle:strs[1] forState:UIControlStateNormal];
    _btnTwo.titleLabel.font = [UIFont systemFontOfSize:18];
    [_btnTwo setTitleColor:COLOR forState:UIControlStateNormal];
    _btnTwo.backgroundColor = [UIColor whiteColor];
    _btnTwo.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _btnTwo.layer.borderWidth = 1.0;
    _btnTwo.layer.cornerRadius = 5;
    _btnTwo.layer.masksToBounds = YES;
    [self.view addSubview:_btnTwo];
    [_btnTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_btnOne.mas_bottom).offset(10);
        make.leading.mas_equalTo(self.view).offset(20);
        make.trailing.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(50);
    }];
    _btnTwo.tag = 1865;
    [_btnTwo addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _btnThree = [[UIButton alloc] init];
    [_btnThree setTitle:strs[0] forState:UIControlStateNormal];
    _btnThree.titleLabel.font = [UIFont systemFontOfSize:18];
    [_btnThree setTitleColor:COLOR forState:UIControlStateNormal];
    _btnThree.backgroundColor = [UIColor whiteColor];
    _btnThree.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _btnThree.layer.borderWidth = 1.0;
    _btnThree.layer.cornerRadius = 5;
    _btnThree.layer.masksToBounds = YES;
    [self.view addSubview:_btnThree];
    [_btnThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_btnTwo.mas_bottom).offset(10);
        make.leading.mas_equalTo(self.view).offset(20);
        make.trailing.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(50);
    }];
    _btnThree.tag = 1866;
    [_btnThree addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - btn按钮的点击事件
- (void)btnClick:(UIButton *)sender
{
    MyProductionController *vc = [[MyProductionController alloc] init];
    SupplyListController *BuyerVc = [[SupplyListController alloc] init];
    OfferController *offerVC=[[OfferController alloc] init];
    switch (sender.tag) {
        case 1864:
            [self.navigationController pushViewController:vc animated:YES];
            break;
        case 1865:
            [self.navigationController pushViewController:BuyerVc animated:YES];
            break;
        case 1866:
            [self.navigationController pushViewController:offerVC animated:YES];
            break;
        default:
            break;
    }
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}






@end









