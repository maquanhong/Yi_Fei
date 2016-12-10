//
//  SystemSettingViewController.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/29.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "SystemSettingViewController.h"
#import "PureLayout.h"

@interface SystemSettingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView  *systemTableView;
@property (nonatomic, strong) NSArray    *menuArray;
@end

@implementation SystemSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _menuArray = @[@{@"语言选择":@[@"中文"]},
                   @{@"账号":@[@"手机号码修改"]},
                   @{@"安全":@[@"账号保护",@"密码修改",@"消息提醒修改"]},
                   @{@"更多":@[@"数据备份",@"商品模板",@"更换皮肤"]}
                   ];
    _systemTableView = [[UITableView alloc] initForAutoLayout];
    [self.view addSubview:self.systemTableView];
    [self addViewConstraints];
    // Do any additional setup after loading the view.
}

- (void)addViewConstraints {
    [self.systemTableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.systemTableView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.systemTableView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.systemTableView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.menuArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic = [self.menuArray objectAtIndex:section];
    NSString *title = [[dic allKeys] firstObject];
    NSArray *subMenuArray = [dic objectForKey:title];
    return [subMenuArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *dic = [self.menuArray objectAtIndex:section];
    NSString *title = [[dic allKeys] firstObject];
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    NSDictionary *dic = [self.menuArray objectAtIndex:indexPath.section];
    NSString *title = [[dic allKeys] firstObject];
    NSArray *subMenuArray = [dic objectForKey:title];
    cell.textLabel.text = [subMenuArray objectAtIndex:indexPath.row];
    return cell;
}













@end















