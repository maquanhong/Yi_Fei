//
//  SystemSettingViewController.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/29.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "SystemSettingViewController.h"
#import "PureLayout.h"
#import "SystemSettingCell.h"
#import "TemplateOne.h"
#import "NSBundle+Language.h"
#import "BUYHomeControl.h"
#import "NavigationControl.h"
#import "EditPassWordViewController.h"

@interface SystemSettingViewController ()<UITableViewDelegate, UITableViewDataSource,SSPopupDelegate>
{
    SystemSettingCell *cell;
}
@property (nonatomic, strong) UITableView  *systemTableView;
@property (nonatomic, strong) NSArray    *menuArray;
@property (nonatomic, strong) NSArray    *contentArray;

@property (nonatomic,strong) NSString *language;
@property (nonatomic,strong) NSString *accountProtectionState;
@property (nonatomic,strong) NSString *messageReminderState;

@end

@implementation SystemSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _menuArray = @[@{@"语言选择":@[@"中文"]},
                   @{@"账号":@[@"手机号码修改"]},
                   @{@"安全":@[@"账号保护",@"密码修改",@"消息提醒修改"]},
                   @{@"更多":@[@"数据备份",@"商品模板",@"更换皮肤"]}
                   ];
    _systemTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    _systemTableView.delegate = self;
    _systemTableView.dataSource = self;
    _systemTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.systemTableView];
    _systemTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addViewConstraints];
    [self createNavigationView];
}



#pragma mark 创建navgationView
-(void)createNavigationView
{
    self.navigationItem.title = @"系统设置";
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = [self.menuArray objectAtIndex:indexPath.section];
    NSString *title = [[dic allKeys] firstObject];
    static NSString *identify = @"systemCell";
    cell  = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SystemSettingCell" owner:self options:nil] lastObject];
    }
    if (indexPath.section == 0) {
    cell.labelOne.text =  [_menuArray[indexPath.section] objectForKey:title][indexPath.row];
    cell.labelTwo.text = @"默认";
    cell.labelThree.hidden = YES;
        cell.tag = 1005;
    cell.backView.hidden = YES;
    }else if (indexPath.section == 1){
    cell.labelOne.text =  [_menuArray[indexPath.section] objectForKey:title][indexPath.row];
    cell.labelTwo.hidden = YES;
    cell.labelThree.hidden = YES;
    cell.backView.hidden = YES;
    
    }else if (indexPath.section == 2){
    cell.labelOne.text =  [_menuArray[indexPath.section] objectForKey:title][indexPath.row];
    cell.labelTwo.hidden = YES;
        if (indexPath.row == 0) {
    cell.labelThree.text = @"未开启";
        }else if (indexPath.row == 2){
     cell.labelThree.text = @"提醒";
        }else{
    cell.labelThree.hidden = YES;
        }
    cell.backView.hidden = NO;
        
    }else if (indexPath.section == 3){
    cell.labelOne.text =  [_menuArray[indexPath.section] objectForKey:title][indexPath.row];
    cell.labelTwo.hidden = YES;
    cell.labelThree.hidden = YES;
    cell.backView.hidden = NO;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    }else{
        return 44;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary *dic = [self.menuArray objectAtIndex:section];
    NSString *title = [[dic allKeys] firstObject];
        UIView *headerView =  [self infoSendTableView:title];
        return headerView;
}

- (UIView *)infoSendTableView:(NSString *)title {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    [headView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(headView).offset(15);
        make.centerY.mas_equalTo(headView.mas_centerY);
        make.height.mas_equalTo(20);
    }];
    return headView;
}

-(CGFloat)tableView:(UITableView  *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 3) {
        if (indexPath.row == 1) {
        TemplateOne  *tempVC = [[TemplateOne alloc] init];
        [self.navigationController pushViewController:tempVC animated:YES];
        }
    }else if (indexPath.section == 0){
        if (indexPath.row == 0) {
            [self clickSecontionOneView];
        }
    }
    
    
    
    
    if (indexPath.section == 2) {
        if (indexPath.row ==1) {
            EditPassWordViewController *editVc = [[EditPassWordViewController alloc]init];
            [self.navigationController pushViewController:editVc animated:YES];
        }
    }
    
    
    if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            UIAlertController *actro = [UIAlertController alertControllerWithTitle:@"账号保护" message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"开启" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"未开启" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [actro addAction:action1];
            [actro addAction:action2];
            [self presentViewController:actro animated:YES completion:nil];
            
            
            
            
            
        }
    }

    
    
    
    if (indexPath.section == 2) {
        if (indexPath.row == 2) {
            
            UIAlertController *actro = [UIAlertController alertControllerWithTitle:@"请修改消息提醒" message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"提醒" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"不提醒" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [actro addAction:action1];
            [actro addAction:action2];
            [self presentViewController:actro animated:YES completion:nil];
            
            
            
        }
    }
    
    
    if (indexPath.section == 3) {
        if (indexPath.row == 1) {
            TemplateOne  *tempVC = [[TemplateOne alloc] init];
            [self.navigationController pushViewController:tempVC animated:YES];
        }
    }
    
    
}



-(void)clickSecontionOneView{
    NSArray *language = @[@"中文",@"English"];
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = language.count;
    selection.frame = CGRectMake(0,0,WIDTH,HEIGHT);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:language withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        SystemSettingCell *firstCell = [self.view viewWithTag:1005];
        firstCell.labelOne.text =language[tag];
        if ([language[tag] isEqualToString:@"English"]) {
         [self changeLanguageTo:@"en"];
        }else{
         [self changeLanguageTo:@"zh-Hans"];
        }
    }];
}

- (void)changeLanguageTo:(NSString *)language {
    // 设置语言
    [NSBundle setLanguage:language];
    // 然后将设置好的语言存储好，下次进来直接加载
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:@"myLanguage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    BUYHomeControl *myVC = [[ BUYHomeControl alloc] init];
    NavigationControl *nav = [[NavigationControl alloc] initWithRootViewController:myVC];
    [UIApplication sharedApplication].keyWindow.rootViewController = nav;
}

























//系统设置

- (void)setEditStatusWith:(NSString *)language accountProtectionState:(NSString *)accountProtectionState messageReminderState:(NSString *)messageReminderState{
    //     获取token
    NSUserDefaults *tokenDeful = [NSUserDefaults standardUserDefaults];
    NSString *token = [tokenDeful objectForKey:@"token"];
    
    NSString *str=@"/easyfair-webservice/sysExhibition/getExhibitionList";
    NSString *urlStrinx=[NSString stringWithFormat:@"%@%@",Website,str];
    
    NSDictionary  *dicDay= @{
                             @"token": token,
                             @"userType": @"ch",
                             @"language": language,
                             @"accountProtectionState": accountProtectionState,
                             @"messageReminderState":messageReminderState
                             };
    
    [[NetWorkingManager getManager]POST:urlStrinx parameters:dicDay success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            
            
            
        }
        
        
        
    }
     
     
                                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                    
                                    
                                }];
    
    
    
}






































@end















