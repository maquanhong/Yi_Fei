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


@interface SettingTableViewController ()

@property (nonatomic, strong) NSArray  *menuArray;
@property (nonatomic, strong) NSArray  *menuImageArray;
@property (nonatomic, strong) UIImage  *navBackgroundImage;

@end

@implementation SettingTableViewController

-(UIImage*)createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 10.0f, 10.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

-(void)createNavigationView
{
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)leftButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController.navigationBar setBackgroundImage:self.navBackgroundImage forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationView];
    self.title = @"账号";
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeTop;
//    self.view.frame = CGRectMake(0, -64, WIDTH, HEIGHT);
    self.navBackgroundImage = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    _menuArray = @[@"基本资料",@"申请付费会员",@"我的二维码",@"关于EasyFair",@"系统设置",@"退出登录"];
    _menuImageArray = @[@"jibenziliao_icon.png",@"huiyuan_icon.png",@"erweima_icon.png",@"guanyu_icon.png",@"shezhi_icon.png",@"tuichu_icon.png"];
    UserInfoView *infoView = [[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
    infoView.backgroundImageView.image = [UIImage coreBlurImage:[UIImage imageNamed:@"logo.png"] withBlurNumber:0.3];
    infoView.logoImageView.image = [UIImage imageNamed:@"logo.png"];
    infoView.nameLabel.text = @"杭州百倍云科技有限公司";
    infoView.levelLabel.text = @"会员类型：白金会员 等级：2";
    self.tableView.tableHeaderView = infoView;

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [self.menuArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 24 / 2)];
    view.backgroundColor = UIColorFromRGB(0xeeeeee);
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 24 / 2)];
    view.backgroundColor = UIColorFromRGB(0xeeeeee);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8;
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
            [self.navigationController.navigationBar setBackgroundImage:self.navBackgroundImage forBarMetrics:UIBarMetricsDefault];
            [self.navigationController pushViewController:basicInfoVc animated:YES];
            break;
        }
        case 1: {
            ApplyMemBerController *memberVc = [[ApplyMemBerController alloc] init];
            [self.navigationController.navigationBar setBackgroundImage:self.navBackgroundImage forBarMetrics:UIBarMetricsDefault];
            [self.navigationController pushViewController:memberVc animated:YES];
            break;
        }
            

        case 2: {
            IdentifyViewController *identifyVc = [[IdentifyViewController alloc] init];
                [self.navigationController.navigationBar setBackgroundImage:self.navBackgroundImage forBarMetrics:UIBarMetricsDefault];
            [self.navigationController pushViewController:identifyVc animated:YES];
            break;
        }
        case 3: {
            AboutViewController *aboutVc = [[AboutViewController alloc] init];
                [self.navigationController.navigationBar setBackgroundImage:self.navBackgroundImage forBarMetrics:UIBarMetricsDefault];
            [self.navigationController pushViewController:aboutVc animated:YES];
            break;
        }
        case 4: {
        SystemSettingViewController *systemVC = [[SystemSettingViewController alloc] init];
            [self.navigationController.navigationBar setBackgroundImage:self.navBackgroundImage forBarMetrics:UIBarMetricsDefault];
            [self.navigationController pushViewController:systemVC animated:YES];
            break;
        }
        default:
            break;
    }
}









@end








