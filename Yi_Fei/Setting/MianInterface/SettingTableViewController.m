//
//  SettingTableViewController.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/23.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "SettingTableViewController.h"
#import "IconContenTableVIewCell.h"
#import "UserInfoView.h"
#import "PureLayout.h"
#import "UIImage+Tool.h"
#import "BasicInfoTableViewController.h"
#import "AboutViewController.h"
#import "IdentifyViewController.h"
#import "ApplyMemBerController.h"
#import "SystemSettingViewController.h"
#import "UserModel.h"
#import "UserList.h"
#import "UserDefaultManager.h"


@interface SettingTableViewController (){
 UserModel *oneModel;
}

@property (nonatomic, strong) NSArray  *menuArray;
@property (nonatomic, strong) NSArray  *menuImageArray;
@property (nonatomic, strong) UIImage  *navBackgroundImage;

@end

@implementation SettingTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.scrollEnabled = NO;
    self.view.backgroundColor = UIColorFromRGB(0xeeeeee);
    self.navBackgroundImage = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    _menuArray = @[@"基本资料",@"申请付费会员",@"我的二维码",@"关于EasyFair",@"系统设置",@"退出登录"];
    _menuImageArray = @[@"jibenziliao_icon.png",@"huiyuan_icon.png",@"erweima_icon.png",@"guanyu_icon.png",@"shezhi_icon.png",@"tuichu_icon.png"];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self loadData];
}

//数据的加载
-(void)loadData{
    //获取单例对象
    UserList *manager = [UserList defaultManager];
    //可变数组初始化
    oneModel = [[ UserModel alloc] init];
    NSString *str = [UserDefaultManager getDataByKey:@"link"];
    oneModel = [manager getDataWith:str];
    
    UserInfoView *headerView = [[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 180)];
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    if (oneModel.picture.length > 0) {
        NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",oneModel.picture]];
        headerView.backgImageView.image  = [UIImage imageWithContentsOfFile:imagePath];
        headerView.logoImageView.image = [UIImage imageWithContentsOfFile:imagePath];
    }else{
    headerView.backgImageView.image = [UIImage imageNamed:@"h1"];
    headerView.logoImageView.image = [UIImage imageNamed:@"h1"];
    }
    headerView.nameLabel.text = oneModel.name;
    headerView.levelLabel.text = @"会员类型: 白金会员  等级: 2";
    self.tableView.tableHeaderView = headerView;
    
    BackButton *btn = [[BackButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    [headerView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).offset(10);
        make.top.mas_equalTo(self.view.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    [btn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
}


- (void)leftButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [self.menuArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 8)];
    view.backgroundColor = UIColorFromRGB(0xeeeeee);
        return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.00000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2 || section == 4) {
          return 8;
    }else{
        return 2;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static  NSString *cellIdentify = @"settingcell";
    IconContenTableVIewCell *cell = (IconContenTableVIewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[IconContenTableVIewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.titleLabel.text = [self.menuArray objectAtIndex:indexPath.section];
    cell.iconImageView.image = [UIImage imageNamed:[self.menuImageArray objectAtIndex:indexPath.section]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0: {
            BasicInfoTableViewController *basicInfoVc = [[BasicInfoTableViewController alloc] init];
            [self.navigationController pushViewController:basicInfoVc animated:YES];
            break;
        }
        case 1: {
            ApplyMemBerController *memberVc = [[ApplyMemBerController alloc] init];
            [self.navigationController pushViewController:memberVc animated:YES];
            break;
        }
            

        case 2: {
            IdentifyViewController *identifyVc = [[IdentifyViewController alloc] init];
            [self.navigationController pushViewController:identifyVc animated:YES];
            break;
        }
        case 3: {
            AboutViewController *aboutVc = [[AboutViewController alloc] init];
    
            [self.navigationController pushViewController:aboutVc animated:YES];
            break;
        }
        case 4: {
        SystemSettingViewController *systemVC = [[SystemSettingViewController alloc] init];

            [self.navigationController pushViewController:systemVC animated:YES];
            break;
        }
        default:
            break;
    }
}




- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}




@end








