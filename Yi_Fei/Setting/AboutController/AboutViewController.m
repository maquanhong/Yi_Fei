//
//  AboutViewController.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/28.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "AboutViewController.h"
#import "PureLayout.h"
#import "UserList.h"
#import "UserModel.h"
#import "UserDefaultManager.h"

@interface AboutViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UserModel *oneModel;
}

@property (nonatomic, strong) UITableView *aboutTableView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel     *versionLabel;
@property (nonatomic, strong) NSArray     *menuArray;

@end

@implementation AboutViewController



- (void)setNav {
    
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftBtn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=leftBtnItem;
}

- (void)leftButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self setNav];
    self.title = @"关于EasyFair";
    _menuArray = @[@"功能介绍",@"系统通知",@"联系客服",@"检查新版本"];
    NSInteger height;
    if (WIDTH == 414) {
        height = 320;
    }else if (WIDTH == 375){
     height = 230;
    }else{
    height = 140;
    }
    _aboutTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - height) style:UITableViewStylePlain];
    _aboutTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _aboutTableView.dataSource = self;
    _aboutTableView.delegate = self;
    self.aboutTableView.scrollEnabled = NO;
    [self.view addSubview:self.aboutTableView];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 150)];
    headerView.backgroundColor = INTERFACECOLOR;
    _logoImageView = [[UIImageView alloc] init];
    _logoImageView.layer.cornerRadius = 5;
     _logoImageView.layer.masksToBounds = YES;
    [headerView addSubview:self.logoImageView];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView.mas_centerX);
        make.centerY.equalTo(headerView.mas_centerY).offset(-10);
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
        _logoImageView.image = [UIImage imageWithContentsOfFile:imagePath];
    }else{
        _logoImageView.image = [UIImage imageNamed:@"Null"];
    }
    _versionLabel = [[UILabel alloc] init];
    _versionLabel.font = [UIFont systemFontOfSize:14];
    _versionLabel.textAlignment = NSTextAlignmentCenter;
    _versionLabel.textColor = BACKCOLOR;
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    _versionLabel.text =  [NSString stringWithFormat:@"v%@",version];
    [headerView addSubview:_versionLabel];
    [_versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_logoImageView.mas_centerX);
        make.top.mas_equalTo(_logoImageView.mas_bottom).offset(10);
        make.height.mas_equalTo(15);
    }];
    self.aboutTableView.tableHeaderView = headerView;
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"使用条款和隐私政策";
    titleLabel.textColor = BACKCOLOR;
    titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:titleLabel];
[titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-80);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *companyLabel = [[UILabel alloc] init];
    companyLabel.text = @"某某公司所有";
    companyLabel.textColor = [UIColor grayColor];
    companyLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:companyLabel];
[companyLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(titleLabel);
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(15);
    }];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menuArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = [self.menuArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [cell addSubview:view];
    [view  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cell.mas_bottom);
        make.leading.equalTo(cell);
        make.trailing.equalTo(cell);
        make.height.mas_equalTo(1);
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}











@end












