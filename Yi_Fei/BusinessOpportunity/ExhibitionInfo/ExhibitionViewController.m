//
//  ConferenceInfoViewController.m
//  YiFei
//
//  Created by maquanhong on 10/20/16.
//  Copyright © 2016 yous. All rights reserved.
//

#import "ExhibitionViewController.h"
#import "PureLayout.h"
#import "ExhibitionViewCell.h"
#import "ExhibitionDeatailController.h"

@interface ExhibitionViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView  *tableView;

@property (nonatomic, strong) NSArray    *conferenceInfoArray;

@end

@implementation ExhibitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createNavigationView];
    _conferenceInfoArray = @[@{@"title":@"2017年波兰设备照明展",@"time":@"2016-12-30"},@{@"title":@"2017年波兰设备照明展",@"time":@"2016-12-30"},@{@"title":@"2017年波兰设备照明展",@"time":@"2016-12-30"},@{@"title":@"2017年波兰设备照明展",@"time":@"2016-12-30"},@{@"title":@"2017年波兰设备照明展",@"time":@"2016-12-30"},@{@"title":@"2017年波兰设备照明展",@"time":@"2016-12-30"},@{@"title":@"2017年波兰设备照明展",@"time":@"2016-12-30"},@{@"title":@"2017年波兰设备照明展",@"time":@"2016-12-30"},@{@"title":@"2017年波兰设备照明展",@"time":@"2016-12-30"}];
    [self.view addSubview:self.conferenceInfoTableView];
    [self addViewConstraints];
}

#pragma mark - 设置导航条
-(void)createNavigationView
{
    self.navigationItem.title = @"展会信息";
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
    [self.conferenceInfoTableView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.conferenceInfoTableView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.conferenceInfoTableView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.conferenceInfoTableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.conferenceInfoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString  *cellIdentify = @"ExhibitionCell";
    ExhibitionViewCell *cell = (ExhibitionViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[ExhibitionViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    NSDictionary *dic = [self.conferenceInfoArray objectAtIndex:indexPath.row];
    cell.dict = [NSDictionary dictionaryWithDictionary:dic];
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (UITableView *)conferenceInfoTableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initForAutoLayout];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] initForAutoLayout];
    }
    return _tableView;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ExhibitionDeatailController *detailVC = [[ExhibitionDeatailController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}



















@end



















