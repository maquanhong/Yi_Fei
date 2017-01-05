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

#import "UserInfoModel.h"

@interface SettingTableViewController (){
 UserModel *oneModel;
}

@property (nonatomic, strong) NSArray  *menuArray;
@property (nonatomic, strong) NSArray  *menuImageArray;
@property (nonatomic, strong) UIImage  *navBackgroundImage;


@property (nonatomic,strong) UserInfoView *headerView;
@property (nonatomic,strong) UserInfoModel *model;
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
    [self getData];
}

//数据的加载
-(void)loadData{
    //获取单例对象
    UserList *manager = [UserList defaultManager];
    oneModel = [[ UserModel alloc] init];
    NSString *strOne = [UserDefaultManager getDataByKey:@"name"];
    NSString *strTwo = [UserDefaultManager getDataByKey:@"link"];
    oneModel = [manager getDataName:strOne and:strTwo];
    
    self.headerView = [[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 180)];
    _headerView.logoImageView.layer.cornerRadius = 5;
    _headerView.logoImageView.layer.masksToBounds = YES;
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    if (oneModel.picture.length > 0) {
        NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",oneModel.picture]];
        _headerView.backgImageView.image  = [UIImage imageWithContentsOfFile:imagePath];
    _headerView.logoImageView.image = [UIImage imageWithContentsOfFile:imagePath];
    }else{
    _headerView.backgImageView.image = [UIImage imageNamed:@"h1"];
    _headerView.logoImageView.image = [UIImage imageNamed:@"h1"];
    }
    _headerView.nameLabel.text = oneModel.name;
//    headerView.levelLabel.text = @"会员类型: 白金会员  等级: 2";
    self.tableView.tableHeaderView = _headerView;
    
    BackButton *btn = [[BackButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    [_headerView addSubview:btn];
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
            basicInfoVc.model = self.model;
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
        }case 5: {
           
            [self.navigationController popToRootViewControllerAnimated:YES];
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





- (void)getData{
    
    NSString *str=@"/easyfair-webservice/user/getBasicInfo";
    NSString *urlStrinx=[NSString stringWithFormat:@"%@%@",Website,str];
    
    //     获取token
    NSUserDefaults *tokenDeful = [NSUserDefaults standardUserDefaults];
    NSString *token = [tokenDeful objectForKey:@"token"];
    
    //全部回复
    NSDictionary  *dicDay=@{
        @"token": token,
        @"userType": @"ch"
    };
    
    
    [[NetWorkingManager getManager]POST:urlStrinx parameters:dicDay success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject[@"code"]isEqualToString:@"200"]) {
          
            self.model = [[UserInfoModel alloc]init];
            _model.companyName = responseObject[@"userInfo"][@"companyName"];
            _model.companySize = responseObject[@"userInfo"][@"companySize"];
            _model.contactPhone = responseObject[@"userInfo"][@"contactPhone"];
            _model.email = responseObject[@"userInfo"][@"email"];
            _model.industryType = responseObject[@"userInfo"][@"industryType"];
            _model.logo = responseObject[@"userInfo"][@"logo"];
            _model.mainBussiness = responseObject[@"userInfo"][@"mainBussiness"];
            _model.mainProduct = responseObject[@"userInfo"][@"mainProduct"];
            _model.vipLevel = responseObject[@"userInfo"][@"vipLevel"];
            
            _model.vipType = responseObject[@"userInfo"][@"vipType"];
            
            _model.website = responseObject[@"userInfo"][@"website"];
            
            _model.jobTitle = responseObject[@"userInfo"][@"jobTitle"];
            
            _model.contactPerson = responseObject[@"userInfo"][@"contactPerson"];
            
            _model.address = responseObject[@"userInfo"][@"address"];
            
            
            
            NSString *string = [NSString stringWithFormat:@"会员类型: %@  等级: %@", _model.vipType,_model.vipLevel];
            _headerView.levelLabel.text = string;
        }else{
            UIAlertController *actro = [UIAlertController alertControllerWithTitle:@"提示" message:responseObject[@"message"] preferredStyle:(UIAlertControllerStyleAlert)];
            [self presentViewController:actro animated:YES completion:nil];
            
            [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(creatAlertg:) userInfo:actro repeats:NO];
            
            
            
        }
        
    }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                    
                                    
            }];
    
    
}


- (void)creatAlertg:(NSTimer *)timer{
    UIAlertController *alert = [timer userInfo];
    [alert dismissViewControllerAnimated:YES completion:nil];
    alert = nil;
}



@end








