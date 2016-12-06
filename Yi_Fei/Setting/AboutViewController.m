//
//  AboutViewController.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/28.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "AboutViewController.h"
#import "PureLayout.h"
@interface AboutViewController ()<UITableViewDelegate, UITableViewDataSource>
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
    [self setNav];
    self.title = @"关于EasyFair";
    _menuArray = @[@"功能介绍",@"系统通知",@"帮助与反馈",@"检查新版本"];
    _aboutTableView = [[UITableView alloc] initForAutoLayout];
    _aboutTableView.dataSource = self;
    _aboutTableView.delegate = self;
    [self.view addSubview:self.aboutTableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
    _logoImageView = [[UIImageView alloc] initForAutoLayout];
    [headerView addSubview:self.logoImageView];
    self.logoImageView.contentMode = UIViewContentModeCenter;
    _versionLabel = [[UILabel alloc] initForAutoLayout];
    self.versionLabel.textAlignment = NSTextAlignmentCenter;
    self.versionLabel.backgroundColor = [UIColor clearColor];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    self.versionLabel.text = version;
    [headerView addSubview:self.versionLabel];
    self.aboutTableView.tableHeaderView = headerView;
    self.aboutTableView.tableFooterView = [[UIView alloc] init];
    [self addViewConstraints];
    // Do any additional setup after loading the view.
}

- (void)addViewConstraints {
    [self.aboutTableView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.aboutTableView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.aboutTableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.aboutTableView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    
    [self.logoImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:80];
    [self.logoImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.logoImageView autoSetDimension:ALDimensionWidth toSize:100];
    [self.logoImageView autoSetDimension:ALDimensionHeight toSize:100];
    
    [self.versionLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.versionLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.logoImageView withOffset:5];
    [self.versionLabel autoSetDimension:ALDimensionWidth toSize:WIDTH];
    [self.versionLabel autoSetDimension:ALDimensionHeight toSize:15];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menuArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = [self.menuArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
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
