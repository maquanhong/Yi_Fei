//
//  offerViewController.m
//  YiFei
//  Created by yangyan on 16/9/9.
//  Copyright © 2016年 yous. All rights reserved.



#import "offerViewController.h"
#import "BUYButton.h"
#import "BuyerViewController.h"
#import "ClientViewController.h"
#import "SalerViewController.h"
#import "NewCreateClientTableViewController.h"
@interface offerViewController ()
@property(nonatomic,strong)NSArray *titleArray;
@property (nonatomic, assign) BussinessType type;
@end

@implementation offerViewController

- (instancetype)initWithIdType:(BussinessType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTool];
    if (self.type == BussinessBuyer) {
        self.title = @"询价";
    }else {
        self.title = @"报价";
    }
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self addContentView];
}

- (void)setNavTool
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

-(void)addContentView{
    if (self.type == BussinessBuyer) {
       _titleArray=@[@"供应商",@"新建供应商"];
    } else {
        _titleArray=@[@"客户",@"新建客户"];
    }
    
    for (int i=0; i<_titleArray.count; i++) {
        UIButton *button=[BUYButton creatBtnWithBgColor:NAVCOLOR borderColor:NAVCOLOR borderWidth:0 titleColor:[UIColor whiteColor] text:[self.titleArray objectAtIndex:i]];
        [button sizeToFit];
        button.tag = 1000 + i;
        button.frame=CGRectMake(10, 64+10+60*i + 30 * i, WIDTH-20, 60);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

-(void)buttonClick:(UIButton *)sender{
    NSInteger index = sender.tag - 1000;
    if (self.type == BussinessBuyer) {
        if (index == 1) {
            NewCreateClientTableViewController *clientVc = [[NewCreateClientTableViewController alloc] init];
            [self.navigationController pushViewController:clientVc animated:YES];
        } else if (index == 0) {
            SalerViewController *salerVc = [[SalerViewController alloc] init];
            [self.navigationController pushViewController:salerVc animated:YES];
        }
    } else {
        if (index == 0) {
            ClientViewController *clientVc = [[ClientViewController alloc] init];
            [self.navigationController pushViewController:clientVc animated:YES];
        } else if (index == 1) {
            BuyerViewController *buyerVc = [[BuyerViewController alloc] initWithTypeId:BussinessSaler];
            [self.navigationController pushViewController:buyerVc animated:YES];
        }
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
